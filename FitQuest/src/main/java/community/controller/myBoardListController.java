package community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import community.model.BoardBean;
import community.model.BoardDao;
import community.model.ScrapBean;
import community.model.ScrapDao;
import member.model.MemberBean;
import utility.Paging;

@Controller
public class myBoardListController {
	private final String command = "/myBoardList.co";
	private final String getPage = "myBoardList";

	@Autowired
	BoardDao boardDao;
	
	@Autowired
	ScrapDao scrapDao;

	@RequestMapping(value=command) 
	public String list(
			@RequestParam(value="pageNumber",required = false) String pageNumber,
			@RequestParam(value="pageNumber2",required = false) String pageNumber2,
			@RequestParam(value="btype",required = false) String btype,
			HttpServletRequest request,
			HttpSession session,
			Model model
			) {
		session.setAttribute("destination", "redirect:/myBoardList.co");
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			Map<String,String> map = new HashMap<String,String>();
			if(pageNumber == null) {
				pageNumber = "1";
			}
			if(btype == null) {
				btype = "";
			}
			map.put("pageNumber", pageNumber);
			map.put("pageNumber2", pageNumber2);
			map.put("id", memberBean.getId());
			map.put("btype", btype);

			int totalCount = boardDao.getMyBoardCount(map);
			System.out.println("totalCount : " + totalCount);
			String url = request.getContextPath() + command;

			Paging pageInfo = new Paging(pageNumber,"5",totalCount,url,null,null,null);

			List<BoardBean> myBoardList = boardDao.getMyBoardList(pageInfo,map);
			List<ScrapBean> myScrapList = scrapDao.getMyScrapList(map);

			model.addAttribute("totalCount", totalCount);
			model.addAttribute("pageNumber", pageNumber);
			model.addAttribute("myBoardList", myBoardList);
			model.addAttribute("myScrapList", myScrapList);
			model.addAttribute("pageInfo", pageInfo);

			return getPage;
		}
	}
}
