package question.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
			Model model,
			HttpServletResponse response
			) {
		response.setContentType("text/html; charset=utf-8");
		session.setAttribute("destination", gotoPage);
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
