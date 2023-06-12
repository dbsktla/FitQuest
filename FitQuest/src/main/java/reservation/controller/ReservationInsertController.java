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
			@RequestParam("usageNum") int usageNum,
			HttpSession session) {
		
		//사용권 정보 가져오기
		String mid = ((MemberBean)session.getAttribute("loginInfo")).getId();
		UsageBean usageBean = usageDao.getOneUsage(mid,tid);
		int onum = usageBean.getOnum(); //주문 번호
		int unum = usageBean.getUnum(); //사용권 번호
		
		//날짜 조립
		String rdate = year + "-" + month + "-" + date;
		
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
        reservationBean.setRtime(rtime);
		int cnt = reservationDao.insertReservation(reservationBean);
		
		if(cnt != -1) {
			System.out.println("예약 성공");
			//남은 횟수 차감
			usageDao.decreaseUsage(unum);
			//남은 횟수 0일때 사용권 삭제
			UsageBean ub = usageDao.getOneUsage(mid,tid);
			int usageNumber = ub.getUsage();
			if(usageNumber <= 0) {
				//사용권 삭제
				int cnt1 = usageDao.deleteUsage(unum);
			}
		}else {
			System.out.println("예약 실패");
		}
		
		//예약한 날짜 트레이너 스케줄에서 제하기
		
		
		
		
		
		return "genericReservation?tname="+tname+"&tid="+tid;
	}
	
	
}
