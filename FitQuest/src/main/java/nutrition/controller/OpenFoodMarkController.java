package nutrition.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import member.model.MemberBean;
import nutrition.model.FoodBean;
import nutrition.model.FoodmarkDao;

@Controller
public class OpenFoodMarkController {
	private final String command = "openFoodMark.ht";
	private final String getPage = "foodMarkList";
	
	@Autowired
	FoodmarkDao foodmarkDao;
	
	@RequestMapping(value=command, method = RequestMethod.GET)
	public String doAction(Model model, HttpServletResponse response, HttpSession session) {
		
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
			List<FoodBean> fklist = foodmarkDao.getFoodMarkList(memberBean.getId());
			model.addAttribute("fklist", fklist);
		}
		
		return getPage;
	}
}
