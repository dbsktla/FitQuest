package nutrition.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MyNutritionController {
	private final String command = "myNutritionList.ht";
	private final String getPage = "myNutritionList";
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction() {
		return getPage;
	}
}
