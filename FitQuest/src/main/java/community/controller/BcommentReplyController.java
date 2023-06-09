package community.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import community.model.BcommentBean;
import community.model.BcommentDao;
import member.model.MemberBean;

@Controller
public class BcommentReplyController {
	private final String command = "/bcommentReply.co";

	@Autowired
	BcommentDao bcommentDao;

	@RequestMapping(value = command)
	public String reply(BcommentBean bcommentBean, HttpSession session) {
		session.setAttribute("destination", "redirect:/freeBoardDetail.co?bnum=" + bcommentBean.getBnum());
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			bcommentBean.setId(memberBean.getId());

			int cnt = bcommentDao.replyBcomment(bcommentBean);
			System.out.println("ReplyBcomment cnt : " + cnt);
			if(cnt != -1) {
				System.out.println("삽입 성공");
				return  "redirect:/freeBoardDetail.co?bnum=" + bcommentBean.getBnum();
			}
			else {
				System.out.println("삽입 실패");
				return  "redirect:/freeBoardDetail.co?bnum=" + bcommentBean.getBnum();
			}
		}



	}
}
