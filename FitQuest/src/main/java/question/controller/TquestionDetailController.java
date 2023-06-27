package question.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import question.model.TquestionBean;
import question.model.TquestionDao;

@Controller
public class TquestionDetailController {
	private final String command = "tquestionDetail.qt";
	private final String getPage = "tquestionDetail";
	
	@Autowired
	TquestionDao tquestionDao;
	
	@RequestMapping(command)
	public String doAction(@RequestParam("tqnum") int tqnum, Model model) {
		
		TquestionBean tquestionBean = tquestionDao.getTquestionDetail(tqnum);
		model.addAttribute("tquestionBean", tquestionBean);
		return getPage;
	}
}
