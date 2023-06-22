package reservation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IconExplainController {
	private final String command = "/iconExplain.rv";
	private final String getPage = "iconExplain";
	
	@RequestMapping(command)
	public String doAction() {
		return getPage;
	}
}
