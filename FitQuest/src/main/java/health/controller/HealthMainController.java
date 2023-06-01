package health.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HealthMainController {
	private final String command = "health.ht";
	// 일반회원
	private final String getPage = "myHealthMain";
	// 트레이너
	private final String getPageT = "trainerHealthMain";
	
	// 내 운동 관리 페이지로 이동
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction() {
		
		return getPage;
	}
}