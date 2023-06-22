package order.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import composite.model.CompositeDao;
import composite.model.MyOrderBean;
import composite.model.MyUsageBean;
import gym.model.GymBean;
import gym.model.GymDao;
import member.model.MemberBean;
import member.model.MemberDao;
import order.model.OrderDao;
import product.model.ProductBean;
import product.model.ProductDao;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;
import usage.model.UsageBean;
import usage.model.UsageDao;

@Controller
public class MyOrderListController {
	private final String command = "viewMyOrderList.od";
	private final String getPage = "myOrderList";
	@Autowired
	OrderDao orderDao;
	@Autowired
	CompositeDao compositeDao;
	@Autowired
	UsageDao usageDao;
	@Autowired
	GymDao gymDao;
	@Autowired
	TrainerDao trainerDao;
	@Autowired
	MemberDao memberDao;
	@Autowired
	ProductDao productDao;
	@RequestMapping(value = command)
	public String doAction(HttpSession session,
						   HttpServletResponse response,
						   Model model) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo"); 
		response.setContentType("text/html; charset=utf-8");
		session.setAttribute("menubar", "myOrderMain");
		if(memberBean == null) {
			session.setAttribute("destination", "redirect:/viewMyOrderList.od");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/login.mb";
		} else if(!memberBean.getMtype().equals("generic")){
			try {
				response.getWriter().print("<script>alert('비정상적인 접근입니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/main.go";
		}
		List<MyOrderBean> mList = compositeDao.getMyOrderList(memberBean.getId());
		List<UsageBean> uList = usageDao.getAvailableUsageListByMid(memberBean.getId());
		List<MyUsageBean> muList = new ArrayList<MyUsageBean>();
		for(UsageBean uBean : uList) {
			String tid = uBean.getTid();
			int pnum = uBean.getPnum();
			ProductBean productBean = productDao.getProductByPnum(pnum);
			TrainerBean trainerBean = trainerDao.getTrainerMember(tid);
			GymBean gymBean = gymDao.selectGym(trainerBean.getGnum());
			MemberBean tmemberBean = memberDao.selectMemberById(tid);
			MyUsageBean mub = new MyUsageBean();
			mub.setActivity(trainerBean.getActivity());
			mub.setGname(gymBean.getGname());
			mub.setMonths(productBean.getMonths());
			mub.setUsage(uBean.getUsage());
			mub.setName(tmemberBean.getName());
			mub.setPnum(pnum);
			mub.setUnum(uBean.getUnum());
			mub.setPtype(productBean.getPtype());
			mub.setTimage(trainerBean.getTimage());
			mub.setTid(tid);
			muList.add(mub);
		}
		System.out.println(muList.size());
		System.out.println(mList.size());
		model.addAttribute("muList", muList);
		model.addAttribute("mList", mList);
		return getPage;
	}
}
