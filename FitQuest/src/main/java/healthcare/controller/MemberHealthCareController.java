package healthcare.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberHealthCareController {
	private final String commnad = "memberHealthCare.ht";
	private final String getPage = "memberHealthCareMain";
	
	@RequestMapping(value = commnad)
	public String doAction() {
		
		return getPage;
	}
}
