package physique.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class MyPhysiqueController {
	private final String command = "myPhysiqueList.ht";
	private final String getPage = "myPhysiqueList";
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView doAction(@RequestParam(value = "selectYear", required = false) String selectYear,
								@RequestParam(value = "selectMon", required = false) String selectMon) {
		
		ModelAndView mav = new ModelAndView();
		
		Calendar cal = Calendar.getInstance();
		Map<Integer, Integer> dateMap = new HashMap<Integer, Integer>();

		// 기본값 
		if(selectYear == null) {
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
			mav.addObject("selectYear", selectYear);
			mav.addObject("selectMon", selectMon);
		}
		
		mav.addObject("dateMap", dateMap);
		mav.setViewName(getPage);
		
		return mav;
	}
	
	
	// 조회 날짜선택 ajax
	@RequestMapping(value = command, method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String doAction(HttpServletResponse response,
							@RequestParam(value = "selectYear", required = false) String selectYear,
							@RequestParam(value = "selectMon", required = false) String selectMon) {
		response.setContentType("text/html; charset=UTF-8");
		Calendar cal = Calendar.getInstance();
		Map<Integer, Integer> dateMap = new HashMap<Integer, Integer>();
		
		System.out.println("post");
		
		
		if(selectMon.length() == 1) {
			selectMon = "0" + selectMon;
		}
		String strDate = selectYear + selectMon + "01";
		
		System.out.println("strDate : " + strDate);
		
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
		
		System.out.println("maxDate : " + maxDate);
		
		JSONArray jsArr = new JSONArray();
		// 일 ~ 토 : 1~ 7
		for(int i=1; i<=maxDate; i++){
			
			System.out.println("selectMon : " + selectMon);
			
			selectDate.setDate(i);
			
			JSONObject jsObject = new JSONObject();
			jsObject.put("date", selectDate.getDay());
			
			jsArr.add(i-1, jsObject); //날짜, 요일
		}
		
		System.out.println(jsArr.toString());
		
		return jsArr.toString();
	}
}
