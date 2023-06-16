package admin.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import member.model.MailSendService;
import question.model.QcommentBean;
import question.model.QcommentDao;
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

	@RequestMapping(command)
	public String insert(QcommentBean qcommentBean, HttpSession session) {
		System.out.println("email : " + qcommentBean.getEmail());
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			int count = qcommentDao.getQcommentByQnumCount(qcommentBean.getQnum());
			System.out.println("count : " + count);
			if(count < 1) {
				int cnt = qcommentDao.insertQcomment(qcommentBean);
				if(cnt != -1) {
					System.out.println("답변 삽입 성공");
					cnt = questionDao.updateInsertQstatus(qcommentBean.getQnum());
					if(cnt != -1) {
						mailService.questionEmail(qcommentBean.getEmail());
					}
				}
				else {
					System.out.println("답변 삽입 실패");
				}
			}
			return "redirect:/adminQuestionDetail.ad?qnum=" + qcommentBean.getQnum();
		}
	}
}
