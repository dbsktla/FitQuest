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
						   Model model,
						   HttpServletResponse response) {
		MemberBean memberBean = memberDao.selectMemberById(mid);
		ReviewBean reviewBean = reviewDao.getReviewByRenum(renum);
		MemberBean tmemberBean = (MemberBean)session.getAttribute("loginInfo");
		response.setContentType("text/html; charset=utf-8");
		if(tmemberBean == null) {
			session.setAttribute("destination", "redirect:/trainerReviewList.mb");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/login.mb";
		} else if(!tmemberBean.getMtype().equals("trainer")){
			try {
				response.getWriter().print("<script>alert('비정상적인 접근입니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/main.go";
		}
		model.addAttribute("reviewBean", reviewBean);
		model.addAttribute("memberBean", memberBean);
		return getPage;
	}
}
