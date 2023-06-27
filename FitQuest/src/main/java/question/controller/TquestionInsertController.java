package question.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import question.model.TquestionBean;
import question.model.TquestionDao;

@Controller
public class TquestionInsertController {
	private final String command ="tquestionInsert.qt";
	private final String getPage = "tempPage";
	
	@Autowired
	TquestionDao tquestionDao;
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String doAction(@ModelAttribute("tquestionBean") TquestionBean tquestionBean) {
		int cnt = tquestionDao.insertTQuestion(tquestionBean);
		
		System.out.println("cnt : " + cnt);
		return getPage;
	}
}
