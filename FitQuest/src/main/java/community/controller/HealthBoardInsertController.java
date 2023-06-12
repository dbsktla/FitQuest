package community.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import community.model.BoardBean;
import community.model.BoardDao;
import member.model.MemberBean;
import utility.FitQuestUtil;

@Controller
public class HealthBoardInsertController {
	private final String command = "/healthBoardInsert.co";
	private final String getPage = "healthBoardInsertForm";
	private final String gotoPage = "redirect:/healthBoardList.co";

	@Autowired
	BoardDao boardDao;

	@RequestMapping(value = command, method=RequestMethod.GET)
	public String insert(HttpSession session) {
		session.setAttribute("destination", gotoPage);
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			return getPage;
		}
	}

	@RequestMapping(value = command, method=RequestMethod.POST)
	public String insert(@Valid BoardBean boardBean, BindingResult result, HttpSession session) {
		session.setAttribute("destination", "redirect:/healthBoardInsert.co");
		
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			String uploadPath = FitQuestUtil.getValueFromProjectProperties("common_directory") + "/CommunityImage";
			
			if(result.hasErrors()) {
				return getPage;
			}
			else {

				MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
				boardBean.setId(memberBean.getId());
				boardBean.setBtype("건강");
				
				try {
					if(!boardBean.getUpload().isEmpty()) {
						File destination = new File(uploadPath + File.separator + boardBean.getUpload().getOriginalFilename());
						MultipartFile multi =  boardBean.getUpload();
						multi.transferTo(destination);
						System.out.println("image : " + boardBean.getBimage());
					}
					int cnt = boardDao.insertHealthBoard(boardBean);
					System.out.println("InsertHealthBoard cnt : " + cnt);
					if(cnt != -1) {
						System.out.println("삽입 성공");
						return gotoPage;
					}
					else {
						System.out.println("삽입 실패");
						return getPage;
					}
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
			}
		}
		return getPage;
	}
}
