package member.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class MemberLoginController {
	private final String command = "/login.mb";
	private final String getPage = "memberLoginForm";
	private final String gotoPage = "redirect:/main.go";

	@Autowired
	MemberDao memberDao;

	@RequestMapping(value=command,method=RequestMethod.GET)
	public String login() {
		return getPage;
	}

	@RequestMapping(value=command,method=RequestMethod.POST)
	public String login(
			@RequestParam("id") String id, 
			@RequestParam("password") String password, 
			HttpServletResponse response, 
			HttpSession session
			) {
		response.setContentType("text/html; charset=UTF-8");
		MemberBean memberBean = memberDao.selectMemberById(id);
		try {
			if(memberBean == null) {
				response.getWriter().print("<script>alert('해당 아이디가 존재하지 않습니다.');history.go(-1);</script>");
				response.getWriter().flush();
				return getPage;
			}
			else {
				if(memberBean.getPassword().equals(password)) {
					session.setAttribute("loginInfo", memberBean);
					return gotoPage;
				}
				else {
					response.getWriter().print("<script>alert('비밀번호가 일치하지 않습니다.');history.go(-1);</script>");
					response.getWriter().flush();
					return getPage;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return getPage;
	}

}
