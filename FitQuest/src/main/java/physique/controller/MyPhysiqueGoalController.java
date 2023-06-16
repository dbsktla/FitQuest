package physique.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import physique.model.GoalphysiqueBean;
import physique.model.GoalphysiqueDao;

@Controller
public class MyPhysiqueGoalController {
	private final String command = "myPhysiqueGoal.ht";
	private final String getPage = "myPhysiqueGoalForm";
	private final String gotoPage = "redirect:/health.ht";
	
	@Autowired
	GoalphysiqueDao goalphysiqueDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(HttpSession session, HttpServletResponse response, Model model) {
		response.setContentType("text/html; charset=UTF-8");
		
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		
		// 로그인 정보 확인
		if(memberBean == null) { 
			session.setAttribute("destination", "redirect:/myPhysiqueGoal.ht");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');location.href='login.mb'</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			GoalphysiqueBean goalphysiqueBean = goalphysiqueDao.getOneGoal(memberBean.getId());
			model.addAttribute("goalphysiqueBean", goalphysiqueBean);
		}
		return getPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView doAction(HttpSession session, HttpServletResponse response,
							@ModelAttribute("goalphysiqueBean") GoalphysiqueBean goalphysiqueBean,
							BindingResult result) {
		
		response.setContentType("text/html; charset=UTF-8");
		
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		
		ModelAndView mav = new ModelAndView();
		// 로그인 정보 확인
		if(memberBean == null) { 
			session.setAttribute("destination", "redirect:/myPhysiqueGoal.ht");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');location.href='login.mb'</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			GoalphysiqueBean goalcheck = goalphysiqueDao.getOneGoal(memberBean.getId());
			goalphysiqueBean.setId(memberBean.getId());
			
			if(goalcheck == null) {
				// insert
				goalphysiqueDao.insertGoal(goalphysiqueBean);
				System.out.println("insert");
			}else {
				//update
				goalphysiqueDao.updateGoal(goalphysiqueBean);
				System.out.println("update");
			}
		}
		
		mav.setViewName(gotoPage);
		return mav;
	}
}
