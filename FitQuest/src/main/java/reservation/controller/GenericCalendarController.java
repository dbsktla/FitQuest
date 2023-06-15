package reservation.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import composite.model.CompositeDao;
import composite.model.ReservationListActBean;
import member.model.MemberBean;
import reservation.model.CalendarBean;
import reservation.model.ReservationBean;
import reservation.model.ReservationDao;
import reservation.model.TscheduleBean;
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
	
	@Autowired
	CompositeDao compositeDao;
	
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
			
			model.addAttribute("dateList", dateList); //날짜 데이터 배열
			model.addAttribute("today_info", today_info);
			
			//예약 완료된 내역 + pt종류 가져오기 (true)
			String mid = ((MemberBean)session.getAttribute("loginInfo")).getId();
			List<ReservationListActBean> rList = compositeDao.getReservationListAct(mid);
			
			
			//년,월,일로 쪼개서 배열에 담는 과정 
			//rtime : 13:00~14:00 | rdate : 2023-06-01
			List<String> rdateList = new ArrayList<String>();
			
			for (ReservationListActBean rb : rList) {
			    rdateList.add(rb.getRdate());
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
			
			//날짜 변환해서 오늘 날짜와 비교하고 넘었으면 rstate 상태 complete로 바꿔주기
			LocalDate today = LocalDate.now(); //오늘 날짜
			
			DateTimeFormatter formatter;
			for (ReservationListActBean rb : rList) {
				//2023-6-11 / 2023-11-12 이런식으로 유동적이기 때문에 때에 따라 변환
			    if (rb.getRdate().matches("\\d{4}-\\d{1,2}-\\d{1,2}")) {
			        formatter = DateTimeFormatter.ofPattern("yyyy-M-d");
			    } else {
			        formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			    }
			    LocalDate reservationDate = LocalDate.parse(rb.getRdate(), formatter);
			    
			    if (reservationDate.isBefore(today)) { //지난 날짜
			    	if(rb.getRstate().equals("true")) { //업데이트 전
			    		int cnt = reservationDao.updateStateComplete(rb.getRnum());
			    		if(cnt != -1) {
			    			System.out.println("날짜 지나서 상태 업데이트:"+reservationDate);
			    		}
			    	}
			    }
			}//for
			
			//완료 3회 이상이면 리뷰작성 가능하도록 완료된 리스트 가져오기  
			List<ReservationBean> cList = reservationDao.getReservationCList(mid);
			Map<String, Integer> trainerCountMap = new HashMap<String, Integer>();
			Map<String, String> trainerNameMap = new HashMap<String, String>();

			// 트레이너 아이디 별로 카운트를 세어서 맵에 저장
			for (ReservationBean rb : cList) {
			    String trainerId = rb.getTid();
			    trainerCountMap.put(trainerId, trainerCountMap.getOrDefault(trainerId, 0) + 1);
			    trainerNameMap.put(trainerId, rb.getTname());
			}

			// 맵을 순회하면서 3번 이상인 경우 출력
			for (Map.Entry<String, Integer> entry : trainerCountMap.entrySet()) {
			    String trainerId = entry.getKey();
			    int count = entry.getValue();
			    
			    if (count >= 3) {
			        String trainerName = trainerNameMap.get(trainerId);
			        System.out.println(trainerId + " (" + trainerName + ") : 3번 이상");
			        model.addAttribute("reviewTid",trainerId);
			        model.addAttribute("reviewTname",trainerName);
			    } else {
			        System.out.println(trainerId + " : " + count + "번");
			    }
			}
			
			//사용권 있나 확인
			String usage = usageDao.getTid(mid);
			model.addAttribute("usage",usage);
			return getPage; 
	}
}
