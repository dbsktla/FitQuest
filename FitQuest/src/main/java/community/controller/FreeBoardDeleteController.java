package community.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import community.model.BoardDao;
import member.model.MemberBean;

@Controller
public class FreeBoardDeleteController {
	private final String command = "/freeBoardDelete.co";
	private final String getPage = "redirect:/freeBoardList.co";
	
	@Autowired
	BoardDao boardDao;
	
	@RequestMapping(command)
	public String delete(@RequestParam("bnum") int bnum, @RequestParam("id") String id, HttpSession session) {
		session.setAttribute("destination", "redirect:/freeBoardInsert.co");
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			if(memberBean.getId().equals(id)) {
				int cnt = boardDao.deleteFreeBoard(bnum);
				System.out.println("DeleteFreeBoard cnt : " + cnt);
				if(cnt != -1) {
					System.out.println("삭제 성공");
				}
				else {
					System.out.println("삭제 실패");
				}
			}
		}
		
		return getPage;
	}
}
