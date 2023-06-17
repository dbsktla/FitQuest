package admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import admin.model.AdminDao;
import admin.model.AdminReportBean;
import member.model.MemberBean;
import question.model.QuestionBean;
import question.model.QuestionDao;
import review.model.ReviewBean;
import review.model.ReviewDao;

@Controller
public class AdminMainController {
	private final String command = "/adminMain.ad";
	private final String getPage = "adminMain";
	
	@Autowired
	QuestionDao questionDao;
	
	@Autowired
	ReviewDao reviewDao;
	
	@Autowired
	AdminDao adminDao;
	
	@RequestMapping(command)
	public String main(
			HttpSession session, 
			Model model,
			HttpServletRequest request,
			HttpServletResponse response
	) {
		response.setContentType("text/html; charset=utf-8");
		session.setAttribute("destination", "redirect:/adminMain.ad");
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
			if(memberBean.getId().equals("admin")) {
				List<QuestionBean> QueReqList = questionDao.getMainQuestionRequestList();
				List<ReviewBean> reportReviewList = reviewDao.getMainReviewReport();
				List<AdminReportBean> reportBoardList = adminDao.getMainReportBoardList();
				List<AdminReportBean> reportBcommentList = adminDao.getMainReportBCommnerList();
				model.addAttribute("reportBoardList",reportBoardList);
				model.addAttribute("reportBcommentList",reportBcommentList);
				model.addAttribute("reportReviewList",reportReviewList);
				model.addAttribute("QueReqList",QueReqList);
				return getPage;
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
