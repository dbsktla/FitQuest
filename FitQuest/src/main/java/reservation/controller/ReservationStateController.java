package reservation.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;
import reservation.model.ReservationBean;
import reservation.model.ReservationDao;
import reservation.model.TscheduleDao;
import usage.model.UsageDao;

@Controller
public class ReservationStateController {
	private final String command = "/reservationState.rv";
	private final String gotoPage = "redirect:/trainerReservation.rv";

	@Autowired
	ReservationDao reservationDao;
	
	@Autowired
	UsageDao usageDao;
	
	@Autowired
	
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction(Model model, HttpServletRequest request,HttpSession session,
			@RequestParam("rnum") int rnum,
			@RequestParam("people") int people,
			@RequestParam("rstate") String rstate) {
		
		//true or reject로 상태 바꿔주기
		int cnt = reservationDao.updateState(rnum,rstate);
		if(cnt != -1) {
			System.out.println("state 업데이트 성공");
		}else {
			System.out.println("state 업데이트 실패");
		}
		
		//거절하면 (reject) 사용권 올려주기
		ReservationBean rb = reservationDao.getOneByRnum(rnum);
		if(rb.getRstate().equals("reject")) {
			int cnt1 = usageDao.increaseUsage(rb.getUnum());
			if(cnt1 != -1) {
				System.out.println("승인 거절로 인한 사용권 증가");
			}else {
				System.out.println("사용권 증가 실패");
			}
		}
		
		//총 인원수 비교하고 같은 날짜,시간 데이터 몇갠지 카운트
		String tid = ((MemberBean) session.getAttribute("loginInfo")).getId(); 
		int rcount = reservationDao.getTrueCount(rb.getRdate(),rb.getRtime(),tid);
		
		//총 인원수와 동일하면 예약 완료 테이블에 삽입
		if(rcount == people) {
			
		}
		
		return gotoPage;
	}
}
