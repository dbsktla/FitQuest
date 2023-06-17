package admin.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import review.model.ReviewDao;

@Controller
public class AdminReviewReportUpdateController {
	private final String command = "/adminReviewReportUpdate.ad";
	private final String gotoPage = "redirect:/adminReviewReportList.ad";
	
	@Autowired
	ReviewDao reviewDao;
	
	@RequestMapping(command)
	public String update(HttpSession session, @RequestParam("renum") int renum, HttpServletResponse response) {
		response.setContentType("text/html; charset=utf-8");
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
