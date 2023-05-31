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
	
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(value=command,method=RequestMethod.GET)
	public String insert() {
		return getPage;
	}
	
	@RequestMapping(value=command,method=RequestMethod.POST)
	public String insert(@Valid MemberBean memberBean, BindingResult result,HttpServletRequest request) {
		
		System.out.println("id : " + memberBean.getId());
		System.out.println("name : " + memberBean.getName());
		System.out.println("password : " + memberBean.getPassword());
		System.out.println("nickname : " + memberBean.getNickname());
		System.out.println("email : " + memberBean.getEmail());
		System.out.println("birth : " + memberBean.getBirth());
		System.out.println("mphone : " + memberBean.getMphone());
		System.out.println("maddr1 : " + memberBean.getMaddr1());
		System.out.println("maddr2 : " + memberBean.getMaddr2());
		
		if(result.hasErrors()) {
			System.out.println("에러 발생");
			return getPage;
		}
		else {
			int cnt = memberDao.insertMember(memberBean);
			System.out.println("Insert cnt : " + cnt);
			//return getPage;
			return "";
		}
	}
	
}
