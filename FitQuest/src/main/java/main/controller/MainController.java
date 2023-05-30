package main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	private final String command = "main.go";
	private final String getPage = "main";
	
	@RequestMapping(command)
	public String doAction() {
		return getPage;
	}
}
