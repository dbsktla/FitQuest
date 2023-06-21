package reservation.controller;


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
			@RequestParam("usageNum") int usageNum,
			@RequestParam("people") int people,
			HttpSession session) {
		
		//사용권 정보 가져오기
		String mid = ((MemberBean)session.getAttribute("loginInfo")).getId();
		UsageBean usageBean = usageDao.getOneUsage(mid,tid,people);
		int onum = usageBean.getOnum(); //주문 번호
		int unum = usageBean.getUnum(); //사용권 번호
		
		//날짜 조립
		String rdate = year + "-" + month + "-" + date;
		
		//이름 가져오기
		String mname = ((MemberBean)session.getAttribute("loginInfo")).getName();
		System.out.println("인서트 이름:"+mname);
		System.out.println("인서트 날짜:"+rdate);
		System.out.println("인서트 주문번호:"+onum);
		
		//예약 테이블에 삽입
        ReservationBean reservationBean = new ReservationBean();
        reservationBean.setMid(mid);
        reservationBean.setTid(tid);
        reservationBean.setMname(mname);
        reservationBean.setTname(tname);
        reservationBean.setOnum(onum);
        reservationBean.setUnum(unum);
        reservationBean.setPeople(people);
        reservationBean.setRdate(rdate);
        reservationBean.setRtime(rtime);
		int cnt = reservationDao.insertReservation(reservationBean);
		
		if(cnt != -1) {
			System.out.println("예약 성공");
			//남은 횟수 차감
			usageDao.decreaseUsage(unum);
		}else {
			System.out.println("예약 실패");
		}
		
		return "genericReservation?tid="+tid+"&tname="+tname+"&people=" + people;
	}
	
	
}
