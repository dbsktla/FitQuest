package reservation.controller;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;
import reservation.model.ReservationBean;
import reservation.model.ReservationDao;
import reservation.model.TscheduleDao;
import usage.model.UsageBean;
import usage.model.UsageDao;

@Controller
public class ReservationInsertController {
	private final String command = "/reservationInsert.rv";
	private final String getPage = "genericReservation";
	private final String gotoPage = "redirect:/genericCalendar.rv";

	@Autowired
	ReservationDao reservationDao;
	
	@Autowired
	TscheduleDao tscheduleDao;
	
	@Autowired
	UsageDao usageDao;
	
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction(
			@RequestParam("year") String year,
			@RequestParam("month") String month,
			@RequestParam("date") String date,
			@RequestParam("time") String rtime,
			@RequestParam("tid") String tid,
			@RequestParam("tname") String tname,
			HttpSession session) {
		System.out.println("인서트로 오나 체크");
		//사용권 정보 가져오기 트레이너 누군지 해야함...
		String mid = ((MemberBean)session.getAttribute("loginInfo")).getId();
		UsageBean usageBean = usageDao.getOneUsage(mid,tid);
		int onum = usageBean.getOnum(); //주문 번호
		int unum = usageBean.getUnum(); //사용권 번호
		System.out.println("사용권 정보 테스트:"+onum);
		System.out.println("사용권 정보 테스트:"+unum);
		System.out.println("사용권 정보 테스트:"+tid);
		
		//날짜 조립
		String rdate = year + "-" + month + "-" + date;
		System.out.println("rdateTest:"+rdate);
		/*
		 * Date rdate = null; SimpleDateFormat format = new
		 * SimpleDateFormat("yyyy-MM-dd"); try { java.util.Date utilDate =
		 * format.parse(dateString); rdate = new java.sql.Date(utilDate.getTime()); }
		 * catch (ParseException e) { e.printStackTrace(); }
		 */
		
		//이름 가져오기
		String mname = memberDao.getName(mid);
		
		//예약 테이블에 삽입
        ReservationBean reservationBean = new ReservationBean();
        reservationBean.setMid(mid);
        reservationBean.setMname(mname);
        reservationBean.setTid(tid);
        reservationBean.setOnum(onum);
        reservationBean.setUnum(unum);
        reservationBean.setRdate(rdate);
        System.out.println(reservationBean.getRdate());
        reservationBean.setRtime(rtime);
        System.out.println(reservationBean.getRtime());
		int cnt = reservationDao.insertReservation(reservationBean);
		
		if(cnt != -1) {
			System.out.println("예약 성공");
			//사용권 차감
			//int cnt = usageDao.decreaseUsage();
			
		}else {
			System.out.println("예약 실패");
		}
		
		//예약한 날짜 트레이너 스케줄에서 제하기
		
		
		
		
		
		return "genericReservation?tname="+tname+"&tid="+tid;
	}
	
	
}
