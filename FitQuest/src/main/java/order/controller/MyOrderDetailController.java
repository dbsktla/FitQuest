package order.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyOrderDetailController {
	private final String command = "";
	private final String getPage = "";
	
	@RequestMapping(value = command)
	public String doAction() {
		
		return getPage;	
	}
}
