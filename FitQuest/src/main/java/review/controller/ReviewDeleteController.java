package review.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import review.model.ReviewDao;

@Controller
public class ReviewDeleteController {
	private final String command = "deleteReview.mb";
	private final String getPage = "redirect:/viewMyReviewList.mb";
	@Autowired
	ReviewDao reviewDao;
	@RequestMapping(value = command)
	public String doAction(@RequestParam("renum") int renum) {
		
		int cnt = reviewDao.deleteReview(renum);
		
		if(cnt > 0) {
			System.out.println("리뷰 삭제 성공");
		}
		
		return getPage;
	}
}
