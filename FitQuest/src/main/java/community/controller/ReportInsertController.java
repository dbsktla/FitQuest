package community.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import community.model.ReportBean;
import community.model.ReportDao;
import member.model.MemberBean;

@Controller
public class ReportInsertController {
	
	@Autowired
	ReportDao reportDao;

	@RequestMapping("/reportInsertForm.co")
	public String insertForm() {
		return "reportInsertForm";
	}
	
	@RequestMapping("/reportInsert.co")
	public String insert(ReportBean reportBean, HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html;charset=UTF-8");
		session.setAttribute("destination", "redirect:/freeBoardDetail.co?bnum=" + reportBean.getBnum());
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			reportBean.setId(memberBean.getId());
			int cnt = reportDao.insertReport(reportBean);
			if(cnt != -1) {
				System.out.println("삽입 성공");
				try {
					response.getWriter().print("<script>alert('신고 접수되었습니다.');opener.parent.location.reload();window.close();</script>");
					response.getWriter().flush();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			else {
				System.out.println("삽입 실패");
				try {
					response.getWriter().print("<script>alert('다시 신고해주세요.');opener.parent.location.reload();window.close();</script>");
					response.getWriter().flush();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
			return "";
		}
		
	}
}
