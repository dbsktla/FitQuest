package admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import admin.model.AdminDao;
import member.model.MemberBean;
import review.model.ReviewBean;
import review.model.ReviewDao;
import utility.Paging;

@Controller
public class AdminReviewReportListController {
	private final String command = "/adminReviewReportList.ad";
	private final String getPage = "adminReviewReportList";
	
	@Autowired
	AdminDao adminDao;
	
	@Autowired
	ReviewDao reviewDao;
	
	@RequestMapping(command)
	public String reportList(Model model, HttpSession session, @RequestParam(value="pageNumber",required = false) String pageNumber, HttpServletRequest request) {
		session.setAttribute("destination", "redirect:/adminReviewReportList.ad");
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			if(memberBean.getId().equals("admin")) {
				Map<String,String> map = new HashMap<String,String>();
				map.put("whatColumn", "");
				map.put("keyword", "");
				if(pageNumber == null) {
					pageNumber = "1";
				}
				map.put("pageNumber", pageNumber);
				int totalCount = reviewDao.getReviewReportCount();
				String url = request.getContextPath() + command;
				Paging pageInfo = new Paging(pageNumber,"5",totalCount,url,"","",null);
				List<ReviewBean> reportReviewList = reviewDao.getReviewReport(pageInfo,map);
				model.addAttribute("totalCount", totalCount);
				model.addAttribute("pageNumber", pageNumber);
				model.addAttribute("pageInfo", pageInfo);
				model.addAttribute("reportReviewList",reportReviewList);
				
				return getPage;
			}else {
				return "redirect:/login.mb";
			}
		}
	}
}
