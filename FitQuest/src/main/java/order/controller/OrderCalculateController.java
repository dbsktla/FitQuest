package order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gym.model.GymBean;
import gym.model.GymDao;
import member.model.MemberBean;
import member.model.MemberDao;
import order.model.OrderDao;
import orderdetail.model.OrderDetailDao;
import product.model.MyShoppingBean;
import product.model.ProductBean;
import product.model.ProductDao;
import review.model.ReviewDao;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;
import usage.model.UsageBean;
import usage.model.UsageDao;
@Controller
public class OrderCalculateController {
	private final String command = "cartCalculate.od";
	private final String getPage = "orderComplete";
	@Autowired
	ProductDao productDao;
	@Autowired
	OrderDetailDao orderDetailDao;
	@Autowired
	OrderDao orderDao;
	@Autowired
	UsageDao usageDao;
	@Autowired
	MemberDao memberDao;
	@Autowired
	TrainerDao trainerDao;
	@Autowired
	GymDao gymDao;
	@Autowired
	ReviewDao reviewDao;

	@RequestMapping(value = command)
	public String doAction(@RequestParam("pnum") int[] pnumArr,
			Model model,
			HttpSession session) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		int totalAmount = 0;
		boolean flag2 = (Boolean)session.getAttribute("flag2");
		if(flag2 == true) {
			int cnt = orderDao.insertOrder(memberBean.getId());
			int orderNum = orderDao.selectOrderNum(memberBean.getId());
			if(cnt > -1) {
				for(int i = 0; i < pnumArr.length; i++) {
					int pnum = pnumArr[i];
					Map<String, Integer> odMap = new HashMap<String, Integer>();
					odMap.put("pnum", pnum);
					odMap.put("onum", orderNum);
					int cnt2 = orderDetailDao.insertOrderDetail(odMap);
					System.out.println("cnt2: " + cnt2);
					if(cnt2 > -1) {
						ProductBean productBean = productDao.getProductByPnum(pnum);
						String tid = productDao.getIdByPnum(pnum);
						UsageBean usageBean = new UsageBean();
						usageBean.setMid(memberBean.getId());
						System.out.println(tid);
						usageBean.setTid(tid);
						usageBean.setOnum(orderNum);
						usageBean.setPnum(pnum);
						usageBean.setUsage(productBean.getPcount());
						int cnt3 = usageDao.insertUsage(usageBean);
						if(cnt3 > -1) {
								session.setAttribute("cartList", null);
								session.setAttribute("flag2", false);
						}
						}
					}
				}
			}
		ArrayList<MyShoppingBean> sList = new ArrayList<MyShoppingBean>();
		int orderNum2 = orderDao.selectOrderNum(memberBean.getId());
		List<Integer> pList = orderDetailDao.getPnumList(orderNum2);
		for(int pnum2 : pList) {
			String tid2 = productDao.getIdByPnum(pnum2);
			TrainerBean trainerBean = trainerDao.getTrainer(tid2);
			MemberBean memberBean2 = memberDao.selectMemberById(tid2);
			GymBean gymBean = gymDao.selectGym(trainerBean.getGnum());
			ProductBean productBean2 = productDao.getProductByPnum(pnum2);
			String hasReview = reviewDao.getHasReviewById(tid2);
			double rating = 0.0;
			if(hasReview.equals("Y")) {
				rating = reviewDao.getAverageReviewScore(tid2);
			}
			MyShoppingBean msBean = new MyShoppingBean();
			msBean.setTid(tid2);
			msBean.setTname(memberBean2.getName());
			msBean.setActivity(trainerBean.getActivity());
			msBean.setPurpose(trainerBean.getPurpose());
			msBean.setTimage(trainerBean.getTimage());
			msBean.setGname(gymBean.getGname());
			msBean.setGaddr1(gymBean.getGaddr1());
			msBean.setGaddr2(gymBean.getGaddr2());
			msBean.setPnum(productBean2.getPnum());
			msBean.setPrice(productBean2.getPrice());
			msBean.setMonths(productBean2.getMonths());
			msBean.setPcount(productBean2.getPcount());
			msBean.setPtype(productBean2.getPtype());
			msBean.setPtime(productBean2.getPtime());
			msBean.setPeople(productBean2.getPeople());
			msBean.setRating(rating);
			msBean.setHasReview(hasReview);
			sList.add(msBean);
			totalAmount += productBean2.getPrice();
		}
		model.addAttribute("sList", sList);
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("orderNum", orderNum2);
		model.addAttribute("orderCount", pnumArr.length);
		return getPage;
	}
}