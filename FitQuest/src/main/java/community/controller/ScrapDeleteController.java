package community.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import community.model.ScrapBean;
import community.model.ScrapDao;
import member.model.MemberBean;

@Controller
public class ScrapDeleteController {
	private final String command = "/scrapDelete.co";
	
	@Autowired
	ScrapDao scrapDao;
	
	@RequestMapping(command)
	public String insert(ScrapBean scrapBean, HttpSession session) {
		session.setAttribute("destination", "redirect:/healthBoardDetail.co?bnum=" + scrapBean.getBnum());
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			if(memberBean.getId().equals(scrapBean.getId())) {
				int cnt = scrapDao.deleteScrap(scrapBean.getSnum());
				if(cnt != -1) {
					System.out.println("삭제 성공");
				}
				else {
					System.out.println("삭제 실패");
				}
			}
		}
		return "redirect:/healthBoardDetail.co?bnum=" + scrapBean.getBnum();
	}
}
