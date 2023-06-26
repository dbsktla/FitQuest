package main.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import community.model.BoardBean;
import community.model.BoardDao;
import member.model.MemberBean;
import member.model.MemberDao;
import review.model.ReviewBean;
import review.model.ReviewDao;

@Controller
public class MainController {
	private final String command = "main.go";
	private final String getPage = "main";
	
	@Autowired
	ReviewDao reviewDao;
	
	@Autowired
	MemberDao memberDao;
	
	@Autowired
	BoardDao boardDao;
	
	@RequestMapping(command)
	public String doAction(HttpSession session, Model model) {
		session.setAttribute("destination", "redirect:/main.go");
		session.setAttribute("topmenu", "main");
		
		MemberBean memberBean = (MemberBean) session.getAttribute("loginInfo");
		
		List<ReviewBean> reviewList = reviewDao.getMainReviewList();
		List<BoardBean> healthBoardList = boardDao.getMainHealthBoardList();
		List<MemberBean> trainerList = memberDao.getMainTrainerList();
		
		model.addAttribute("memberBean", memberBean);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("healthBoardList", healthBoardList);
		model.addAttribute("trainerList", trainerList);
		return getPage;
	}
}
