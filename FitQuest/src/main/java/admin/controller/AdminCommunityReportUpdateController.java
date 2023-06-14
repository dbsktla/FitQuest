package admin.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import admin.model.AdminReportBean;
import community.model.BcommentDao;
import community.model.BoardDao;
import community.model.ReportDao;
import member.model.MemberBean;

@Controller
public class AdminCommunityReportUpdateController {
	private final String command = "/adminCommunityReportUpdate.ad";
	private final String gotoPoage = "redirect:/adminCommunityReportList.ad";
	
	@Autowired
	ReportDao reportDao;
	
	@RequestMapping(command)
	public String update(HttpSession session, AdminReportBean adminReportBean) {
		session.setAttribute("destination", "redirect:/adminCommunityReportList.ad");
		if(session.getAttribute("loginInfo") != null) {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			if(memberBean.getId().equals("admin")) {
				adminReportBean.setStatus("신고 거절");
				int cnt = reportDao.updateReport(adminReportBean);
				if(cnt != -1) {
					System.out.println("수정 성공");
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
		return gotoPoage;
	}
}
