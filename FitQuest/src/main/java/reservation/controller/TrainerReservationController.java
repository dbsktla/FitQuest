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
import member.model.MemberDao;
import reservation.model.CalendarBean;
import reservation.model.ReservationBean;
import reservation.model.ReservationDao;
import reservation.model.TscheduleBean;
import reservation.model.TscheduleDao;
import usage.model.UsageDao;

@Controller
public class TrainerReservationController {
	private final String command = "/trainerReservation.rv";
	private final String getPage = "trainerReservation";

	@Autowired
	ReservationDao reservationDao;
	
	@Autowired
	TscheduleDao tscheduleDao;
	
	@Autowired
	UsageDao usageDao;
	
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction(Model model, HttpServletRequest request, CalendarBean dateData,
			HttpSession session) {
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
		
		String tname = ((MemberBean)session.getAttribute("loginInfo")).getName();
		
		model.addAttribute("tname", tname);
		model.addAttribute("dateList", dateList); //날짜 데이터 배열
		model.addAttribute("today_info", today_info);
		
		//예약 내역 가져오기
		String tid = ((MemberBean)session.getAttribute("loginInfo")).getId();
		List<ReservationBean> rList = reservationDao.getReservationList(tid);
		
		for(int i=0;i<rList.size();i++) {
			System.out.println("회원 이름 테스트2:"+rList.get(i).getRtime());
		}
		
		//rtime  13:00~14:00
		//rdate   2023-06-01
		//년,월,일로 쪼개서 배열에 담는 과정 
		List<String> rdateList = new ArrayList<String>();
		
		for (ReservationBean reservationBean : rList) {
		    rdateList.add(reservationBean.getRdate());
		}

		String[] rdateArrL = rdateList.toArray(new String[0]);
		
		List<String> yearList = new ArrayList<String>();
		List<String> monthList = new ArrayList<String>();
		List<String> dayList = new ArrayList<String>();
		
		String[] rdateArrS;
		for (int i = 0; i < rdateArrL.length; i++) {
			rdateArrS = rdateArrL[i].split("-"); //2023 06 23 2023 06 24
		    
	        yearList.add(rdateArrS[0]);
	        monthList.add(rdateArrS[1]);
	        dayList.add(rdateArrS[2]);
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
		
		model.addAttribute("ryear",yearNum);
		model.addAttribute("rmonth",monthNum);
		model.addAttribute("rday",dayNum);
		model.addAttribute("rList", rList);
		
		//회원 이름 가져오기
		//model.addAttribute();
		
		return getPage;
	}
}
