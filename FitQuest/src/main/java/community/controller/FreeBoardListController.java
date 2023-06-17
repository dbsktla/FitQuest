package community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import community.model.BoardBean;
import community.model.BoardDao;
import utility.Paging;

@Controller
public class FreeBoardListController {
	private final String command = "/freeBoardList.co";
	private final String getPage = "freeBoardList";
	
	@Autowired
	BoardDao boardDao;
	
	@RequestMapping(value=command) 
	public ModelAndView list(
			@RequestParam(value="whatColumn",required = false) String whatColumn, 
			@RequestParam(value="keyword",required = false) String keyword,
			@RequestParam(value="pageNumber",required = false) String pageNumber,
			@RequestParam(value="bcategory",required = false) String bcategory,
			HttpServletRequest request,
			HttpSession session
	) {
		session.setAttribute("destination", "redirect:freeBoardList.co");
		session.setAttribute("topmenu", "healthBoard");
		
		if(bcategory == null) {
			bcategory = "";
		}
		
		ModelAndView mav = new ModelAndView();
		Map<String,String> map = new HashMap<String,String>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%" + keyword + "%");
		map.put("btype", "자유");
		map.put("bcategory", bcategory);
		if(pageNumber == null) {
			pageNumber = "1";
		}
		map.put("pageNumber", pageNumber);
		
		System.out.println("whatColumn : " + whatColumn);
		System.out.println("bcategory : " + bcategory);

		int totalCount = boardDao.getFreeBoardCount(map);
		System.out.println("totalCount : " + totalCount);
		String url = request.getContextPath() + command;

		Paging pageInfo = new Paging(pageNumber,"5",totalCount,url,whatColumn,keyword,null);

		List<BoardBean> freeBoardList = boardDao.getFreeBoardList(pageInfo,map);
		List<BoardBean> hotFreeBoardList = boardDao.getHotFreeBoardList();
		
		mav.addObject("totalCount", totalCount);
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("freeBoardList", freeBoardList);
		mav.addObject("hotFreeBoardList", hotFreeBoardList);
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("bcategory", bcategory);
		mav.setViewName(getPage);
		
		return mav;
	}
}
