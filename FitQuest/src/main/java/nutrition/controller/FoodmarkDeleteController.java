package nutrition.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import nutrition.model.FoodmarkDao;

@Controller
public class FoodmarkDeleteController {
	private final String command = "foodmarkDelete.ht";
	
	@Autowired
	FoodmarkDao foodmarkDao;
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	@ResponseBody
	public String doAction(@RequestParam("fknum") int fknum) {
		int cnt = foodmarkDao.deleteFoodmark(fknum);
		
		if(cnt != -1) {
			return "Y";
		}else {
			return "N";
		}
	}
}
