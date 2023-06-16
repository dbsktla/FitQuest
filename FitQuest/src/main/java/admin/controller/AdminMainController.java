package admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import utility.Paging;

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
			HttpServletRequest request
	) {
		session.setAttribute("destination", "redirect:/adminMain.ad");
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
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
				return "redirect:/login.mb";
			}
		}
	}
}
