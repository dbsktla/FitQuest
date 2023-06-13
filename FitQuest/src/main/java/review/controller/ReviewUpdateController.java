package review.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import gym.model.GymDao;
import member.model.MemberBean;
import member.model.MemberDao;
import review.model.ReviewBean;
import review.model.ReviewDao;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;

@Controller
public class ReviewUpdateController {
	private final String command = "updateMyReview.mb";
	private final String getPage = "myReviewUpdateForm";
	private final String gotoPage = "redirect:/viewMyReviewList.mb";
	
	@Autowired
	ReviewDao reviewDao;
	@Autowired
	TrainerDao trainerDao;
	@Autowired
	MemberDao memberDao;
	@Autowired
	GymDao gymDao;
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(@RequestParam("renum") int renum, 
						   Model model,
						   @RequestParam("mid") String mid) {
		ReviewBean reviewBean = reviewDao.getReviewByRenum(renum);
		MemberBean memberBean = memberDao.selectMemberById(mid);
		System.out.println(reviewBean.getTid());
		TrainerBean trainerBean = trainerDao.getTrainerMember(reviewBean.getTid());
		model.addAttribute("reviewBean", reviewBean);
		model.addAttribute("memberBean", memberBean);
		model.addAttribute("tmemberBean", memberDao.selectMemberById(trainerBean.getId()));
		model.addAttribute("trainerBean", trainerBean);
		model.addAttribute("gymBean", gymDao.selectGym(trainerBean.getGnum()));
		return getPage;
	}
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String doAction(@ModelAttribute("reviewBean") @Valid ReviewBean reviewBean,
						   BindingResult result,
						   Model model) {
		if(result.hasErrors()) {
			return getPage;
		} else {
			int cnt = reviewDao.updateReview(reviewBean);
			if(cnt > 0) {
				System.out.println("리뷰 수정 성공");
			}
		}
		return gotoPage;
	}
}
