package health.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HealthMainController {
	private final String command = "health.ht";
	private final String getPage = "healthMain";
	
	// 내 운동 관리 페이지로 이동
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction() {
		return getPage;
	}
}
