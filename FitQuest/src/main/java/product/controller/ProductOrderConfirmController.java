package product.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gym.model.GymBean;
import gym.model.GymDao;
import member.model.MemberBean;
import member.model.MemberDao;
import product.model.MyShoppingBean;
import product.model.ProductBean;
import product.model.ProductDao;
import review.model.ReviewDao;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;

@Controller
public class ProductOrderConfirmController {
	private final String command = "cartCalculate.pd";
	private final String getPage = "orderConfirm";
	private final String gotoPage = "redirect:/cartList.pd";
	@Autowired
	MemberDao memberDao;
	@Autowired
	ProductDao productDao;
	@Autowired
	TrainerDao trainerDao;
	@Autowired
	GymDao gymDao;
	@Autowired
	ReviewDao reviewDao;
	
	@RequestMapping(value = command)
	public String doAction(Model model,
						   @RequestParam("pnum") int[] pnumArr) {
		ArrayList<MyShoppingBean> sList = new ArrayList<MyShoppingBean>();
		for(int pnum : pnumArr) {
			String tid = productDao.getIdByPnum(pnum);
			TrainerBean trainerBean = trainerDao.getTrainer(tid);
			MemberBean memberBean = memberDao.selectMemberById(tid);
			GymBean gymBean = gymDao.selectGym(trainerBean.getGnum());
			ProductBean productBean = productDao.getProductByPnum(pnum);
			String hasReview = reviewDao.getHasReviewById(tid);
			double rating = 0.0;
			if(hasReview.equals("Y")) {
				rating = reviewDao.getAverageReviewScore(tid);
			}
			MyShoppingBean msBean = new MyShoppingBean();
			msBean.setTid(tid);
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
			msBean.setPtime(productBean.getPtime());
			msBean.setPeople(productBean.getPeople());
			msBean.setRating(rating);
			msBean.setHasReview(hasReview);
			sList.add(msBean);

		}
		model.addAttribute("sList", sList);
		return command;
	}
}
