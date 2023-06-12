package community.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import community.model.BoardBean;
import community.model.BoardDao;
import member.model.MemberBean;

@Controller
public class FreeBoardInsertController {
	private final String command = "/freeBoardInsert.co";
	private final String getPage = "freeBoardInsertForm";
	private final String gotoPage = "redirect:/freeBoardList.co";

	@Autowired
	BoardDao boardDao;

	@RequestMapping(value = command, method=RequestMethod.GET)
	public String insert(HttpSession session) {
		session.setAttribute("destination", gotoPage);
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			return getPage;
		}
	}

	@RequestMapping(value = command, method=RequestMethod.POST)
	public String insert(@Valid BoardBean boardBean, BindingResult result, HttpSession session) {
		
		session.setAttribute("destination", "redirect:/freeBoardInsert.co");
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			if(result.hasErrors()) {
				return getPage;
			}
			else {

				MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
				boardBean.setId(memberBean.getId());
				boardBean.setBtype("자유");
				boardBean.setBrestep(0);
				boardBean.setBrelevel(0);

				int cnt = boardDao.insertFreeBoard(boardBean);
				System.out.println("InsertFreeBoard cnt : " + cnt);
				if(cnt != -1) {
					System.out.println("삽입 성공");
					return gotoPage;
				}
				else {
					System.out.println("삽입 실패");
					return getPage;
				}
			}
		}
		
		

	}
}
