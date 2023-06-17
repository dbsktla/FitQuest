package admin.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import admin.model.AdminReportBean;
import community.model.ReportDao;
import member.model.MemberBean;

@Controller
public class AdminCommunityReportUpdateController {
	private final String command = "/adminCommunityReportUpdate.ad";
	private final String gotoPage = "redirect:/adminCommunityReportList.ad";
	
	@Autowired
	ReportDao reportDao;
	
	@RequestMapping(command)
	public String update(HttpSession session, AdminReportBean adminReportBean, HttpServletResponse response) {
		response.setContentType("text/html; charset=utf-8");
		session.setAttribute("destination", "redirect:/adminCommunityReportList.ad");
		if(session.getAttribute("loginInfo") != null) {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			if(memberBean.getId().equals("admin")) {
				adminReportBean.setStatus("신고 거절");
				int cnt = reportDao.updateReport(adminReportBean);
				if(cnt != -1) {
					System.out.println("수정 성공");
					return gotoPage;
				}
				else {
					System.out.println("수정 실패");
				}
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
		else {
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/login.mb";
		}
		return gotoPage;
	}
}
