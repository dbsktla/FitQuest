package review.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;
import review.model.ReviewBean;
import review.model.ReviewDao;

@Controller
public class ReviewDetailController {
	private final String command = "reviewDetail.mb";
	private final String getPage= "trainerReviewDetail";
	
	@Autowired
	ReviewDao reviewDao;
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(value = command)
	public String doAction(@RequestParam("renum") int renum,
						   @RequestParam("mid") String mid,
						   HttpSession session,
						   Model model) {
		MemberBean memberBean = memberDao.selectMemberById(mid);
		ReviewBean reviewBean = reviewDao.getReviewByRenum(renum);
		model.addAttribute("reviewBean", reviewBean);
		model.addAttribute("memberBean", memberBean);
		return getPage;
	}
}
