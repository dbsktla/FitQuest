package admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminMainController {
	private final String command = "/adminMain.ad";
	private final String getPage = "adminMain";
	
	@RequestMapping(command)
	public String main() {
		return getPage;
	}
}
