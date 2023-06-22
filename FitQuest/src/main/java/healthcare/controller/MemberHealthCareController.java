package healthcare.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import healthcare.model.HealthCareBean;
import healthcare.model.HealthCareDao;
import member.model.MemberBean;
import utility.NullUtil;

@Controller
public class MemberHealthCareController {
	private final String commnad = "memberHealthCare.ht";
	private final String getPage = "memberHealthCareMain";
	
	@Autowired
	HealthCareDao healthCareDao;
	
	// 검색, 필터 : 사용자 이름, 성별, 나이-만(연령대), 회원상태
	@RequestMapping(value = commnad)
	public ModelAndView doAction(HttpSession session, HttpServletResponse response, Model model,
							@RequestParam(value = "whatName", required = false) String whatName,
							@RequestParam(value = "whatGender", required = false) String whatGender,
							@RequestParam(value = "whatStatus", required = false) String whatStatus,
							@RequestParam(value = "whatAge", required = false) String whatAge
							) {
		
		response.setContentType("text/html; charset=UTF-8");
		session.setAttribute("menubar", "memberHealthCare");
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		ModelAndView mav = new ModelAndView();
		
		// 로그인 정보 확인
		if(memberBean == null) { 
			session.setAttribute("destination", "redirect:/memberHealthCare.ht");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');location.href='login.mb'</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			//mav.setViewName(gotoPage);
		}else if(!memberBean.getMtype().equals("trainer")){
			session.setAttribute("destination", "redirect:/main.go");
			try {
				response.getWriter().print("<script>alert('비정상적인 접근입니다.');location.href='login.mb'</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("tid",memberBean.getId());
			map.put("whatGender",whatGender);
			map.put("whatStatus",whatStatus);
			if(NullUtil.notNone(whatName)) {
				map.put("whatName", "%" + whatName + "%");
			}
			if(NullUtil.notNone(whatAge)) {
				int age = Integer.parseInt(whatAge);
				
				map.put("startAge",age);
				map.put("endAge",age+9);
			}else {
				//map.put("startAge",0);
			}
			List<HealthCareBean> hclist = healthCareDao.getHealthCareList(map);
			mav.addObject("hclist", hclist);

		}
		
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String strnow = sdf.format(now);

		model.addAttribute("selectYear", strnow.substring(0, 4));
		model.addAttribute("selectMon", strnow.substring(4, 6));
		
		mav.setViewName(getPage);
		return mav;
	}
}