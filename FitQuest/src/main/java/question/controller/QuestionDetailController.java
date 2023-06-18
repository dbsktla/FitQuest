package question.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import question.model.QcommentBean;
import question.model.QcommentDao;
import question.model.QuestionBean;
import question.model.QuestionDao;

@Controller
public class QuestionDetailController {
	private final String command = "/questionDetail.qt";
	private final String getPage = "questionDetail";
	
	@Autowired
	QuestionDao questionDao;
	
	@Autowired
	QcommentDao qcommentDao;
	
	@RequestMapping(command)
	public String detail(HttpSession session, @RequestParam("qnum") int qnum, Model model, HttpServletResponse response) {
		response.setContentType("text/html; charset=utf-8");
		session.setAttribute("destination", "redirect:/myQuestionList.qt");
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
			QuestionBean questionBean = questionDao.getQuestionByQnum(qnum);
			QcommentBean qcommentBean = qcommentDao.getQcommentByQnum(qnum);
			int count = qcommentDao.getQcommentByQnumCount(qnum);
			model.addAttribute("questionBean", questionBean);
			model.addAttribute("qcommentBean", qcommentBean);
			model.addAttribute("count", count);
			return getPage;
		}
	}
}
