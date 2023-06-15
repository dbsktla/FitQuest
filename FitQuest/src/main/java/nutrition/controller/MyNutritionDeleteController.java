package nutrition.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import nutrition.model.MealBean;
import nutrition.model.MealDao;
import nutrition.model.NutritionDao;

@Controller
public class MyNutritionDeleteController {
	private final String command = "myNutritionDelete.ht";
	private final String gotoPage = "redirect:/myNutritionList.ht";
	
	@Autowired
	NutritionDao nutritionDao;
	
	@Autowired
	MealDao mealDao;
	
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(@RequestParam("mnum") int mnum, @RequestParam("nnum") int nnum) {
		
		int cnt = mealDao.deleteMeal(mnum);
		
		if(cnt != -1) {
			List<MealBean> mlist = mealDao.getMealByNnum(nnum);
			
			if(mlist.isEmpty() || mlist == null) {
				nutritionDao.deleteNutrition(nnum);
			}
		}
		
		return gotoPage;
	}
}
