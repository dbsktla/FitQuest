package question.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class OpenTQuestionController {
	private final String command = "openTQuestion.qt";
	
	
	@RequestMapping(command)
	public String doAction(@RequestParam("tid") String tid) {
		
		return "";
	}
	
}
