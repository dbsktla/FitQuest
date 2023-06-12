package community.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import community.model.BoardBean;
import community.model.BoardDao;
import member.model.MemberBean;
import utility.FitQuestUtil;

@Controller
public class HealthBoardUpdateController {
	private final String command = "/healthBoardUpdate.co";
	private final String getPage = "healthBoardUpdateForm";
	private final String gotoPage = "redirect:/healthBoardList.co";

	@Autowired
	BoardDao boardDao;

	@RequestMapping(value=command, method = RequestMethod.GET)
	public String update(@RequestParam("bnum") int bnum, @RequestParam("id") String id, HttpSession session, Model model) {
		session.setAttribute("destination", "redirect:/healthBoardDetail.co?bnum=" + bnum);
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			if(memberBean.getId().equals(id)) {
				BoardBean boardBean = boardDao.getOnehealthBoard(bnum);
				model.addAttribute("boardBean",boardBean);
				return getPage;
			}
		}

		return gotoPage;
	}

	@RequestMapping(value = command, method=RequestMethod.POST)
	public String insert(@Valid BoardBean boardBean, BindingResult result, HttpSession session) {
		session.setAttribute("destination", "redirect:/healthBoardDetail.co?bnum=" + boardBean.getBnum());
		String uploadPath = FitQuestUtil.getValueFromProjectProperties("common_directory") + "/CommunityImage";
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			if(result.hasErrors()) {
				return getPage;
			}
			else {
				try {
					if(boardBean.getUpload() != null) {
						File destination = new File(uploadPath + File.separator + boardBean.getUpload().getOriginalFilename());
						MultipartFile multi =  boardBean.getUpload();
						multi.transferTo(destination);
						System.out.println("image : " + boardBean.getBimage());
					}
					MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
					if(memberBean.getId().equals(boardBean.getId())) {
						boardBean.setId(memberBean.getId());
						boardBean.setBtype("건강");
						int cnt = boardDao.updateHealthBoard(boardBean);
						System.out.println("UpdateHealthBoard cnt : " + cnt);
						if(cnt != -1) {
							System.out.println("수정 성공");
							return gotoPage;
						}
						else {
							System.out.println("수정 실패");
							return getPage;
						}
					}
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			return getPage;
		}
	}
}