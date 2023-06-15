package admin.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

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

	@RequestMapping(command)
	public String insert(QcommentBean qcommentBean, HttpSession session) {
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
					questionDao.updateInsertQstatus(qcommentBean.getQnum());
				}
				else {
					System.out.println("답변 삽입 실패");
				}
			}
			return "redirect:/adminQuestionDetail.ad?qnum=" + qcommentBean.getQnum();
		}
	}
}
