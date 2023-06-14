package admin.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import admin.model.AdminReportBean;
import community.model.BcommentDao;
import community.model.BoardDao;
import community.model.ReportDao;
import member.model.MemberBean;
import review.model.ReviewDao;

@Controller
public class AdminReviewReportUpdateController {
	private final String command = "/adminReviewReportUpdate.ad";
	private final String gotoPage = "redirect:/adminReviewReportList.ad";
	
	@Autowired
	ReviewDao reviewDao;
	
	@RequestMapping(command)
	public String update(HttpSession session, @RequestParam("renum") int renum) {
		session.setAttribute("destination", "redirect:/adminCommunityReportList.ad");
		if(session.getAttribute("loginInfo") != null) {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			if(memberBean.getId().equals("admin")) {
				int cnt = reviewDao.updateReviewReport(renum);
				if(cnt != -1) {
					System.out.println("수정 성공");
					return gotoPage;
				}
				else {
					System.out.println("수정 실패");
				}
			}
			else {
				session.setAttribute("loginInfo", null);
				return "redirect:/login.mb";
			}
		}
		else {
			return "redirect:/login.mb";
		}
		return gotoPage;
	}
}
