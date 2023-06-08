package review.controller;

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

import member.model.MemberBean;
import review.model.ReviewBean;
import review.model.ReviewDao;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;
import utility.ReviewPaging;

@Controller
public class ReviewListController {
	private final String command = "/trainerReviewList.mb";
	private final String getPage = "trainerReviewList";
	
	@Autowired
	ReviewDao reviewDao;
	@Autowired
	TrainerDao trainerDao;
	@RequestMapping(value = command)
	public String doAction(HttpSession session,
						   Model model,
						   HttpServletRequest request,
						   @RequestParam(value = "ordering", required = false) String ordering,
						   @RequestParam(value = "pageNumber", required = false) String pageNumber,
						   @RequestParam(value = "whatColumn", required = false) String whatColumn,
						   @RequestParam(value = "keyword", required = false) String keyword) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo"); 
		//트레이너로 로그인 안되어있으면 아예 링크 안 보여서 조건문은 생략.
		TrainerBean trainerBean = trainerDao.getTrainer(memberBean.getId());
		String hasReview = reviewDao.getHasReviewById(trainerBean.getId());
		double avgScore = 0.0;
		if(hasReview.equals("Y")) {
			avgScore = reviewDao.getAverageReviewScore(memberBean.getId());
		}
		if(ordering == null) {
			ordering = "tid";
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("ordering", ordering);
		map.put("pageNumber", pageNumber);
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%" + keyword + "%");
		map.put("tid", trainerBean.getId());
		int totalCount = reviewDao.getReviewCount(map);
		String url = request.getContextPath() + command;
		ReviewPaging pageInfo = new ReviewPaging(pageNumber, "8", totalCount, url, whatColumn, keyword, ordering);
		List<ReviewBean> rList = reviewDao.getReviewList(map, pageInfo);
		model.addAttribute("ordering", ordering);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("whatColumn", whatColumn);
		model.addAttribute("keyword", keyword);
		model.addAttribute("rList", rList);
		model.addAttribute("hasReview", hasReview);
		model.addAttribute("trainerBean", trainerBean);
		model.addAttribute("avgScore", avgScore);
		model.addAttribute("pageInfo", pageInfo);
		return getPage;
	}
}
