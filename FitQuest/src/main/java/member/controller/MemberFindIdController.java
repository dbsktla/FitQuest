package member.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class MemberFindIdController {
	private final String command = "/memberFindId.mb";
	private final String getPage = "memberFindId";

	@Autowired
	MemberDao memberDao;

	@RequestMapping(value=command, method=RequestMethod.GET)
	public String findId() {
		return getPage;
	}

	@RequestMapping(value=command, method=RequestMethod.POST)
	public String findId(MemberBean memberBean, HttpServletResponse response) {
		response.setContentType("text/html;charset=UTF-8");
		try {
			memberBean = memberDao.selectMemberByNameAndEmail(memberBean);
			if(memberBean == null) {
				response.getWriter().print("<script>alert('가입하지 않은 회원입니다.');window.close();</script>");
				response.getWriter().flush();
			}
			else {
				if(memberBean.getId().indexOf("kakao") != -1 || memberBean.getId().indexOf("naver") != -1) {
					response.getWriter().print("<script>alert('소셜 회원가입된 아이디입니다.');window.close();</script>");
					response.getWriter().flush();
				}
				else {
					response.getWriter().print("<script>alert('찾으시는 아이디는" + memberBean.getId() + "입니다.');window.close();</script>");
					response.getWriter().flush();
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "redirect:login.mb";

	}

}
