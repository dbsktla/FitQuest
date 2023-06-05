package product.controller;

import java.time.Year;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import composite.model.CompositeDao;
import composite.model.TrainerListBean;
import gym.model.GymBean;
import gym.model.GymDao;
import member.model.MemberBean;
import member.model.MemberDao;
import product.model.ProductBean;
import product.model.ProductDao;
import review.model.ReviewBean;
import review.model.ReviewDao;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;

@Controller
public class ProductDetailController {
	private final String command = "trainerDetail.pd";
	private final String getPage = "trainerDetail";
	
	@Autowired
	TrainerDao trainerDao;
	@Autowired
	GymDao gymDao;
	@Autowired
	ProductDao productDao;
	@Autowired
	ReviewDao reviewDao;
	@Autowired
	MemberDao memberDao;
	@Autowired
	CompositeDao compositeDao;
	
	@RequestMapping(value = command)
	public String doAction(@RequestParam("id") String id, 
						   @RequestParam("pageNumber") String pageNumber,
						   @RequestParam("hasReview") String hasReview,
						   Model model) {
		TrainerBean trainerBean = trainerDao.getTrainer(id);
		MemberBean memberBean = memberDao.selectMemberById(id);
		GymBean gymBean = gymDao.selectGym(trainerBean.getGnum());
		List<ProductBean> pList = productDao.getProductListById(id);
		List<ReviewBean> rList = reviewDao.getReviewListByTid(id);
		List<TrainerListBean> tList = compositeDao.getSimilarTrainerList(trainerBean);
		Collections.shuffle(tList); //랜덤 순서 적용함
		double avgScore = 0.0;
		if(hasReview.equals("Y")) {
			avgScore = reviewDao.getAverageReviewScore(id);
		} 
		model.addAttribute("memberBean", memberBean);
		int birthYear = Integer.parseInt(memberBean.getBirth().substring(0, 4));
		int year = Year.now().getValue();
		model.addAttribute("trainerBean", trainerBean);
		model.addAttribute("gymBean", gymBean);
		model.addAttribute("pList", pList);
		model.addAttribute("rList", rList);
		model.addAttribute("rList", rList);
		model.addAttribute("tList", tList);
		model.addAttribute("avgScore", avgScore);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("age", year - birthYear + 1);
		model.addAttribute("reviewCount", rList.size());
		model.addAttribute("hasReview", hasReview);
		return getPage;
	}
}
