package review.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import review.model.ReviewBean;
import review.model.ReviewDao;

@Controller
public class ReviewDeleteController {
	private final String command = "deleteReview.mb";
	private final String getPage = "redirect:/viewMyReviewList.mb";
	@Autowired
	ReviewDao reviewDao;
	@RequestMapping(value = command)
	public String doAction(@RequestParam("renum") int renum,
						   HttpSession session) {
		ReviewBean reviewBean = reviewDao.getReviewByRenum(renum);
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		int cnt = reviewDao.deleteReview(renum); //리뷰 삭제 시킴
		
		if(cnt > 0) { 
			System.out.println("리뷰 삭제 성공");
		}
		int reviewCount = reviewDao.getTrainerReviewCount(reviewBean.getTid()); //트레이너의 리뷰 수
		if(reviewCount == 0) { //만약에 초기 값을 넣는다. 리뷰 없는 상태로 설정하는것.
			reviewDao.insertBaseValue(reviewBean.getTid());
		}
		if(memberBean.getMtype().equals("admin")) { //만약 관리자로 로그인 된거면 다시 로그인 요청으로
			return "redirect:/adminReviewReportList.ad";
		}
		return getPage;
	}
}
