package question.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import question.model.QuestionBean;
import question.model.QuestionDao;

@Controller
public class QuestionInsertController {
	private final String command = "/questionInsert.qt";
	private final String getPage = "questionInsert";
	private final String gotoPage = "redirect:/myQuestionList.qt";
	
	@Autowired
	QuestionDao questionDao;
	
	@RequestMapping(value=command,method=RequestMethod.GET)
	public String insert(HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html; charset=utf-8");
		if(session.getAttribute("loginInfo") == null) {
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/login.mb";
		}
		return getPage;
	}
	
	@RequestMapping(value=command,method=RequestMethod.POST)
	public String insert(
			@Valid QuestionBean questionBean, 
			BindingResult result,
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
			if(result.hasErrors()) {
				return getPage;
			}
			else {
				int cnt = questionDao.insertQuestion(questionBean);
				if(cnt != -1) {
					System.out.println("문의 작성 성공");
					return gotoPage;
				}
				else {
					System.out.println("문의 작성 실패");
					return getPage;
				}
			}
		}
	}
	
}
