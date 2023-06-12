package community.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import community.model.BcommentBean;
import community.model.BcommentDao;
import community.model.BoardBean;
import community.model.BoardDao;
import community.model.ScrapBean;
import community.model.ScrapDao;
import member.model.MemberBean;

@Controller
public class HealthBoardDetailController {
	private final String command = "/healthBoardDetail.co";
	private final String getPage = "healthBoardDetail";

	@Autowired
	BoardDao boardDao;
	
	@Autowired
	BcommentDao bcommentDao;
	
	@Autowired
	ScrapDao scrapDao;

	@RequestMapping(command)
	public ModelAndView detail(@RequestParam("bnum") int bnum, HttpSession session){
		session.setAttribute("destination", "redirect:/healthBoardDetail.co?bnum=" + bnum);
		
		ModelAndView mav = new ModelAndView();
		BoardBean boardBean = null;
		List<BcommentBean> bcommentList = null;
		if((String)session.getAttribute("healthBoardListFlag") == null) {
			session.setAttribute("healthBoardListFlag", "true");
		}
		String healthBoardListFlag = (String)session.getAttribute("healthBoardListFlag");
		if( healthBoardListFlag.equals("true")) { 
			int cnt = boardDao.updateBreadcount(bnum);
			if(cnt != -1) {
				boardBean = boardDao.getOnehealthBoard(bnum);
			}
			session.setAttribute("healthBoardListFlag", "false");
		}
		else {
			boardBean = boardDao.getOnehealthBoard(bnum);
		}
		bcommentList = bcommentDao.getBcommentList(bnum);
		ScrapBean scrapBean = null;
		if(session.getAttribute("loginInfo") != null) {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			scrapBean = scrapDao.getScrapByIdAndBnum(memberBean.getId(), bnum);
		}
		
		mav.addObject("boardBean", boardBean);
		mav.addObject("bcommentList", bcommentList);
		mav.addObject("scrapBean", scrapBean);
		mav.setViewName(getPage);
		return mav;
	}
}
