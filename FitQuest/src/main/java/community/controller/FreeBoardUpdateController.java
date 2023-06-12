package community.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import community.model.BoardBean;
import community.model.BoardDao;
import member.model.MemberBean;

@Controller
public class FreeBoardUpdateController {
	private final String command = "/freeBoardUpdate.co";
	private final String getPage = "freeBoardUpdateForm";
	private final String gotoPage = "redirect:/freeBoardList.co";

	@Autowired
	BoardDao boardDao;

	@RequestMapping(value=command, method = RequestMethod.GET)
	public String update(@RequestParam("bnum") int bnum, @RequestParam("id") String id, HttpSession session, Model model) {
		session.setAttribute("destination", "redirect:/freeBoardDetail.co?bnum=" + bnum);
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			if(memberBean.getId().equals(id)) {
				BoardBean boardBean = boardDao.getOneFreeBoard(bnum);
				model.addAttribute("boardBean",boardBean);
				return getPage;
			}
		}

		return gotoPage;
	}

	@RequestMapping(value = command, method=RequestMethod.POST)
	public String insert(@Valid BoardBean boardBean, BindingResult result, HttpSession session) {

		session.setAttribute("destination", "redirect:/freeBoardDetail.co?bnum=" + boardBean.getBnum());
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			if(result.hasErrors()) {
				return getPage;
			}
			else {

				MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
				if(memberBean.getId().equals(boardBean.getId())) {
					boardBean.setId(memberBean.getId());
					boardBean.setBtype("자유");
					boardBean.setBrestep(0);
					boardBean.setBrelevel(0);

					int cnt = boardDao.updateFreeBoard(boardBean);
					System.out.println("UpdateFreeBoard cnt : " + cnt);
					if(cnt != -1) {
						System.out.println("수정 성공");
						return gotoPage;
					}
					else {
						System.out.println("수정 실패");
						return getPage;
					}
				}
			}
			return getPage;
		}
	}
}