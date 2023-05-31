package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.GymDao;
import member.model.MemberDao;

@Controller
public class MemberCheckController {
	private final String command_id = "/id_check.mb";
	private final String command_nickname = "/nickname_check.mb";
	private final String command_gname = "/gname_check.mb";
	
	@Autowired
	MemberDao memberDao;
	
	@Autowired
	GymDao gymDao;
	
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
	
}
