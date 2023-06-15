package question.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import question.model.QuestionBean;
import question.model.QuestionDao;

@Controller
public class QuestionDeleteController {
	private final String command = "/questionDelete.qt";
	private final String gotoPage = "redirect:/myQuestionList.qt";

	@Autowired
	QuestionDao questionDao;

	@RequestMapping(value=command)
	public String insert(
			@RequestParam("qnum") int qnum,
			HttpSession session,
			Model model
			) {
		session.setAttribute("destination", gotoPage);
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			int cnt = questionDao.deleteQuestion(qnum);
			if(cnt != -1) {
				System.out.println("문의 삭제 성공");
			}
			else {
				System.out.println("문의 삭제 실패");
			}
			return gotoPage;
		}
	}
}
