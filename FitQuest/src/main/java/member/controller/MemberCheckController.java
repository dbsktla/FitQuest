package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import gym.model.GymDao;
import member.model.MailSendService;
import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class MemberCheckController {
	private final String command_id = "/id_check.mb";
	private final String command_nickname = "/nickname_check.mb";
	private final String command_gname = "/gname_check.mb";
	private final String command_email = "/email_check.mb";
	private final String command_findpw = "/findpw_check.mb";
	
	@Autowired
	MemberDao memberDao;
	
	@Autowired
	GymDao gymDao;
	
	@Autowired
	MailSendService mailService;
	
	@RequestMapping(value=command_id)
	@ResponseBody
	public String checkId(@RequestParam("id") String id) {
		boolean isCheck = memberDao.searchId(id);
		if(isCheck) { 
			return "NO"; 
		}
		else {
			return "YES";
		}
	}
	
	@RequestMapping(value=command_nickname)
	@ResponseBody
	public String checkNickame(@RequestParam("nickname") String nickname) {
		boolean isCheck = memberDao.searchNickname(nickname);
		if(isCheck) { 
			return "NO"; 
		}
		else {
			return "YES";
		}
	}
	
	@RequestMapping(value=command_gname)
	@ResponseBody
	public String checkGname(@RequestParam("gname") String gname) {
		boolean isCheck = gymDao.searchGname(gname);
		if(isCheck) { 
			return "NO"; 
		}
		else {
			return "YES";
		}
	}
	
	@RequestMapping(value=command_email)
	@ResponseBody
	public String mailCheck(String email) {
		System.out.println("이메일 인증 요청이 들어옴!");
		System.out.println("이메일 인증 이메일 : " + email);
		
		return mailService.joinEmail(email);
	}
	
	@RequestMapping(value=command_findpw)
	@ResponseBody
	public String findpwEmail(String email, String id) {
		System.out.println("이메일 인증 요청이 들어옴!");
		System.out.println("이메일 인증 이메일 : " + email);
		System.out.println(id);
		MemberBean memberBean = memberDao.selectMemberById(id);
		if(memberBean != null) {
			if(email.equals(memberBean.getEmail())) {
				return mailService.joinEmail(email);
			}
			else {
				return "false";
			}
		}
		else {
			return "no";
		}
	}
	
}
