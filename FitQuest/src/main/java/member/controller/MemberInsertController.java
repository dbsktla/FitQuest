package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class MemberInsertController {
	private final String command = "/insert.mb";
	private final String getPage = "memberInsertForm";
	private final String gotoPage = "redirect:/login.mb";
	
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(value=command,method=RequestMethod.GET)
	public String insert() {
		return getPage;
	} 
	
	@RequestMapping(value=command,method=RequestMethod.POST)
	public String insert(@Valid MemberBean memberBean, BindingResult result, HttpServletRequest request) {
		
		System.out.println("gender : " + memberBean.getGender());
		
		if(result.hasErrors()) {
			System.out.println("에러 발생");
			return getPage; 
		}
		else {
			int cnt = memberDao.insertMember(memberBean);
			System.out.println("InsertMember cnt : " + cnt);
			if(cnt != -1) {
				return gotoPage;
			}
			else {
				System.out.println("삽입 실패");
				return getPage; 
			}
		}
	}
	
}
