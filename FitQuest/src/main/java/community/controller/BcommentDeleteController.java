package community.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
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
	public String delete(@RequestParam("cnum") int cnum, @RequestParam("bnum") int bnum ,@RequestParam("id") String id, @RequestParam("btype") String btype ,HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html; charset=utf-8");
		if(btype.equals("자유")) {
			session.setAttribute("destination", "redirect:/freeBoardDetail.co?bnum=" + bnum);
		}
		else {
			session.setAttribute("destination", "redirect:/healthBoardDetail.co?bnum=" + bnum);
		}
		if(session.getAttribute("loginInfo") == null) {
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/login.mb";
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
		if(btype.equals("자유")) {
			return "redirect:/freeBoardDetail.co?bnum=" + bnum;
		}
		else {
			return "redirect:/healthBoardDetail.co?bnum=" + bnum;
		}
	}
}
