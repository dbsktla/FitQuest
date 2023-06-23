package product.controller;

import java.time.Year;
import java.util.ArrayList;
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
						   @RequestParam(value = "pageNumber", required = false) String pageNumber,
						   @RequestParam("hasReview") String hasReview,
						   Model model) {
		TrainerBean trainerBean = trainerDao.getTrainer(id);
		MemberBean memberBean = memberDao.selectMemberById(id);
		GymBean gymBean = gymDao.selectGym(trainerBean.getGnum());
		List<ProductBean> pList = productDao.getProductListById(id);
		List<ReviewBean> rList = reviewDao.getReviewListByTid(id);
		List<TrainerListBean> tList = new ArrayList<TrainerListBean>();
		
		int trainerCount = trainerDao.getSimilarTrainerCount(trainerBean);
		List<TrainerBean> similarTList = null;
		if(trainerCount > 0) {
			similarTList = trainerDao.getSimilarTrainers(trainerBean);
			//랜덤 순서로 정렬된 비슷한 트레이너 리스트
		}
		for(int i = 0; i < trainerCount; i++) {
			TrainerBean currentTrainer = similarTList.get(i); //랜덤 정렬 리스트 중 하나 씩 가져옴 
			TrainerListBean trainer = new TrainerListBean(); //뷰로 보낼 빈 생성
			GymBean gymBean2 = gymDao.selectGym(currentTrainer.getGnum());
			MemberBean tMemberBean = memberDao.selectMemberById(currentTrainer.getId());
			String hasReview2 = reviewDao.getHasReviewById(currentTrainer.getId());
			double avgRev = 0.0;
			System.out.println(tMemberBean.getId() + " "  + hasReview2);
			if(hasReview2.equals("Y")){
				avgRev = reviewDao.getAverageReviewScore(currentTrainer.getId());
			} 
			trainer.setId(currentTrainer.getId());
			trainer.setGnum(currentTrainer.getGnum());
			trainer.setActivity(currentTrainer.getActivity());
			trainer.setPurpose(currentTrainer.getPurpose());
			trainer.setIntro(currentTrainer.getIntro());
			trainer.setExp(currentTrainer.getExp());
			trainer.setTimage(currentTrainer.getTimage());
			trainer.setRating(avgRev);
			trainer.setGaddr1(gymBean2.getGaddr1());
			trainer.setName(tMemberBean.getName());
			trainer.setHasReview(hasReview2);
			tList.add(trainer);
			if(i == 2) {
				break;
			}
		}
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
