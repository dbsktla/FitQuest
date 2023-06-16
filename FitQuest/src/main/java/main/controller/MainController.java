package main.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	private final String command = "main.go";
	private final String getPage = "main";
	
	@RequestMapping(command)
	public String doAction(HttpSession session) {
		session.setAttribute("destination", "redirect:/main.go");
		session.setAttribute("topmenu", "main");
		return getPage;
	}
}
