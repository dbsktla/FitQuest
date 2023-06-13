package health.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
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

import health.model.HealthDao;
import health.model.HealthDateBean;
import health.model.HealthDateDao;
import member.model.MemberBean;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class MyHealthCalListController {
	private final String command = "myHealthCalList.ht";
	
	@Autowired
	HealthDateDao healthDateDao;
	@Autowired
	HealthDao healthDao;
	
	@RequestMapping(value = command, method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String doAction(HttpServletResponse response, HttpSession session,
						@RequestParam(value = "selectYear", required = false) String selectYear,
						@RequestParam(value = "selectMon", required = false) String selectMon) {
		response.setContentType("text/html; charset=UTF-8");
		
		Map<Integer, Integer> dateMap = new HashMap<Integer, Integer>();
		
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		JSONArray jsArr = new JSONArray();
		
		if(memberBean == null) {
			session.setAttribute("destination", "redirect:/myHealthList.ht");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');location.href='login.mb'</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			
			Calendar cal = Calendar.getInstance();
			
			if(selectYear == null || selectMon == null) { // 선택 년도, 월이 없을 때 
				Date now = new Date();
				
				cal.setTime(now);
				int maxDate = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
				
				// 일 ~ 토 : 1~ 7
				for(int i=1; i<=maxDate; i++){
					now.setDate(i);
					
					dateMap.put(i, now.getDay());
				}
				
				selectYear = String.valueOf(now.getYear() + 1900);
				selectMon = String.valueOf(now.getMonth() + 1);
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", memberBean.getId());
				map.put("smon", selectYear + "-" + selectMon + "-01");
				map.put("emon", selectYear + "-" + selectMon + "-" + maxDate);
				
				// 해당 월 날짜 목록
				List<HealthDateBean> datelist = healthDateDao.getMyHealthDateList(map);
				
				for(HealthDateBean hdb : datelist) {
					JSONObject jsObject = new JSONObject();
					
					jsObject.put("dateList", hdb);
					jsArr.add(jsObject);
				}
				
				JSONObject jsObject = new JSONObject();
				jsObject.put("selectYear", selectYear);
				jsObject.put("selectMon", selectMon);
				jsObject.put("dateMap", dateMap);
				
				jsArr.add(jsObject);
			}
			
		}
		System.out.println("jsArr : " + jsArr.toString());
		return jsArr.toString();
	}
}
