package nutrition.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import nutrition.model.FoodBean;
import utility.NullUtil;

@Controller
public class SearchInputFoodController {
	private final String command = "searchInputFood.ht";
	private final String getPage = "searchInputFood";
	
	@RequestMapping(value=command)
	public String doAction(HttpServletRequest request, Model model) {
		FoodBean foodBean = new FoodBean();
		foodBean.setFname(request.getParameter("fname"));
		foodBean.setFweight(NullUtil.nvlNA(request.getParameter("fweight"), 0));
		foodBean.setCalories(NullUtil.nvlNA(request.getParameter("calories"), 0));
		foodBean.setCarbohydrate(NullUtil.nvlNA(request.getParameter("carbohydrate"), 0));
		foodBean.setProtein(NullUtil.nvlNA(request.getParameter("protein"), 0));
		foodBean.setFat(NullUtil.nvlNA(request.getParameter("fat"), 0));
		foodBean.setSugar(NullUtil.nvlNA(request.getParameter("sugar"), 0));
		foodBean.setSodium(NullUtil.nvlNA(request.getParameter("sodium"), 0));
		
		model.addAttribute("foodBean", foodBean);
		return getPage;
	}
}
