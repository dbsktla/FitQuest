package physique.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MyPhysiqueController {
	private final String command = "myPhysiqueList.ht";
	private final String getPage = "myPhysiqueList";
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView doAction(@RequestParam(value = "selectYear", required = false) String selectYear,
								@RequestParam(value = "selectMon", required = false) String selectMon) {
		
		ModelAndView mav = new ModelAndView();
		
		Date now = new Date();
		Calendar cal = Calendar.getInstance();
		Map<Integer, Integer> dateMap = new HashMap<Integer, Integer>();

		// 기본값 
		if(selectYear == null) {
			
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
		} else { // 날짜 선택
			
		}
		
		mav.addObject("dateMap", dateMap);
		mav.setViewName(getPage);
		
		return mav;
	}
}
