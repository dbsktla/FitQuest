package health.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;

@Controller
public class MyHealthInsertController {
	private final String command = "myHealthInsert.ht";
	private final String getPage = "myHealthInsertForm";
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView doAction(HttpSession session, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		if(memberBean == null) { // 로그인 정보 없을 때
			session.setAttribute("destination", "redirect:/myHealthInsert.ht");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			mav.setViewName("redirect:/loginForm.mb");
		} else { // 로그인 정보 존재할때
			mav.setViewName(getPage);
		}
		return mav;
	}
	
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView doAction(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		
		
		
		
		return mav;
	}
	
}
