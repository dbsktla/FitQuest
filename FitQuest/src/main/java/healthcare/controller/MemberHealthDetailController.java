package healthcare.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import healthcare.model.HealthCareBean;
import healthcare.model.HealthCareDao;
import member.model.MemberBean;
import net.sf.json.JSONObject;

@Controller
public class MemberHealthDetailController {

	private final String command = "memberHealthDetail.ht";
	
	@Autowired
	HealthCareDao healthCareDao; 

	@RequestMapping(value = command, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String doAction(HttpSession session, HttpServletResponse response, @RequestParam(value = "mid") String mid,
						Model model) {

		response.setContentType("text/html; charset=UTF-8");
		session.setAttribute("menubar", "memberHealthCare");
		MemberBean memberBean = (MemberBean) session.getAttribute("loginInfo");

		// 로그인 정보 확인
		if (memberBean == null) {
			session.setAttribute("destination", "redirect:/memberHealthDetail.ht");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');location.href='login.mb'</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			// mav.setViewName(gotoPage);
		} else if (!memberBean.getMtype().equals("trainer")) {
			session.setAttribute("destination", "redirect:/main.go");
			try {
				response.getWriter().print("<script>alert('비정상적인 접근입니다.');location.href='login.mb'</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			System.out.println("success mid: " + mid);
			// 해당 회원 정보 - 이름, 성별, 나이, 전화번호, 이메일주소
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("tid",memberBean.getId());
			//map.put("mid", mid);
			List<HealthCareBean> hclist = healthCareDao.getHealthCareList(map);
			
			System.out.println("hclist: " + hclist);
			
//			JSONArray jsArrAll = new JSONArray();
//			JSONArray jsArr = new JSONArray();
//			JSONObject jsObjectAll = new JSONObject();
//			
//			int i=0;
//			for(HealthCareBean hcb : hclist) {
//				JSONObject jsObject = new JSONObject();
//				jsObject.put("mid", hcb.getMid());
//				jsObject.put("name", hcb.getName());
//				jsObject.put("birth", hcb.getBirth());
//				jsObject.put("age", hcb.getAge());
//				jsObject.put("mphone", hcb.getMphone());
//				jsObject.put("email", hcb.getEmail());
//				jsObject.put("gender", hcb.getGender());
//				jsObject.put("odate", hcb.getOdate());
//				jsObject.put("usage", hcb.getUsage());
//				jsObject.put("ustate", hcb.getUstate());
//				
//				jsArr.add(i, jsObject);
//				i++;
//			}
//			jsObjectAll.put("hclist", jsArr);
//			System.out.println("js : " + jsObjectAll.toString());
			
			
			// 운동 정보 -
			// 식단 정보 -
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String strnow = sdf.format(now);

			model.addAttribute("selectYear", strnow.substring(0, 4));
			model.addAttribute("selectMon", strnow.substring(4, 6));
			// 신체 정보 -

		}
		
		return "";
	}
}