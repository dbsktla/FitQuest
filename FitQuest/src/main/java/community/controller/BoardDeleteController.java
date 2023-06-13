package community.controller;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import community.model.BoardBean;
import community.model.BoardDao;
import member.model.MemberBean;
import utility.FitQuestUtil;

@Controller
public class BoardDeleteController {
	private final String command = "/boardDelete.co";
	private final String getPageFree = "redirect:/freeBoardList.co";
	private final String getPageHealth = "redirect:/healthBoardList.co";
	
	@Autowired
	BoardDao boardDao;
	
	@RequestMapping(command)
	public String delete(@RequestParam("bnum") int bnum, @RequestParam("id") String id, @RequestParam("btype") String btype,HttpSession session) {
		if(btype.equals("자유")) {
			session.setAttribute("destination", "redirect:/freeBoardDetail.co?bnum=" + bnum);
		}
		else {
			session.setAttribute("destination", "redirect:/healthBoardList.co?bnum=" + bnum);
		}
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			if(memberBean.getId().equals(id)) {
				BoardBean boardBean = boardDao.getOnehealthBoard(bnum);
				int cnt = boardDao.deleteBoard(bnum);
				System.out.println("DeleteBoard cnt : " + cnt);
				if(cnt != -1) {
					System.out.println("---------------------------------------------------");
					System.out.println("삭제 성공");
					System.out.println("bimage : " + boardBean.getBimage());
					if(boardBean.getBimage() != null) {
						int bimageCount = boardDao.selectBimageCount(boardBean.getBimage());
						System.out.println("bimageCount : " + bimageCount);
						if(bimageCount == 0) {
							String uploadPath = FitQuestUtil.getValueFromProjectProperties("common_directory") + "/CommunityImage";
							File deleteFile = new File(uploadPath + File.separator + boardBean.getBimage());
							if(deleteFile.exists()) {
								if(deleteFile.delete()) {
									System.out.println("이미지 삭제 성공");
								}
							}	
						}
						else {
							System.out.println("동일한 이미지를 사용하는 칼럼 존재");
						}
					}
					System.out.println("---------------------------------------------------");
				}
				else {
					System.out.println("삭제 실패");
				}
			}
		}
		if(btype.equals("자유")) {
			return getPageFree;
		}
		else {
			return getPageHealth;
		}
	}
}
