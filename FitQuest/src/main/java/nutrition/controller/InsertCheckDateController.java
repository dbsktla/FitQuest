package nutrition.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.MemberBean;
import net.sf.json.JSONArray;
import nutrition.model.MealBean;
import nutrition.model.MealDao;
import nutrition.model.NutritionBean;
import nutrition.model.NutritionDao;

@Controller
public class InsertCheckDateController {
	private final String command = "insertCheckDate.ht";
	
	@Autowired
	NutritionDao nutritionDao;
	
	@Autowired
	MealDao mealDao;
	
	@RequestMapping(value=command, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String doAction(@RequestParam("date") String date, 
							HttpSession session, HttpServletResponse response) {
		
		
		response.setContentType("text/html; charset=UTF-8");
		JSONArray jsArr = new JSONArray();
		
		Map<String, Object> map = new HashMap<String, Object>();
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		map.put("id", memberBean.getId());
		map.put("nudate", date);
		NutritionBean nutritionBean = nutritionDao.getNutritionDateOne(map);
		
		if(nutritionBean != null) {
			List<MealBean> mlist = mealDao.getMealByNnum(nutritionBean.getNnum());
			int i = 0;
			for(MealBean mb : mlist) {
				jsArr.add(i, mb.getMealtype());
				i++;
			}
		}else {
			jsArr.add(0, "Nodata");
		}
		System.out.println(jsArr.toString());
		return jsArr.toString();
	}
}
