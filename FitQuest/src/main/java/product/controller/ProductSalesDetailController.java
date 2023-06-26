package product.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import composite.model.CompositeDao;
import composite.model.SalesBean;
import member.model.MemberBean;
import order.model.OrderDao;
import orderdetail.model.OrderDetailDao;
import product.model.ProductBean;
import product.model.ProductDao;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;

@Controller
public class ProductSalesDetailController {
	private final String command = "productSalesDetail.pd";
	private final String getPage = "productSales";
	@Autowired
	ProductDao productDao;
	@Autowired
	OrderDao orderDao;
	@Autowired
	OrderDetailDao orderDetailDao;
	@Autowired
	CompositeDao compositeDao;
	@Autowired
	TrainerDao trainerDao;
	@RequestMapping(value = command)
	public String doAction(HttpSession session,
						   Model model,
						   HttpServletResponse response) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		
		//사이드 바 코드 추가
		session.setAttribute("menubar", "mySalesMain");
		response.setContentType("text/html; charset=utf-8");
		if(memberBean == null) {
			session.setAttribute("destination", "redirect:/trainerDetail.mb");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/login.mb";
		} else if(!memberBean.getMtype().equals("trainer")){
			try {
				response.getWriter().print("<script>alert('비정상적인 접근입니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/main.go";
		}
		TrainerBean trainerBean = trainerDao.getTrainer(memberBean.getId());
		List<SalesBean> weeklySalesList = compositeDao.getWeeklySales(memberBean.getId());
		List<SalesBean> monthlySalesList = compositeDao.getMonthlySales(memberBean.getId());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd ");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM");
		Calendar cal = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();
		Date date = cal.getTime();
		Date date2 = cal2.getTime();
		String[] days = new String[7];
		String[] months = new String[6];
		int[] sales = new int[7];
		int[] monthSales = new int[6];
		days[6] = sdf.format(date);
		months[5] = sdf2.format(date2);
		for(int i = 5; i >= 0; i--){
		    cal.add(Calendar.DAY_OF_MONTH, -1);
		    date = cal.getTime();
		    days[i] = sdf.format(date);
		}
		for(int i = 4 ; i >= 0; i--) {
			cal2.add(Calendar.MONTH, -1);
			date2 = cal2.getTime();
			months[i] = sdf2.format(date2);
		}
		for(String x : months) {
			System.out.println(x);
		}
		for(int i = 0; i < weeklySalesList.size(); i++) {
			SalesBean sb = weeklySalesList.get(i);
			String[] day = sb.getOdate().split(" ");
			for(int j = 0; j < days.length; j++) {
				String comp1 = days[j].trim();
				String comp2 = day[0].trim();
				if(comp1.equals(comp2)) {
					sales[j] = sb.getPrice();
				}
			}
		}
		for(int i = 0; i < monthlySalesList.size();i++) {
			SalesBean sb = monthlySalesList.get(i);
			for(int j = 0; j < months.length;j++) {
				String comp1 = sb.getOdate().trim();
				String comp2 = months[j];
				if(comp1.equals(comp2)) {
					monthSales[j] = monthSales[j] + sb.getPrice();
				}
			}
		}
		for(int i = 0; i < monthSales.length; i++) {
			System.out.println(months[i] + "월의 수입은 " + monthSales[i] + "만원입니다.");
		}
		
		List<SalesBean> totalSales = compositeDao.getTotalSales(memberBean.getId());
		int totalAmount = 0;
		String[] productArr = new String[totalSales.size()];
		int[] productSales = new int[productArr.length];
		for(int i = 0; i < totalSales.size(); i++) {
			SalesBean sb = totalSales.get(i);
			ProductBean pb = productDao.getProductByPnum(sb.getPnum());
			totalAmount += sb.getPrice();
			productSales[i] = sb.getPrice();
			productArr[i] = pb.getPtype() + " " + trainerBean.getActivity() + "수업" + "(" + pb.getMonths() + "개월-레슨" + pb.getPcount() + "회)";
		}
		
		model.addAttribute("days", days);
		model.addAttribute("months", months);
		model.addAttribute("weeklySales", sales);
		model.addAttribute("monthlySales", monthSales);
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("productSales", productSales);
		model.addAttribute("products", productArr);
		model.addAttribute("activity", trainerBean.getActivity());
		return getPage;
	}
}
