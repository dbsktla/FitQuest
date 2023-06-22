package nutrition.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import nutrition.model.NutritionDao;

@Controller
public class MyNutritionController {
	private final String command = "myNutritionList.ht";
	private final String getPage = "myNutritionList";
	
	@Autowired
	NutritionDao nutritionDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(Model model, HttpServletResponse response, HttpSession session) {
		
		response.setContentType("text/html; charset=UTF-8");
		
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		session.setAttribute("menubar", "myNutrition");
		
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
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String strnow = sdf.format(now);
			
			model.addAttribute("selectYear", strnow.substring(0, 4));
			model.addAttribute("selectMon", strnow.substring(4, 6));
		}
		
		return getPage;
	}
	
	// 조회 날짜선택 ajax
	@RequestMapping(value = command, method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String doAction(HttpServletResponse response, HttpSession session,
							@RequestParam(value = "selectYear", required = false) String selectYear,
							@RequestParam(value = "selectMon", required = false) String selectMon,
							@RequestParam(value = "mid", required = false) String mid) {
		response.setContentType("text/html; charset=UTF-8");
		Calendar cal = Calendar.getInstance();
		Map<Integer, Integer> dateMap = new HashMap<Integer, Integer>();
		
		System.out.println("post");
		
		if(selectMon.length() == 1) {
			selectMon = "0" + selectMon;
		}
		String strDate = selectYear + selectMon + "01";
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date selectDate = null;
		try {
			selectDate = sdf.parse(strDate);
		} catch (ParseException e) {
			System.out.println("날짜변경오류");
			e.printStackTrace();
		}
		
		cal.setTime(selectDate);
		int maxDate = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		JSONArray jsArr = new JSONArray();
		// 일 ~ 토 : 1~ 7
		for(int i=1; i<=maxDate; i++){
			
			selectDate.setDate(i);
			
			JSONObject jsObject = new JSONObject();
			jsObject.put("date", selectDate.getDay());
			
			jsArr.add(jsObject); 
		}
		
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		Map<String, String> map = new HashMap<String, String>();
		
		if(mid != null) {
			map.put("id", mid);
		}else {
			map.put("id", memberBean.getId());
		}
		map.put("smon", selectYear + "-" + selectMon + "-01");
		map.put("emon", selectYear + "-" + selectMon + "-" + maxDate);
		
		// 해당 월 날짜 목록
		List<String> nulist = nutritionDao.getNutritionDate(map);
		
		if(nulist.size() > 0) {
			String dateList = "";
			for(String s : nulist) {
				dateList += s.substring(8, 10) + "-";
			}
			
			JSONObject jsObject = new JSONObject();
			jsObject.put("dateList", dateList);
			
			jsArr.add(jsObject);
		} else {
			JSONObject jsObject = new JSONObject();
			jsObject.put("dateList", "noData");
			
			jsArr.add(jsObject);
		}
		
		System.out.println("nu js : " + jsArr.toString());
		return jsArr.toString();
	}
}
