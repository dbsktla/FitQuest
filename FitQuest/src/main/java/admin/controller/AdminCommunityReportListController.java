package admin.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import admin.model.AdminDao;
import admin.model.AdminReportBean;
import member.model.MemberBean;

@Controller
public class AdminCommunityReportListController {
	private final String command = "/adminCommunityReportList.ad";
	private final String getPage = "adminCommunityReportList";
	
	@Autowired
	AdminDao adminDao;
	
	@RequestMapping(command)
	public String reportList(Model model, HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html; charset=utf-8");
		session.setAttribute("destination", "redirect:/adminCommunityReportList.ad");
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			if(memberBean.getId().equals("admin")) {
				List<AdminReportBean> reportBoardList = new ArrayList<AdminReportBean>();
				List<AdminReportBean> reportBcommentList = new ArrayList<AdminReportBean>();
				reportBoardList = adminDao.getReportBoardList();
				reportBcommentList = adminDao.getReportBCommnerList();
				model.addAttribute("reportBoardList",reportBoardList);
				model.addAttribute("reportBcommentList",reportBcommentList);
				return getPage;
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
		}
	}
}
