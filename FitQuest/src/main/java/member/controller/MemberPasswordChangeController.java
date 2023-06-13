package member.controller;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class MemberPasswordChangeController {
	private final String command = "memberChangePassword.mb";
	private final String getPage = "redirect:/trainerDetail.mb";
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(value = command)
	public String doAction(@RequestParam("password") String password,
						   @RequestParam("renewpassword") String renewpassword,
						   @RequestParam("oldpassword") String oldpassword,
						   Model model,
						   HttpSession session) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		Map<String, String> map = new HashMap<String, String>();
		map.put("password", password);
		map.put("id", memberBean.getId());
		int cnt = memberDao.updatePassword(map);
		if(cnt > 0) {
			System.out.println("비번 수정 성공");
		}
		memberBean.setPassword(password);
		session.setAttribute("loginInfo", memberBean);
		if(memberBean.getMtype().equals("trainer")) {
			return getPage;
		} else {
			return "redirect:/genericMemberDetail.mb";
		}
	}
}
