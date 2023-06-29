package member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class MemberFindPwController {
	private final String command = "/memberFindPw.mb";
	private final String getPage = "memberFindPw";

	@Autowired
	MemberDao memberDao;

	@RequestMapping(value=command, method=RequestMethod.GET)
	public String findPw() {
		return getPage;
	}

	@RequestMapping(value=command, method=RequestMethod.POST)
	public String findPw(MemberBean memberBean, HttpServletResponse response) {
		response.setContentType("text/html;charset=UTF-8");
		try {
			memberBean = memberDao.selectMemberByIdAndEmail(memberBean);
			if(memberBean == null) {
				response.getWriter().print("<script>alert('가입하지 않은 회원입니다.\\n회원가입을 이용해 주세요.');window.close();</script>");
				response.getWriter().flush();
			}
			else {
				if(memberBean.getId().indexOf("kakao") != -1 || memberBean.getId().indexOf("naver") != -1) {
					response.getWriter().print("<script>alert('소셜 회원가입된 아이디입니다.\\n소셜 로그인을 이용해 주세요.');window.close();</script>");
					response.getWriter().flush();
				}
				else {
					//response.getWriter().print("<script>var openWin = window.open('memberFindPwChangePw.mb?id=" + memberBean.getId() + "', '_blank', 'width=500, height=500, left=300');window.close();</script>");
					response.getWriter().print("<script>location.href='memberFindPwChangePw.mb?id=" + memberBean.getId() + "';</script>");
					response.getWriter().flush();
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "redirect:login.mb";
	}

	@RequestMapping(value="memberFindPwChangePw.mb", method=RequestMethod.GET)
	public String changePw() {
		return "memberFindPwChangePw";
	}

	@RequestMapping(value="memberFindPwChangePw.mb", method=RequestMethod.POST)
	public String changePw(@RequestParam("id") String id, @RequestParam("password") String password,HttpServletResponse response) {
		response.setContentType("text/html;charset=UTF-8");
		Map<String, String> map = new HashMap<String, String>();
		map.put("password", password);
		map.put("id", id);
		int cnt = memberDao.updatePassword(map);
		try {
			if(cnt == -1) {
				response.getWriter().print("<script>alert('비밀번호 변경에 실패했습니다.\\n다시 이용해 주세요.');window.close();</script>");
				response.getWriter().flush();
			}
			else {
				response.getWriter().print("<script>alert('비밀번호가 변경되었습니다.');window.close();</script>");
				response.getWriter().flush();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "redirect:login.mb";
	}

}
