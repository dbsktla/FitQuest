package nutrition.controller;


import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import nutrition.model.FoodBean;
import nutrition.model.FoodDao;
import nutrition.model.FoodmarkBean;
import nutrition.model.FoodmarkDao;
import nutrition.model.MealBean;
import nutrition.model.MealDao;
import nutrition.model.NutritionBean;
import nutrition.model.NutritionDao;
import utility.FitQuestUtil;

@Controller
public class MyNutririonInsertController {
	private final String command = "myNutritionInsert.ht";
	private final String getPage = "myNutritionInsertForm";
	private final String gotoPage = "redirect:/myNutritionList.ht";
	
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
	public String doAction(@ModelAttribute("nutritionBean") NutritionBean nutritionBean,
								@ModelAttribute("mealBean") MealBean mealBean,
								HttpServletRequest request,
								@RequestParam(value = "foodmark", required = false) String foodmark,
								HttpServletResponse response, HttpSession session) {
		
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
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", memberBean.getId());
			map.put("nudate", nutritionBean.getNudate());
			
			NutritionBean oldnuBean = nutritionDao.getNutritionDateOne(map);
			int cnt_nu = 0;
			int nnum = 0;
			
			if(oldnuBean == null) { // 날짜데이터 존재하지 않을때 삽입
				nutritionBean.setId(memberBean.getId());
				cnt_nu = nutritionDao.insertNutrition(nutritionBean);
				nnum = nutritionDao.getMaxNnum();
			}else { //이미 존재하면 원래꺼 ㄱㄱ
				nnum = oldnuBean.getNnum();
			}
			
			if(cnt_nu != -1) { // nutrition 성공
				
				mealBean.setNnum(nnum);
				
				String uploadPath = FitQuestUtil.getValueFromProjectProperties("common_directory") + "/FoodImage";
				File destination = new File(uploadPath + File.separator + mealBean.getUpload().getOriginalFilename());
				
				MultipartFile multi =  mealBean.getUpload();
				
				int cnt_m = mealDao.insertMeal(mealBean);
				if(cnt_m != -1) { // meal 성공
					try {
						multi.transferTo(destination);
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					
					int mnum = mealDao.getMaxMnum();
					String[] fname = request.getParameterValues("fname");
					String[] fweight = request.getParameterValues("fweight");
					String[] calories = request.getParameterValues("calories");
					String[] carbohydrate = request.getParameterValues("carbohydrate");
					String[] protein = request.getParameterValues("protein");
					String[] fat = request.getParameterValues("fat");
					String[] sugar = request.getParameterValues("sugar");
					String[] sodium = request.getParameterValues("sodium");
					
					//Double.parseDouble();
					
					int cnt_f = 0;
					int[] fnum = new int[fname.length];
					for(int i=0; i<fname.length; i++) {
						FoodBean foodBean = new FoodBean();
						foodBean.setNnum(nnum);
						foodBean.setMnum(mnum);
						foodBean.setFname(fname[i]);
						foodBean.setFweight(Double.parseDouble(fweight[i]));
						foodBean.setCalories(Double.parseDouble(calories[i]));
						foodBean.setCarbohydrate(Double.parseDouble(carbohydrate[i]));
						foodBean.setProtein(Double.parseDouble(protein[i]));
						foodBean.setFat(Double.parseDouble(fat[i]));
						foodBean.setSugar(Double.parseDouble(sugar[i]));
						foodBean.setSodium(Double.parseDouble(sodium[i]));
						
						cnt_f += foodDao.insertFood(foodBean);
						fnum[i] = foodDao.getMaxFnum();
					}
					System.out.println("cnt_f : " + cnt_f);
					
					if(foodmark != null) {
						for(int i=0; i<fnum.length; i++) {
							FoodmarkBean foodmarkBean = new FoodmarkBean();
							foodmarkBean.setId(memberBean.getId());
							foodmarkBean.setFname(fname[i]);
							foodmarkBean.setFweight(Double.parseDouble(fweight[i]));
							foodmarkBean.setCalories(Double.parseDouble(calories[i]));
							foodmarkBean.setCarbohydrate(Double.parseDouble(carbohydrate[i]));
							foodmarkBean.setProtein(Double.parseDouble(protein[i]));
							foodmarkBean.setFat(Double.parseDouble(fat[i]));
							foodmarkBean.setSugar(Double.parseDouble(sugar[i]));
							foodmarkBean.setSodium(Double.parseDouble(sodium[i]));
							
							int count = foodmarkDao.countFoodmark(foodmarkBean); //id, fname
							if(count == 0) {
								foodmarkDao.insertFoodmark(foodmarkBean);
							}
						}
					}
					
				} // if meal
				
			} // if nutrition
			
		} // if
		
		return gotoPage;
	}
	
}
