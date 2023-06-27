package question.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class OpenTQuestionController {
	private final String command = "openTQuestion.qt";
	
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(command)
	public String doAction(@RequestParam("tid") String tid, Model model,
							HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html; charset=UTF-8");
		ModelAndView mav = new ModelAndView();
		
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		session.setAttribute("menubar", "myHealth");
		
		
		// 로그인 정보 확인
		if(memberBean == null) { 
			session.setAttribute("destination", "redirect:/trainerList.pd");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');location.href='login.mb'</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			MemberBean tquestion = memberDao.selectMemberById(tid);
			model.addAttribute("tmember", tquestion);
			model.addAttribute("memberBean", memberBean);
		}
		
		return "trainerQuestionPopup";
	}
	
}
