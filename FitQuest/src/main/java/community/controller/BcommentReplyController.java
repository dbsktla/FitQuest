package community.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import community.model.BcommentBean;
import community.model.BcommentDao;
import member.model.MemberBean;

@Controller
public class BcommentReplyController {
	private final String command = "/bcommentReply.co";

	@Autowired
	BcommentDao bcommentDao;

	@RequestMapping(value = command)
	public String reply(BcommentBean bcommentBean, @RequestParam("btype") String btype ,HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html; charset=utf-8");
		if(btype.equals("자유")) {
			session.setAttribute("destination", "redirect:/freeBoardDetail.co?bnum=" + bcommentBean.getBnum());
		}
		else {
			session.setAttribute("destination", "redirect:/healthBoardDetail.co?bnum=" + bcommentBean.getBnum());
		}
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
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			bcommentBean.setId(memberBean.getId());

			int cnt = bcommentDao.replyBcomment(bcommentBean);
			System.out.println("ReplyBcomment cnt : " + cnt);
			if(cnt != -1) {
				System.out.println("삽입 성공");
			}
			else {
				System.out.println("삽입 실패");
			}
			if(btype.equals("자유")) {
				return "redirect:/freeBoardDetail.co?bnum=" + bcommentBean.getBnum();
			}
			else {
				return "redirect:/healthBoardDetail.co?bnum=" + bcommentBean.getBnum();
			}
		}



	}
}
