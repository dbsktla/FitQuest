package admin.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import admin.model.AdminDao;
import member.model.MemberBean;
import review.model.ReviewBean;
import review.model.ReviewDao;

@Controller
public class AdminReviewReportListController {
	private final String command = "/adminReviewReportList.ad";
	private final String getPage = "adminReviewReportList";
	
	@Autowired
	AdminDao adminDao;
	
	@Autowired
	ReviewDao reviewDao;
	
	@RequestMapping(command)
	public String reportList(Model model, HttpSession session) {
		session.setAttribute("destination", "redirect:/adminReviewReportList.ad");
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			if(memberBean.getId().equals("admin")) {
				List<ReviewBean> reportReviewList = new ArrayList<ReviewBean>();
				reportReviewList = reviewDao.getReviewReport();
				model.addAttribute("reportReviewList",reportReviewList);
				return getPage;
			}else {
				return "redirect:/login.mb";
			}
		}
	}
}
