package reservation.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import reservation.model.ReservationBean;
import reservation.model.ReservationDao;
import usage.model.UsageDao;

@Controller
public class ReservationCancelController {
	private final String command = "/reservationCancel.rv";
	
	@Autowired
	ReservationDao reservationDao;
	
	@Autowired
	UsageDao usageDao;
	
	@RequestMapping(command)
	public String doAction(@RequestParam("rnum") int rnum,HttpSession session) {
		//예약 상태 cancel로 변경
		int cnt = reservationDao.cancelReservation(rnum);
		
		//사용권 1개 추가후 상태 available로 바꾸기
		ReservationBean reservationBean = reservationDao.getOneByRnum(rnum);
		int cnt1 = usageDao.increaseUsage(reservationBean.getUnum());
		int cnt2 = usageDao.updateUstateU(reservationBean.getUnum()); 
		
		
		String mtype = ((MemberBean)session.getAttribute("loginInfo")).getMtype();
		
		if(cnt1 != -1) {
			System.out.println("사용권 추가 성공");
		}else {
			System.out.println("사용권 추가 실패");
		}
		if(cnt2 != -1) {
			System.out.println("사용권 상태 변경 성공");
		}else {
			System.out.println("사용권 상태 변경 실패");
		}
		if(cnt != -1) {
			System.out.println("예약 취소 성공");
		}else {
			System.out.println("예약 취소 실패");
		}
		
		String gotoPage = null;
		
		if(mtype.equals("trainer")) {
			gotoPage = "redirect:/trainerCalendar.rv";
		}else if(mtype.equals("generic")){
			gotoPage = "redirect:/genericCalendar.rv";
		}
		
		return gotoPage;
		
		
	}
}
