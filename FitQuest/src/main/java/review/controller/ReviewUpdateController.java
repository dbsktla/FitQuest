package review.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import review.model.ReviewBean;
import review.model.ReviewDao;

@Controller
public class ReviewUpdateController {
	private final String command = "updateMyReview.mb";
	private final String getPage = "myReviewUpdateForm";
	
	@Autowired
	ReviewDao reviewDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(@RequestParam("renum") int renum, Model model) {
		ReviewBean reviewBean = reviewDao.getReviewByRenum(renum);
		model.addAttribute("reviewBean", reviewBean);
		return getPage;
	}
}
