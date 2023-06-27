package question.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.MailSendService;

@Controller
public class SendQuestEmailController {
	private final String command = "sendQuestEmail.qt";
	
	@Autowired
	MailSendService mailService;
	
	@RequestMapping(command)
	@ResponseBody
	public String doAction(@RequestParam("temail") String temail,
							@RequestParam("aemail") String aemail,
							@RequestParam("content") String content,
							@RequestParam("subject") String subject) {
		
		
		
		return mailService.trainerEmail(temail,aemail,content,subject);
	}
}
