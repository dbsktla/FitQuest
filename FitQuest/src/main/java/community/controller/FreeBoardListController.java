package community.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FreeBoardListController {
	private final String command = "freeBoardList.co";
	private final String getPage = "freeBoardList";
	
	@RequestMapping(value=command) 
	public String list() {
		return getPage;
	}
}
