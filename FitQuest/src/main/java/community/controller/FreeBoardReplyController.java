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
public class FreeBoardReplyController {
	private final String command = "/freeBoardReply.co";
	private final String getPage = "freeBoardReplyForm";

	@Autowired
	BoardDao boardDao;

	@RequestMapping(value = command, method=RequestMethod.GET)
	public String reply(BoardBean boardBean, HttpSession session) {
		session.setAttribute("destination", "redirect:/freeBoardReply.co?bref=" + boardBean.getBref() + "&brestep=" + boardBean.getBrestep() + "&brelevel=" + boardBean.getBrelevel() + "&bcategory=" + boardBean.getBcategory());
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			return getPage;
		}
	}

	@RequestMapping(value = command, method=RequestMethod.POST)
	public String reply(@Valid BoardBean boardBean, BindingResult result, HttpSession session) {
		session.setAttribute("destination", "redirect:/freeBoardReply.co?bref=" + boardBean.getBref() + "&brestep=" + boardBean.getBrestep() + "&brelevel=" + boardBean.getBrelevel() + "&bcategory=" + boardBean.getBcategory());
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

				int cnt = boardDao.replyFreeBoard(boardBean);
				System.out.println("ReplyFreeBoard cnt : " + cnt);
				if(cnt != -1) {
					System.out.println("삽입 성공");
					return "redirect:/freeBoardList.co";
				}
				else {
					System.out.println("삽입 실패");
					return getPage;
				}
			}
		}
		
		

	}
}
