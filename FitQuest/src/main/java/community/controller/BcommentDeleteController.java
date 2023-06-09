package community.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import community.model.BcommentDao;
import member.model.MemberBean;

@Controller
public class BcommentDeleteController {
	private final String command = "/bcommentDelete.co";
	
	@Autowired
	BcommentDao bcommentDao;
	
	@RequestMapping(command)
	public String delete(@RequestParam("cnum") int cnum, @RequestParam("bnum") int bnum ,@RequestParam("id") String id, HttpSession session) {
		session.setAttribute("destination", "redirect:/freeBoardDetail.co?bnum=" + bnum);
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			if(memberBean.getId().equals(id)) {
				int cnt = bcommentDao.deleteBcomment(cnum);
				System.out.println("DeleteBcomment cnt : " + cnt);
				if(cnt != -1) {
					System.out.println("삭제 성공");
				}
				else {
					System.out.println("삭제 실패");
				}
			}
		}
		
		return "redirect:/freeBoardDetail.co?bnum=" + bnum;
	}
}
