package community.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import community.model.BcommentBean;
import community.model.BcommentDao;
import member.model.MemberBean;

@Controller
public class BcommentInsertController {
	private final String command = "/bcommentInsert.co";
	
	@Autowired
	BcommentDao bcommentDao;
	
	@RequestMapping(command)
	public String insert(HttpSession session, BcommentBean bcommentBean, @RequestParam("btype") String btype) {
		if(btype.equals("자유")) {
			session.setAttribute("destination", "redirect:/freeBoardDetail.co?bnum=" + bcommentBean.getBnum());
		}
		else {
			session.setAttribute("destination", "redirect:/healthBoardDetail.co?bnum=" + bcommentBean.getBnum());
		}
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			bcommentBean.setId(memberBean.getId());
			bcommentBean.setCrestep(0);
			bcommentBean.setCrelevel(0);
			int cnt = bcommentDao.insertBcomment(bcommentBean);
			if(cnt != -1) {
				System.out.println("삽입 성공");
			}
			else {
				System.out.println("삽입 실패");
			}
			if(btype.equals("자유")) {
				return "redirect:/freeBoardDetail.co?bnum=" + bcommentBean.getBnum();
			}
			else {
				return "redirect:/healthBoardDetail.co?bnum=" + bcommentBean.getBnum();
			}
		}
	}
	
	
	
}
