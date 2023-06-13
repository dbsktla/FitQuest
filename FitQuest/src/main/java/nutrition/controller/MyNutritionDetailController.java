package nutrition.controller;

import java.io.IOException;
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
import net.sf.json.JSONObject;
import nutrition.model.FoodBean;
import nutrition.model.FoodDao;

@Controller
public class MyNutritionDetailController {
	private final String command = "myNutritionDetail.ht";
	
	@Autowired
	FoodDao foodDao;
	
	@RequestMapping(value = command, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String doAction(HttpServletResponse response, HttpSession session,
							@RequestParam("selectDate") String selectDate) {
		
		response.setContentType("text/html; charset=UTF-8");
		
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		JSONArray jsArr = new JSONArray();
		JSONObject jsFList = new JSONObject();
		
		// 로그인 정보 확인
		if(memberBean == null) { 
			session.setAttribute("destination", "redirect:/myNutritionList.ht");
			jsFList.put("returnData", "idNull");
			return jsFList.toString();
		} else {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", memberBean.getId());
			map.put("selectDate", selectDate);
			
			List<FoodBean> flist = foodDao.getAllDetailByDate(map);
			
			if(flist.isEmpty()) {
				jsFList.put("returnData", "BeanNull");
				System.out.println("jsArr Re : " + jsFList.toString());
				return jsFList.toString();
			}else {
				for(FoodBean fb : flist) {
					
					JSONObject jsObject = new JSONObject();
					jsObject.put("nnum", fb.getNnum());
					jsObject.put("mnum", fb.getMnum());
					jsObject.put("id", fb.getId());
					jsObject.put("nudate", fb.getNudate());
					jsObject.put("mealtype", fb.getMealtype());
					jsObject.put("fimage", fb.getFimage());
					jsObject.put("fname", fb.getFname());
					jsObject.put("fweight", fb.getFweight());
					jsObject.put("calories", fb.getCalories());
					jsObject.put("carbohydrate", fb.getCarbohydrate());
					jsObject.put("protein", fb.getProtein());
					jsObject.put("fat", fb.getFat());
					jsObject.put("sugar", fb.getSugar());
					jsObject.put("sodium", fb.getSodium());
					
					jsFList.put("flist", jsObject);
					jsArr.add(jsFList);
				}
				System.out.println("jsArr F : " + jsArr.toString());
				return jsArr.toString();
			}// if
			
		}// login if
	} // doAction
}
