package review.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
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
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;

@Controller
public class GenericReviewDetailController {
	private final String command = "viewMyReviewDetail.mb";
	private final String getPage = "memberReviewDetail";
	@Autowired
	TrainerDao trainerDao;
	@Autowired
	ReviewDao reviewDao;
	@Autowired
	MemberDao memberDao;
	@RequestMapping(value = command)
	public String doAction(@RequestParam("renum") int renum,
						   @RequestParam("tid") String tid,
						   Model model,
						   HttpSession session,
						   HttpServletResponse response) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo"); 
		response.setContentType("text/html; charset=utf-8");
		if(memberBean == null) {
			session.setAttribute("destination", "redirect:/viewMyReviewList.mb");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/login.mb";
		}
	TrainerBean trainerBean = trainerDao.getTrainer(tid);
	ReviewBean reviewBean = reviewDao.getReviewByRenum(renum);
	model.addAttribute("reviewBean", reviewBean);
	model.addAttribute("trainerBean", trainerBean);
	model.addAttribute("memberBean", memberDao.selectMemberById(tid));
	model.addAttribute("mid", memberBean.getId());
	return getPage;
	}
}
