package admin.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import question.model.QcommentBean;
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
	public String insert(@RequestParam("qnum") int qnum, @RequestParam("qcnum") int qcnum, HttpSession session) {
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
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
	}
}
