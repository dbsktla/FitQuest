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

import complete.model.CompleteBean;
import complete.model.CompleteDao;
import member.model.MemberBean;
import reservation.model.CalendarBean;
import reservation.model.ReservationBean;
import reservation.model.ReservationDao;

@Controller
public class TrainerReservationController {
	private final String command = "/trainerReservation.rv";
	private final String getPage = "trainerReservation";

	@Autowired
	ReservationDao reservationDao;
	
	@Autowired
	CompleteDao completeDao;
	
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
		List<ReservationBean> rList = reservationDao.getReservationFList(tid);
		
		//예약 완료 테이블에 있는 정보 가져오기
		List<CompleteBean> cList = completeDao.getAllComplete(tid);
		
		model.addAttribute("cList", cList);
		model.addAttribute("rList", rList);
		
		return getPage;
	}
}
