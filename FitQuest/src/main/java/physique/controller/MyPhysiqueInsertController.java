package physique.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;

@Controller
public class MyPhysiqueInsertController {
	private final String command = "myPhysiqueInsert.ht";
	private final String getPage = "myPhysiqueInsertForm";
	
	
	// form 이동
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(@RequestParam("phdate") String phdate, HttpSession session, HttpServletResponse response,
							Model model) {
		response.setContentType("text/html; charset=UTF-8");
		MemberBean memberBean =  (MemberBean)session.getAttribute("loginInfo");
		if(memberBean == null) {
			session.setAttribute("destination", "redirect:/myPhysiqueList.ht");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');location.href='login.mb'</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		phdate = phdate.replace(',', '-');
		model.addAttribute("phdate", phdate);
		
		return getPage;
	}
}
