package reservation.controller;

import java.util.ArrayList;
import java.util.Arrays;
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
import reservation.model.TscheduleBean;
import reservation.model.TscheduleDao;
import usage.model.UsageDao;

@Controller
public class GenericReservationController {
	private final String command = "/genericReservation.rv";
	private final String getPage = "genericReservation";

	@Autowired
	ReservationDao reservationDao;
	
	@Autowired
	TscheduleDao tscheduleDao;
	
	@Autowired
	UsageDao usageDao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction(Model model, HttpServletRequest request, CalendarBean dateData,
			HttpSession session){

		//달력 띄우기
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
		model.addAttribute("dateList", dateList); //날짜 데이터 배열
		model.addAttribute("today_info", today_info);
			
		//트레이너 스케줄 가져가기
		String mid = ((MemberBean)session.getAttribute("loginInfo")).getId();
		String tid = usageDao.getTid(mid);
				
		TscheduleBean tscheduleBean = tscheduleDao.findTschedule(tid);
		
		//끊어주기
		String[] tsdayArr = tscheduleBean.getTsday().split(",");
		String[] tstimeArr = tscheduleBean.getTstime().split(",");
		String[] tsdateArrL = tscheduleBean.getTsdate().split(","); //2023-06-23 2023-06-24
		
		String[] tsdateArrS;
		List<String> yearList = new ArrayList<String>();
		List<String> monthList = new ArrayList<String>();
		List<String> dayList = new ArrayList<String>();

		for (int i = 0; i < tsdateArrL.length; i++) {
		    tsdateArrS = tsdateArrL[i].split("-"); //2023 06 23 2023 06 24
		    
	        yearList.add(tsdateArrS[0]);
	        monthList.add(tsdateArrS[1]);
	        dayList.add(tsdateArrS[2]);
		}
		
		String[] year = yearList.toArray(new String[0]);
		String[] month = monthList.toArray(new String[0]);
		String[] day = dayList.toArray(new String[0]);
		
		// 숫자로 변환
		int[] yearNum = new int[year.length];
		int[] monthNum = new int[month.length];
		int[] dayNum = new int[day.length];

		for (int i = 0; i < year.length; i++) {
		    yearNum[i] = Integer.parseInt(year[i]);
		}

		for (int i = 0; i < month.length; i++) {
		    monthNum[i] = Integer.parseInt(month[i]);
		}

		for (int i = 0; i < day.length; i++) {
		    dayNum[i] = Integer.parseInt(day[i]);
		}
		
		model.addAttribute("tsyear",yearNum);
		model.addAttribute("tsmonth",monthNum);
		model.addAttribute("tsday",dayNum);
		
		model.addAttribute("tsdayArr",tsdayArr);
		model.addAttribute("tstimeArr",tstimeArr);
		model.addAttribute("tsdateArrL",tsdateArrL);
		model.addAttribute("tscheduleBean",tscheduleBean);
		
		return getPage;
	}
	
}
