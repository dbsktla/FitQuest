package reservation.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import complete.model.CompleteDao;
import member.model.MemberBean;
import reservation.model.ReservationBean;
import reservation.model.ReservationDao;
import usage.model.UsageDao;

@Controller
public class TrainerCancelController {
	private final String command = "/trainerCancel.rv";
	private final String gotoPage = "redirect:/trainerCalendar.rv";
	
	@Autowired
	ReservationDao reservationDao;
	
	@Autowired
	UsageDao usageDao;
	
	@Autowired
	CompleteDao completeDao;
	
	@RequestMapping(command)
	public String doAction(HttpSession session,
			@RequestParam("tid") String tid,
			@RequestParam("date") String date,
			@RequestParam("time") String time,
			@RequestParam("people") int people
			) {
		
		//조건에 일치하는 데이터 가져오기
		List<ReservationBean> rList = reservationDao.getReservationList(tid,date,time,people);
		
		//예약 상태 cancel로 변경
		int cnt = reservationDao.cancelReservationT(tid,date,time,people);
		
		int cnt1 = 0;
		int cnt2 = 0;
		
		//사용권 1개 추가후 상태 available로 바꾸기
		for(ReservationBean rb : rList) {
			ReservationBean reservationBean = reservationDao.getOneByRnum(rb.getRnum());
			cnt1 = usageDao.increaseUsage(reservationBean.getUnum());
			cnt2 = usageDao.updateUstateU(reservationBean.getUnum()); 
		}
		
		//예약 완료 테이블에서 삭제하기
		int cnt3 = completeDao.deleteComplete(tid,date,time,people);
		
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
		if(cnt3 != -1) {
			System.out.println("예약 완료 테이블 삭제 성공");
		}else {
			System.out.println("예약 완료 테이블 삭제 실패");
		}
		if(cnt != -1) {
			System.out.println("예약 취소 성공");
		}else {
			System.out.println("예약 취소 실패");
		}
		return gotoPage;
	}
}
