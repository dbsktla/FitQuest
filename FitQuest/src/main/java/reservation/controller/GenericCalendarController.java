package reservation.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import member.model.MemberBean;
import reservation.model.CalendarBean;
import reservation.model.ReservationDao;
import usage.model.UsageBean;
import usage.model.UsageDao;

@Controller
public class GenericCalendarController {
	private final String command = "/genericCalendar.rv";
	private final String getPage = "genericCalendar";

	@Autowired
	ReservationDao reservationDao;
	
	@Autowired
	UsageDao usageDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String calendar(Model model, HttpServletRequest request, CalendarBean dateData,
			HttpSession session){

		Calendar cal = Calendar.getInstance();
		CalendarBean calendarData;

		if(dateData.getDate().equals("")&&dateData.getMonth().equals("")){
			dateData = new CalendarBean(String.valueOf(cal.get(Calendar.YEAR)),String.valueOf(cal.get(Calendar.MONTH)),String.valueOf(cal.get(Calendar.DATE)),null);
			}

			Map<String, Integer> today_info =  dateData.today_info(dateData);
			List<CalendarBean> dateList = new ArrayList<CalendarBean>();

			for(int i=1; i<today_info.get("start"); i++){
			calendarData= new CalendarBean(null, null, null, null);
			dateList.add(calendarData);
			}
			for (int i = today_info.get("startDay"); i <= today_info.get("endDay"); i++) {
			if(i==today_info.get("today")){
			calendarData= new CalendarBean(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "today");
			}else{
			calendarData= new CalendarBean(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "normal_date");
			}
			dateList.add(calendarData);
			}

			int index = 7-dateList.size()%7;

			if(dateList.size()%7!=0){

			for (int i = 0; i < index; i++) {
			calendarData= new CalendarBean(null, null, null, null);
			dateList.add(calendarData);
			}
			}
			System.out.println(dateList);

			//사용권 남았는지 유효성 확인용
			String mid = ((MemberBean)session.getAttribute("loginInfo")).getId();
			System.out.println("아이디:"+mid);
			UsageBean usageBean = usageDao.getOneUsage(mid);
			
			System.out.println("usage:"+usageBean.getTid());
			System.out.println("usage:"+usageBean.getUsage());
			//int usage = usageBean.getUsage();
			
			//배열에 담음
			//model.addAttribute("usage", usage); //사용권 횟수
			model.addAttribute("dateList", dateList); //날짜 데이터 배열
			model.addAttribute("today_info", today_info);
			return getPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String doAction() {

		return "";
	}
}
