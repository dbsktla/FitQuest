package community.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
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
	public String reply(BoardBean boardBean, HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html; charset=utf-8");
		session.setAttribute("destination", "redirect:/freeBoardReply.co?bref=" + boardBean.getBref() + "&brestep=" + boardBean.getBrestep() + "&brelevel=" + boardBean.getBrelevel() + "&bcategory=" + boardBean.getBcategory());
		if(session.getAttribute("loginInfo") == null) {
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/login.mb";
		}
		else {
			return getPage;
		}
	}

	@RequestMapping(value = command, method=RequestMethod.POST)
	public String reply(@Valid BoardBean boardBean, BindingResult result, HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html; charset=utf-8");
		session.setAttribute("destination", "redirect:/freeBoardReply.co?bref=" + boardBean.getBref() + "&brestep=" + boardBean.getBrestep() + "&brelevel=" + boardBean.getBrelevel() + "&bcategory=" + boardBean.getBcategory());
		if(session.getAttribute("loginInfo") == null) {
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/login.mb";
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
