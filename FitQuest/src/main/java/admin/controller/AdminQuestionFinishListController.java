package admin.controller;

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

import member.model.MemberBean;
import question.model.QuestionBean;
import question.model.QuestionDao;
import utility.Paging;

@Controller
public class AdminQuestionFinishListController {
	private final String command = "/adminQuestTionFinishList.ad";
	private final String getPage = "adminQuestionFinishList";
	
	@Autowired
	QuestionDao questionDao;
	
	@RequestMapping(command)
	public String list(
					HttpSession session, 
					Model model,
					@RequestParam(value="pageNumber",required = false) String pageNumber,
					HttpServletRequest request
		) {
		session.setAttribute("destination", "redirect:/adminQuestTionFinish.ad");
		if(session.getAttribute("loginInfo") == null) {
			return "redirect:/login.mb";
		}
		else {
			MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
			if(memberBean.getId().equals("admin")) {
				Map<String,String> map = new HashMap<String,String>();
				map.put("whatColumn", "");
				map.put("keyword", "");
				if(pageNumber == null) {
					pageNumber = "1";
				}
				map.put("pageNumber", pageNumber);
				int totalCount = questionDao.getQuestionFinishCount();
				String url = request.getContextPath() + command;
				Paging pageInfo = new Paging(pageNumber,"5",totalCount,url,"","",null);
				List<QuestionBean> QueFinList = questionDao.getQuestionFinishList(pageInfo,map);
				model.addAttribute("totalCount", totalCount);
				model.addAttribute("pageNumber", pageNumber);
				model.addAttribute("pageInfo", pageInfo);
				model.addAttribute("QueFinList",QueFinList);
				return getPage;
			}
			else {
				return "redirect:/login.mb";
			}
		}
	}
	
}
