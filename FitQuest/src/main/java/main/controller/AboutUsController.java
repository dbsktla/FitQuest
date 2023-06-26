package main.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AboutUsController {
	private final String command = "aboutUs.go";
	private final String getPage = "aboutUs";
	
	@RequestMapping(command)
	public String doAction(HttpSession session, Model model) {
		session.setAttribute("topmenu", "aboutUs");
		return getPage;
	}
}
