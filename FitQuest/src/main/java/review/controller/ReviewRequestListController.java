package review.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import review.model.ReviewBean;
import review.model.ReviewDao;
import utility.ReviewPaging;

@Controller
public class ReviewRequestListController {
	private final String command = "/reviewDeleteRequestList.mb";
	private final String getPage = "adminReviewDeleteList";
	@Autowired
	ReviewDao reviewDao;
	@RequestMapping(value = command)
	public String doAction(HttpSession session,
			Model model,
			HttpServletRequest request,
			@RequestParam(value = "ordering", required = false) String ordering,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword,
			HttpServletResponse response) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo"); 
		response.setContentType("text/html; charset=utf-8");
		if(memberBean == null) {
			session.setAttribute("destination", "redirect:/reviewDeleteRequestList.mb");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/login.mb";
		}
		if(ordering == null) {
			ordering = "tid";
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("ordering", ordering);
		map.put("pageNumber", pageNumber);
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%" + keyword + "%");
		int totalCount = reviewDao.getAdminReviewCount(map);
		System.out.println("totalCount :" + totalCount);
		String url = request.getContextPath() + command;
		ReviewPaging pageInfo = new ReviewPaging(pageNumber, "6", totalCount, url, whatColumn, keyword, ordering);
		List<ReviewBean> rList = reviewDao.getReviewDeleteRequestList(map, pageInfo);
		model.addAttribute("ordering", ordering);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("whatColumn", whatColumn);
		model.addAttribute("keyword", keyword);
		model.addAttribute("rList", rList);
		model.addAttribute("pageInfo", pageInfo);
		return getPage;
	}
}
