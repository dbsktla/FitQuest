package community.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.collections.bag.SynchronizedSortedBag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import community.model.BoardBean;
import community.model.BoardDao;
import member.model.MemberBean;
import member.model.MemberDao;
import notification.model.NotificationBean;
import notification.model.NotificationDao;

@Controller
public class FreeBoardReplyController {
	private final String command = "/freeBoardReply.co";
	private final String getPage = "freeBoardReplyForm";

	@Autowired
	BoardDao boardDao;
	@Autowired
	MemberDao memberDao;
	@Autowired
	NotificationDao notificationDao;
	@RequestMapping(value = command, method=RequestMethod.GET)
	public String reply(BoardBean boardBean, HttpSession session, HttpServletResponse response, Model model) {
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
			System.out.println("boardBean" + boardBean.getBnum());
			model.addAttribute(boardBean.getBnum());
			return getPage;
		}
	}

	@RequestMapping(value = command, method=RequestMethod.POST)
	public String reply(@Valid BoardBean boardBean, BindingResult result, HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html; charset=utf-8");
		session.setAttribute("destination", "redirect:/freeBoardReply.co?bref=" + boardBean.getBref() + "&brestep=" + boardBean.getBrestep() + "&brelevel=" + boardBean.getBrelevel() + "&bcategory=" + boardBean.getBcategory() + "&bnum=" + boardBean.getBnum());
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
				int ogBnum = boardBean.getBnum();
				MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
				boardBean.setId(memberBean.getId());
				boardBean.setBtype("자유");
				
				int cnt = boardDao.replyFreeBoard(boardBean);
				System.out.println("ReplyFreeBoard cnt : " + cnt);
				if(cnt != -1) {
					System.out.println("삽입 성공");
					//답글 삽입 성공하면 답글 하는 게시글에게 알림 보내기.
					int bnum = boardDao.getRecentBnum(); //방금 올린 답글의 bnum가져오기.
					BoardBean boardBean2 = boardDao.getOneFreeBoard(boardBean.getBnum());
					
					String request = "freeBoardDetail.co?bnum=" + bnum;
					String recId = boardBean2.getId(); //있었던 게시글 작성자 가 알림 받는다
					String recName = memberDao.getName(recId);
					String sendId = boardBean.getId(); //답글 올리는 게시글 작성자 가 알림 받는다.
					String sendName = memberDao.getName(sendId);
					String notifContent = sendName + " 회원님이 " + recName + "님의 글에 답글을 올렸습니다.";
					NotificationBean notifBean = new NotificationBean();
					notifBean.setRecId(recId);
					notifBean.setRecName(recName);
					notifBean.setSendId(sendId);
					notifBean.setSendName(sendName);
					notifBean.setRequest(request);
					notifBean.setNotifContent(notifContent);
					int notif = notificationDao.insertPurchaseNotif(notifBean);
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
