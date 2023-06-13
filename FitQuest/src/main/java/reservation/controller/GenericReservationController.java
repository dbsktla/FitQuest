package reservation.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.org.eclipse.jdt.internal.compiler.AbstractAnnotationProcessorManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import reservation.model.CalendarBean;
import reservation.model.ReservationBean;
import reservation.model.ReservationDao;
import reservation.model.TscheduleBean;
import reservation.model.TscheduleDao;
import usage.model.UsageBean;
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
			HttpSession session,@RequestParam("tid") String tid,@RequestParam("tname") String tname){
		
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
		
		//사용권 개수(트레이너 몇명인지)
		String mid = ((MemberBean) session.getAttribute("loginInfo")).getId();
		List<UsageBean> tidList = usageDao.getTListByMid(mid);
		int usageCount = 0;
		for(UsageBean ub : tidList) {
			usageCount += ub.getUnum();
		}

		//사용권 남은 개수(트레이너별)
		UsageBean usageBean = usageDao.getOneUsage(mid,tid);
		int usageNum = usageBean.getUsage();
		
		model.addAttribute("tid",tid);
		model.addAttribute("tname",tname);
		model.addAttribute("usageCount",usageCount);
		model.addAttribute("usageNum",usageNum);
		System.out.println("컨트롤러 사용권 횟수:"+usageNum);	
		
		//트레이너 스케줄 가져가기
		TscheduleBean tscheduleBean = tscheduleDao.findTschedule(tid);
		if(tscheduleBean == null) {
			tscheduleBean = new TscheduleBean();
		    // 빈 객체에 필요한 값 설정
			tscheduleBean.setTid(tid);
			tscheduleBean.setTstime("");
		    tscheduleBean.setTsdate("");
		    tscheduleBean.setTsday("");
		    
		    model.addAttribute("tscheduleBean", tscheduleBean);
		    
		}else {
			//트레이너 스케줄 - 끊어주기
			String[] tsdayArr = tscheduleBean.getTsday().split(","); //월 수 금
			String[] tstimeArr = tscheduleBean.getTstime().split(","); //13:00~14:00 14:00~15:00
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
			
			//트레이너 스케줄 연/월/일
			model.addAttribute("tsyear",yearNum);
			model.addAttribute("tsmonth",monthNum);
			model.addAttribute("tsday",dayNum);
			
			//이미 예약된 날짜 가져오기
			List<ReservationBean> rList = reservationDao.getReservationTList(tid);
			
			//이미 예약된 날짜 - 끊어주기
			String[] rtimeArr = new String[rList.size()]; //크기가 rList의 크기와 같은 배열 생성
			String[] rdateArrL = new String[rList.size()];
			int rindex = 0; //인덱스 변수 초기화
			for(ReservationBean reservationBean : rList) {
			    rtimeArr[rindex] = reservationBean.getRtime(); //배열에 값 추가
			    rdateArrL[rindex] = reservationBean.getRdate(); 
			    rindex++; //인덱스 증가
			}
			
			String[] rdateArrS;
			List<String> ryearList = new ArrayList<String>();
			List<String> rmonthList = new ArrayList<String>();
			List<String> rdayList = new ArrayList<String>();
	
			for (int i = 0; i < rdateArrL.length; i++) {
				rdateArrS = rdateArrL[i].split("-"); //2023 06 23 2023 06 24
			    
				ryearList.add(rdateArrS[0]);
				rmonthList.add(rdateArrS[1]);
				rdayList.add(rdateArrS[2]);
			}
			String[] ryear = ryearList.toArray(new String[0]);
			String[] rmonth = rmonthList.toArray(new String[0]);
			String[] rday = rdayList.toArray(new String[0]);
			
			//이미 예약된 날짜 연/월/일
			model.addAttribute("ryear",ryear);
			model.addAttribute("rmonth",rmonth);
			model.addAttribute("rday",rday);
			//이미 예약된 날짜 시간
			model.addAttribute("rtimeArr",rtimeArr);
	
			model.addAttribute("tsdayArr",tsdayArr);
			model.addAttribute("tstimeArr",tstimeArr);
			model.addAttribute("tsdateArrL",tsdateArrL);
			model.addAttribute("tscheduleBean",tscheduleBean);
		}//else
		return getPage;
	}
}
