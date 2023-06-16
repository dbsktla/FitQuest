package member.controller;

import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import member.model.MemberBean;

@Controller
public class MemberDetailController {
	private final String command = "genericMemberDetail.mb";
	private final String getPage = "myMemberDetail";
	
	@RequestMapping(value = command)
	public String doAction(Model model,
						   HttpSession session,
						   HttpServletResponse response) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo"); 
		response.setContentType("text/html; charset=utf-8");
		session.setAttribute("topmenu", "genericMember");
		session.setAttribute("menubar", "myDetailMain");
		if(memberBean == null) {
			session.setAttribute("destination", "redirect:/genericMemberDetail.mb");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/login.mb";
		}
		String[] date = memberBean.getBirth().split(" ");
		memberBean.setBirth(date[0]);
		model.addAttribute("memberBean", memberBean);
		return getPage;
	}
}
