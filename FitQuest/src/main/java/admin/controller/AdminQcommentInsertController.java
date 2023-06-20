package admin.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import member.model.MailSendService;
import member.model.MemberBean;
import member.model.MemberDao;
import notification.model.NotificationBean;
import notification.model.NotificationDao;
import question.model.QcommentBean;
import question.model.QcommentDao;
import question.model.QuestionBean;
import question.model.QuestionDao;

@Controller
public class AdminQcommentInsertController {
	private final String command = "/adfminQcommentInsert";

	@Autowired
	QcommentDao qcommentDao;

	@Autowired
	QuestionDao questionDao;

	@Autowired
	MailSendService mailService;
	
	@Autowired
	MemberDao memberDao;
	
	@Autowired
	NotificationDao notificationDao;
	
	@RequestMapping(command)
	public String insert(QcommentBean qcommentBean, HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html; charset=utf-8");
		session.setAttribute("destination", "redirect:/adminQuestionDetail.ad?qnum=" + qcommentBean.getQnum());
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
			if(memberBean.getId().equals("admin")){
				int count = qcommentDao.getQcommentByQnumCount(qcommentBean.getQnum());
				System.out.println("count : " + count);
				if(count < 1) {
					int cnt = qcommentDao.insertQcomment(qcommentBean);
					if(cnt != -1) {
						System.out.println("답변 삽입 성공");
						cnt = questionDao.updateInsertQstatus(qcommentBean.getQnum());
						//답변 삽입 하면 문의를 하신 회원에게 알림 보낸다.
						int qnum = qcommentBean.getQnum();
						String request = "questionDetail.qt?qnum=" + qnum;
						QuestionBean questionBean = questionDao.getQuestionByQnum(qnum);
						String recId = questionBean.getId(); //문의 올린 회원이 알립 받는 id 값
						String recName = memberDao.getName(recId);
						String sendId = "admin"; //문의 답변 보내는 사람 은 관리자
						String sendName = "관리자";
						String notifContent = recName + "님의 문의에 답변이 올려졌습니다.";
						NotificationBean notifBean = new NotificationBean();
						notifBean.setRecId(recId);
						notifBean.setRecName(recName);
						notifBean.setSendId(sendId);
						notifBean.setSendName(sendName);
						notifBean.setRequest(request);
						notifBean.setNotifContent(notifContent);
						int notif = notificationDao.insertPurchaseNotif(notifBean);
						if(cnt != -1) {
							mailService.questionEmail(qcommentBean.getEmail(),qcommentBean.getQcontent(),qcommentBean.getQcomment());
						}
					}
					else {
						System.out.println("답변 삽입 실패");
					}
				}
			}
			else {
				try {
					response.getWriter().print("<script>alert('관리자 로그인이 필요합니다.');</script>");
					response.getWriter().flush();
				} catch (IOException e) {
					e.printStackTrace();
				}
				return "forward:/login.mb";
			}
			
			return "redirect:/adminQuestionDetail.ad?qnum=" + qcommentBean.getQnum();
		}
	}
}
