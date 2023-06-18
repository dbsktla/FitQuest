package admin.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import question.model.QcommentDao;
import question.model.QuestionDao;

@Controller
public class AdminQcommentDeleteController {
	private final String command = "/adfminQcommentDelete.ad";

	@Autowired
	QcommentDao qcommentDao;

	@Autowired
	QuestionDao questionDao;

	@RequestMapping(command)
	public String insert(@RequestParam("qnum") int qnum, @RequestParam("qcnum") int qcnum, HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html; charset=utf-8");
		session.setAttribute("destination", "redirect:/adminQuestionDetail.ad?qnum=" + qnum);
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
				int cnt = qcommentDao.deleteQcomment(qcnum);
				if(cnt != -1) {
					System.out.println("답변 삭제 성공");
					questionDao.updateDeleteQstatus(qnum);
					return "redirect:/adminQuestionDetail.ad?qnum=" + qnum;
				}
				else {
					System.out.println("답변 삭제 실패");
					return "redirect:/adminQuestionDetail.ad?qnum=" + qnum;
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
		}
	}
}
