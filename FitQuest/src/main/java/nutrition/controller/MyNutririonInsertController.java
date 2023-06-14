package nutrition.controller;


import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import nutrition.model.FoodBean;
import nutrition.model.FoodDao;
import nutrition.model.FoodmarkDao;
import nutrition.model.MealBean;
import nutrition.model.MealDao;
import nutrition.model.NutritionBean;
import nutrition.model.NutritionDao;

@Controller
public class MyNutririonInsertController {
	private final String command = "myNutritionInsert.ht";
	private final String getPage = "myNutritionInsertForm";
	
	@Autowired
	NutritionDao nutritionDao;
	@Autowired
	MealDao mealDao;
	@Autowired
	FoodDao foodDao;
	@Autowired
	FoodmarkDao foodmarkDao;
	
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction() {
		return getPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView doAction(@ModelAttribute("nutritionBean") NutritionBean nutritionBean,
								@ModelAttribute("mealBean") MealBean mealBean,
								@ModelAttribute("foodBean") FoodBean foodBean,
								@RequestParam(value = "foodmark", required = false) String foodmark,
								HttpServletResponse response, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		//System.out.println("foodmark : " + foodmark);// on null
		
		response.setContentType("text/html; charset=UTF-8");
		
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		
		// 로그인 정보 확인
		if(memberBean == null) { 
			session.setAttribute("destination", "redirect:/myNutritionList.ht");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');location.href='login.mb'</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		} else {
			nutritionBean.setId(memberBean.getId());
			nutritionDao.insertNutrition(nutritionBean);
			
			
		}
		
		
		return mav;
	}
	
}
