package community.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
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

	@Autowired
	BoardDao boardDao;

	@RequestMapping(value=command, method = RequestMethod.GET)
	public String update(@RequestParam("bnum") int bnum, @RequestParam("id") String id, HttpSession session, Model model, HttpServletResponse response) {
		response.setContentType("text/html; charset=utf-8");
		session.setAttribute("destination", "redirect:/healthBoardDetail.co?bnum=" + bnum);
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
				BoardBean boardBean = boardDao.getOnehealthBoard(bnum);
				model.addAttribute("boardBean",boardBean);
				return getPage;
			}
		}

		return "";
	}

	@RequestMapping(value = command, method=RequestMethod.POST)
	public String insert(@Valid BoardBean boardBean, BindingResult result, HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html; charset=utf-8");
		session.setAttribute("destination", "redirect:/healthBoardDetail.co?bnum=" + boardBean.getBnum());
		String uploadPath = FitQuestUtil.getValueFromProjectProperties("common_directory") + "/CommunityImage";
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
			if(result.hasErrors()) {
				return getPage;
			}
			else {
				try {
					if(boardBean.getUpload() != null) {
						if(boardBean.getBimageOld() != null) {
							int bimageCount = boardDao.selectBimageCount(boardBean.getBimageOld());
							if(bimageCount == 1) {
								File deleteFile = new File(uploadPath + File.separator + boardBean.getBimageOld());
								if(deleteFile.exists()) {
									if(deleteFile.delete()) {
										System.out.println("이전 이미지 삭제 성공");
									}
								}	
							}
							else {
								System.out.println("동일한 이미지를 사용하는 칼럼 존재");
							}
						}
						File destination = new File(uploadPath + File.separator + boardBean.getUpload().getOriginalFilename());
						MultipartFile multi =  boardBean.getUpload();
						multi.transferTo(destination);
						System.out.println("image : " + boardBean.getBimage());
					}
					else {
						if(boardBean.getBimageOld() != null) {
							boardBean.setBimage(boardBean.getBimageOld());
						}
					}
					MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
					if(memberBean.getId().equals(boardBean.getId())) {
						boardBean.setId(memberBean.getId());
						boardBean.setBtype("건강");
						int cnt = boardDao.updateHealthBoard(boardBean);
						System.out.println("UpdateHealthBoard cnt : " + cnt);
						if(cnt != -1) {
							System.out.println("수정 성공");
							return "redirect:/healthBoardDetail.co?bnum=" + boardBean.getBnum();
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

	@RequestMapping("showBimage.co")
	public String showBimage() {
		return "showBimage";
	}
}