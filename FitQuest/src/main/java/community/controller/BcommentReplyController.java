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
import community.model.BoardBean;
import community.model.BoardDao;
import member.model.MemberBean;
import member.model.MemberDao;
import notification.model.NotificationBean;
import notification.model.NotificationDao;

@Controller
public class BcommentReplyController {
	private final String command = "/bcommentReply.co";

	@Autowired
	BcommentDao bcommentDao;
	@Autowired
	BoardDao boardDao;
	@Autowired
	MemberDao memberDao;
	@Autowired
	NotificationDao notificationDao;
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
				//댓글에 답변 삽입 성공 하면 알림 추가
				int bnum = bcommentBean.getBnum();
				BoardBean boardBean = null;
				String request = "";
				if(btype.equals("자유")) {
					boardBean = boardDao.getOneFreeBoard(bnum);
					request = "freeBoardDetail.co?bnum=" + bcommentBean.getBnum();
				} else {
					boardBean = boardDao.getOnehealthBoard(bnum);
					request = "healthBoardDetail.co?bnum=" + bcommentBean.getBnum();
				}
				String recId = boardBean.getId();
				String recName = memberDao.getName(recId);
				String sendId = bcommentBean.getId();
				String sendName = memberDao.getName(sendId);
				String notifContent = sendName + " 회원님이 " + recName + "님의 댓글에 답변을 추가했습니다.";
				NotificationBean notifBean = new NotificationBean();
				notifBean.setRecId(recId);
				notifBean.setRecName(recName);
				notifBean.setSendId(sendId);
				notifBean.setSendName(sendName);
				notifBean.setRequest(request);
				notifBean.setNotifContent(notifContent);
				int notif = notificationDao.insertPurchaseNotif(notifBean);
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
