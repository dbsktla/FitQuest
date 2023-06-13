package nutrition.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MyNutririonInsertController {
	private final String command = "myNutritionInsert.ht";
	private final String getPage = "myNutritionInsertForm";
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction() {
		
		
		return getPage;
	}
	
}
