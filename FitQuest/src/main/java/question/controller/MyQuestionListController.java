package question.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import question.model.QuestionBean;
import question.model.QuestionDao;
import utility.Paging;

@Controller
public class MyQuestionListController {
	private final String command = "myQuestionList.qt";
	private final String getPage = "myQuestionList";

	@Autowired
	QuestionDao questionDao;

	@RequestMapping(command)
	public String list(
			HttpSession session, 
			Model model,
			@RequestParam(value="pageNumber",required = false) String pageNumber,
			HttpServletRequest request,
			HttpServletResponse response
			) {
		response.setContentType("text/html; charset=utf-8");
		session.setAttribute("destination", "redirect:/myQuestionList.qt");
		session.setAttribute("menubar", "myQuestionMain");
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
			if(memberBean.getMtype().equals("generic")) {
				session.setAttribute("topmenu", "genericMember");
			}
			else {
				session.setAttribute("topmenu", "trainerMember");
			}
			Map<String,String> map = new HashMap<String,String>();
			map.put("whatColumn", "");
			map.put("keyword", "");
			if(pageNumber == null) {
				pageNumber = "1";
			}
			map.put("pageNumber", pageNumber);
			map.put("id", memberBean.getId());
			
			int totalCount = questionDao.getMyQuestionCount(memberBean.getId());
			String url = request.getContextPath() + command;
			Paging pageInfo = new Paging(pageNumber,"5",totalCount,url,"","",null);
			List<QuestionBean> myQuestionList = questionDao.getMyQuestionList(pageInfo,map);
			model.addAttribute("totalCount", totalCount);
			model.addAttribute("pageNumber", pageNumber);
			model.addAttribute("pageInfo", pageInfo);
			model.addAttribute("myQuestionList",myQuestionList);
			return getPage;
		}
	}

}
