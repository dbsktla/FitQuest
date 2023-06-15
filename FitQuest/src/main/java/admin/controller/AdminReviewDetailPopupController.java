package admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import review.model.ReviewBean;
import review.model.ReviewDao;

@Controller
public class AdminReviewDetailPopupController {
	private final String command = "reviewDetailPopup.ad";
	private final String getPage = "reviewDetailPopup";
	
	@Autowired
	ReviewDao reviewDao;
	
	@RequestMapping(command)
	public String detail(Model model, @RequestParam("renum") int renum) {
		ReviewBean reviewBean = reviewDao.getReviewByRenum(renum);
		model.addAttribute("reviewBean",reviewBean);
		System.out.println("reviewBean : " + reviewBean); 
		return getPage;
	}
	
}
