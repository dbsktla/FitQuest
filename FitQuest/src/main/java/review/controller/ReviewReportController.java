package review.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import review.model.ReviewBean;
import review.model.ReviewDao;

@Controller
public class ReviewReportController {
	private final String command = "reportReview.mb";
	private final String getPage = "forward:/trainerReviewList.mb";
	
	@Autowired
	ReviewDao reviewDao;
	
	@RequestMapping(value = command)
	public String doAction(@RequestParam("renum") int renum,
						   HttpServletResponse response) {
		ReviewBean reviewBean = reviewDao.getReviewByRenum(renum);
		response.setContentType("text/html; charset=utf-8");
		int cnt = reviewDao.getReportCount(renum);
		if(cnt > 0) {
			try {
				response.getWriter().print("<script>alert('이미 신고하신 리뷰입니다.');</script>");
				response.getWriter().flush();
				return getPage;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		int cnt2 = reviewDao.insertReport(renum);
		System.out.println(cnt2);
		if(cnt > 0) {
			try {
				response.getWriter().print("<script>alert('신고 성공했습니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return getPage;
	}
	
}
