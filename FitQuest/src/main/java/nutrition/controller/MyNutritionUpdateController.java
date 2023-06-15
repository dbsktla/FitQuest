package nutrition.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
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
import utility.FitQuestUtil;

@Controller
public class MyNutritionUpdateController {
	private final String command = "myNutritionUpdate.ht";
	private final String getPage = "myNutritionUpdateForm";
	private final String gotoPage = "redirect:/myNutritionList.ht";
	
	@Autowired
	MealDao mealDao;
	@Autowired
	FoodDao foodDao;
	@Autowired
	FoodmarkDao foodmarkDao;
	
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView doAction(HttpServletResponse response, HttpSession session,
								@RequestParam("mealtype") String mealtype,
								@RequestParam("mnum") int mnum) {
		
		response.setContentType("text/html; charset=UTF-8");
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		
		ModelAndView mav = new ModelAndView();
		
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
			map.put("mnum", mnum);
			
			List<FoodBean> flist = foodDao.getAllByMnum(map);
			mav.addObject("flist", flist);
			mav.setViewName(getPage);
		}
		return mav;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView doAction(HttpServletResponse response, HttpSession session,
								@ModelAttribute("nutritionBean") NutritionBean nutritionBean,
								@ModelAttribute("mealBean") MealBean mealBean,
								@RequestParam(value = "foodmark", required = false) String foodmark,
								HttpServletRequest request) {
		
		response.setContentType("text/html; charset=UTF-8");
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		
		ModelAndView mav = new ModelAndView();
		
		
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
			// meal 이미지 
			String uploadPath = FitQuestUtil.getValueFromProjectProperties("common_directory") + "/FoodImage";
			
			File destination = new File(uploadPath + File.separator + mealBean.getUpload().getOriginalFilename());
			File delFile = new File(uploadPath + File.separator + mealBean.getUpload2());
			
			if(mealBean.getFimage().equals("")) { // 기존파일
				mealBean.setFimage(mealBean.getUpload2());
			}
			
			int m_cnt = mealDao.updateMeal(mealBean);
			if(m_cnt != -1) {
				// 이미지 파일
				if(mealBean.getFimage().equals(mealBean.getUpload2())) {
					mav.setViewName(gotoPage);
				} else {
					MultipartFile multi = mealBean.getUpload();
					try {
						multi.transferTo(destination);
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					delFile.delete();
					
				}
				// food fnum조건 -> fnum이 그대로 넘어왔다면 식단 유지
				// 만약 delfnum가 있다면 해당 delfnum 삭제 후 새로운 음식 추가하기
				// fnum이 -1 이라면 새로 추가함. -1 인것들 추가하기.
				String[] fnum = request.getParameterValues("fnum");
				String[] fname = request.getParameterValues("fname");
				String[] fweight = request.getParameterValues("fweight");
				String[] calories = request.getParameterValues("calories");
				String[] carbohydrate = request.getParameterValues("carbohydrate");
				String[] protein = request.getParameterValues("protein");
				String[] fat = request.getParameterValues("fat");
				String[] sugar = request.getParameterValues("sugar");
				String[] sodium = request.getParameterValues("sodium");
				
				String[] delfnum = request.getParameterValues("delfnum");
//				
				if(delfnum.length != 1) {
					for(int i=1; i<delfnum.length; i++) {
						if(!delfnum[i].equals("-1")) {
							foodDao.deleteFood(Integer.parseInt(delfnum[i]));
						}
					}
				}
				
				for(int i=0; i<fnum.length; i++) {
					if(fnum[i].equals("-1")) {
						FoodBean foodBean = new FoodBean();
						foodBean.setNnum(nutritionBean.getNnum());
						foodBean.setMnum(mealBean.getMnum());
						foodBean.setFname(fname[i]);
						foodBean.setFweight(Double.parseDouble(fweight[i]));
						foodBean.setCalories(Double.parseDouble(calories[i]));
						foodBean.setCarbohydrate(Double.parseDouble(carbohydrate[i]));
						foodBean.setProtein(Double.parseDouble(protein[i]));
						foodBean.setFat(Double.parseDouble(fat[i]));
						foodBean.setSugar(Double.parseDouble(sugar[i]));
						foodBean.setSodium(Double.parseDouble(sodium[i]));
						
						foodDao.insertFood(foodBean);
					}
				}
				
				System.out.println("delfnum : " + delfnum.length);
				
				// 책갈피가 null이 아니라면 저장 ㄱㄱ
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
				
			} //m_cnt
			
			
			mav.setViewName(gotoPage);
		} // if
		return mav;
	}
	
}
