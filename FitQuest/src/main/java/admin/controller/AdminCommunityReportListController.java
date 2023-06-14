package admin.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import admin.model.AdminDao;
import admin.model.AdminReportBean;

@Controller
public class AdminCommunityReportListController {
	private final String command = "/adminCommunityReportList.ad";
	private final String getPage = "adminCommunityReportList";
	
	@Autowired
	AdminDao adminDao;
	
	@RequestMapping(command)
	public String reportList(Model model) {
		List<AdminReportBean> reportBoardList = new ArrayList<AdminReportBean>();
		List<AdminReportBean> reportBcommentList = new ArrayList<AdminReportBean>();
		reportBoardList = adminDao.getReportBoardList();
		reportBcommentList = adminDao.getReportBCommnerList();
		model.addAttribute("reportBoardList",reportBoardList);
		model.addAttribute("reportBcommentList",reportBcommentList);
		return getPage;
	}
}
