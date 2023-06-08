package community.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import community.model.BoardBean;
import community.model.BoardDao;

@Controller
public class FreeBoardDetailController {
	private final String command = "/freeBoardDetail.co";
	private final String getPage = "freeBoardDetail";

	@Autowired
	BoardDao boardDao;

	@RequestMapping(command)
	public ModelAndView detail(@RequestParam("bnum") int bnum, HttpSession session){
		session.setAttribute("destination", "redirect:/freeBoardDetail.co?bnum=" + bnum);
		
		ModelAndView mav = new ModelAndView();
		BoardBean boardBean = null;

		String freeBoardListFlag = (String)session.getAttribute("freeBoardListFlag");
		if(freeBoardListFlag.equals("true")) { //상세보기에서 새로고침 누르면 조회수 count + 1 방지
			int cnt = boardDao.updateBreadcount(bnum);
			if(cnt != -1) {
				boardBean = boardDao.getOneFreeBoard(bnum);
			}
			session.setAttribute("freeBoardListFlag", "false");
		}
		else {
			boardBean = boardDao.getOneFreeBoard(bnum);
		}
		mav.addObject("boardBean", boardBean);
		mav.setViewName(getPage);
		return mav;
	}
}
