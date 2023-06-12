package community.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class MemberInfoPopupController {
	private final String command = "/memberInfoPopup.co";
	private final String getPage = "memberInfoPopup";
	
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(value=command)
	public String insert(@RequestParam("id") String id, Model model) {
		MemberBean memberBean = null;
		memberBean = memberDao.selectMemberById(id);
		model.addAttribute("memberBean",memberBean);
		return getPage;
	} 
	
	
}
