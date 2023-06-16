package order.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gym.model.GymBean;
import gym.model.GymDao;
import member.model.MemberBean;
import member.model.MemberDao;
import order.model.OrderBean;
import order.model.OrderDao;
import orderdetail.model.OrderDetailBean;
import orderdetail.model.OrderDetailDao;
import product.model.MyShoppingBean;
import product.model.ProductBean;
import product.model.ProductDao;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;

@Controller
public class MyOrderDetailController {
	private final String command = "orderDetail.od";
	private final String getPage = "myOrderDetail";
	@Autowired
	OrderDetailDao orderDetailDao;
	@Autowired
	ProductDao productDao;
	@Autowired
	OrderDao orderDao;
	@Autowired
	GymDao gymDao;
	@Autowired
	TrainerDao trainerDao;
	@Autowired 
	MemberDao memberDao;
	@RequestMapping(value = command)
	public String doAction(@RequestParam("onum") int onum, Model model) {
		List<OrderDetailBean> odList = orderDetailDao.getOrderDetailListByOnum(onum);
		OrderBean orderBean = orderDao.getOrderByOnum(onum);
		List<MyShoppingBean> msList = new ArrayList<MyShoppingBean>();
		int orderCount = 0;
		int totalAmount = 0;
		for(OrderDetailBean odBean : odList) {
			int pnum = odBean.getPnum();
			MyShoppingBean msBean = new MyShoppingBean();
			ProductBean productBean = productDao.getProductByPnum(pnum);
			TrainerBean trainerBean = trainerDao.getTrainer(productBean.getId());
			MemberBean memberBean = memberDao.selectMemberById(trainerBean.getId());
			GymBean gymBean = gymDao.selectGym(trainerBean.getGnum());
			msBean.setTid(trainerBean.getId());
			msBean.setTname(memberBean.getName());
			msBean.setActivity(trainerBean.getActivity());
			msBean.setPurpose(trainerBean.getPurpose());
			msBean.setTimage(trainerBean.getTimage());
			msBean.setGname(gymBean.getGname());
			msBean.setGaddr1(gymBean.getGaddr1());
			msBean.setGaddr2(gymBean.getGaddr2());
			msBean.setPnum(productBean.getPnum());
			msBean.setPrice(productBean.getPrice());
			msBean.setMonths(productBean.getMonths());
			msBean.setPcount(productBean.getPcount());
			msBean.setPtype(productBean.getPtype());
			msBean.setPeople(productBean.getPeople());
			msList.add(msBean);
			orderCount += 1;
			totalAmount += productBean.getPrice();
		}
		model.addAttribute("orderBean", orderBean);
		model.addAttribute("msList", msList);
		model.addAttribute("orderCount",orderCount);
		model.addAttribute("totalAmount", totalAmount);
		return getPage;	
	}
}
