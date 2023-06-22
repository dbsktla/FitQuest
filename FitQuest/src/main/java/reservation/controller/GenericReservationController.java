package reservation.controller;

import java.time.LocalDate;
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
import org.springframework.web.bind.annotation.RequestParam;

import complete.model.CompleteBean;
import complete.model.CompleteDao;
import composite.model.CompositeDao;
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
	
	@Autowired
	CompositeDao compositeDao;
	
	@Autowired
	CompleteDao completeDao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction(Model model, HttpServletRequest request, CalendarBean dateData,
			HttpSession session,@RequestParam("tid") String tid,@RequestParam("tname") String tname
			,@RequestParam("people") int people
			){
		
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
		
		//사용권 개수(트레이너 몇명인지. 트레이너 선택란으로 돌아가는 버튼용)
		String mid = ((MemberBean) session.getAttribute("loginInfo")).getId();
		List<UsageBean> tidList = usageDao.getTListByMid(mid);
		int usageCount = 0;
		for(UsageBean ub : tidList) {
			usageCount += ub.getUnum();
		}
		
		//사용권 남은 개수
		UsageBean usageBean = usageDao.getUsageByPeople(mid,tid,people);
		int usageNum = 0; 
		if (usageBean != null) {
		    usageNum = usageBean.getUsage();
		    // 사용권 모두 소진 시 상태 unavailable로 바꾸기
		    if (usageNum <= 0) {
		        int cnt = usageDao.updateUstateA(usageBean.getUnum()); 
		        if (cnt != -1) {
		            System.out.println("사용권 모두 소진 후 상태 바꿈");
		        } else {
		            System.out.println("사용권 모두 소진 후 상태 바꿈 실패");
		        }
		    }
		}
		model.addAttribute("tid",tid);
		model.addAttribute("tname",tname);
		model.addAttribute("people",people);
		model.addAttribute("usageCount",usageCount);
		model.addAttribute("usageNum",usageNum);
		
		
		
		
		//사용권에 등록된 정보를 바탕으로 트레이너 스케줄 가져오기(4인권,1인권 등)
		System.out.println("mid: "+mid);
		System.out.println("tid: "+tid);
		System.out.println("people: "+people);
		
		List<TscheduleBean> tsList = compositeDao.getTscheduleByUsage(mid,tid,people);
		for(TscheduleBean tb: tsList) {
			System.out.println("스케줄 테스트: "+tb.getTsday());
			System.out.println("스케줄 테스트 인원: "+tb.getTspeople());
		}
		model.addAttribute("tsList",tsList);
		
		//인원수에 따라 예약 마감된 값 가져오기
		List<CompleteBean> cList = completeDao.getCompleteByPeople(tid,people);
		model.addAttribute("cList",cList);
		
		//오늘 날짜 가져오기(이전 날짜는 예약 막기 위함)
		LocalDate today = LocalDate.now(); //오늘 날짜
		int tyear = today.getYear();
		int tmonth = today.getMonthValue();
		int tday = today.getDayOfMonth();
		
		model.addAttribute("tyear",tyear); 
		model.addAttribute("tmonth",tmonth); 
		model.addAttribute("tday",tday); 
			
		//내가 예약 신청한 목록 가져오기(false)
		List<ReservationBean> rfList = reservationDao.getReservationFListByPeople(mid,tid,people);
		model.addAttribute("rfList",rfList); 
		for(ReservationBean rb : rfList) {
			System.out.println("예약 신청한 날짜:"+rb.getRdate());
			System.out.println("예약 신청한 시간:"+rb.getRtime());
		}
		
		//예약 완료 했지만, 정원 마감은 안된 목록 가져오기(true지만, complete 테이블엔 없는)
		List<ReservationBean> ncList = compositeDao.getReservationNotComplete(mid,tid,people);
		model.addAttribute("ncList",ncList); 
		
		
		for(ReservationBean rb : rfList) {
			System.out.println("예약 신청한 날짜c:"+rb.getRdate());
			System.out.println("예약 신청한 시간c:"+rb.getRtime());
		}
		//다른 회원권에서 예약 완료된 모든 값 가져오기(동일 시간,날짜 예약 막기 위함)
		List<ReservationBean> tList = reservationDao.getReservationTListByPeople(mid,tid,people);
		model.addAttribute("tList",tList); 
		
		/*
		for(TscheduleBean tscheduleBean : tsList) {
			//트레이너 스케줄 - 끊어주기
			//String[] tsdayArr = tscheduleBean.getTsday()
			String[] tstimeArr = tscheduleBean.getTstime().split(","); //13:00~14:00 14:00~15:00
			
			//쉬는날이 존재하는 경우
			String[] tsdateArrL;
			if(tscheduleBean.getTsdate() != null) {
				tsdateArrL = tscheduleBean.getTsdate().split(","); //2023-06-23 2023-06-24
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
				model.addAttribute("tsdateArrL",tsdateArrL);
			}//if
			
		}//for
		
		
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
		model.addAttribute("rList",rList);

		//model.addAttribute("tsdayArr",tsdayArr);
		//model.addAttribute("tstimeArr",tstimeArr);
		//model.addAttribute("tscheduleBean",tscheduleBean);
		
		
		//오늘 날짜 이전은 예약 막기 위함
		LocalDate today = LocalDate.now(); //오늘 날짜
		int tyear = today.getYear();
		int tmonth = today.getMonthValue();
		int tday = today.getDayOfMonth();
		
		model.addAttribute("tyear",tyear); 
		model.addAttribute("tmonth",tmonth); 
		model.addAttribute("tday",tday); 
		*/
		return getPage;
	}
}
