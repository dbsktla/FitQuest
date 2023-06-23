package reservation.controller;


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
import member.model.MemberDao;
import notification.model.NotificationBean;
import notification.model.NotificationDao;
import reservation.model.ReservationBean;
import reservation.model.ReservationDao;
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
	CompleteDao completeDao;
	
	@Autowired
	MemberDao memberDao;
	
	@Autowired
	NotificationDao notificationDao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction(Model model, HttpServletRequest request,HttpSession session,
			@RequestParam("rnum") int rnum,
			@RequestParam("people") int people,
			@RequestParam("full") String full,
			@RequestParam("rstate") String rstate) {
		
		//true or reject로 상태 바꿔주기
		int cnt = reservationDao.updateState(rnum,rstate);
		
		ReservationBean rb = reservationDao.getOneByRnum(rnum);
		if(cnt != -1) {
			System.out.println("state 업데이트 성공");
			// 수락-거절 상태로 바뀐 후 신청을 한 회원에게 알림을 보내기.
			String recId = rb.getMid(); //수신자는 일반회원 이라서 일반ID.
			String recName = memberDao.getName(recId); //따라서 수신자 이름
			String sendId = rb.getTid(); //보내는 회원 - 트레이너
			String sendName = memberDao.getName(sendId);
			String request2 = "genericStateList.rv"; //알림 클릭 하면 보내는 페이지 : 예약 내역 페이지.
			String notifContent = "";
			if(rstate.equals("true")) { //수락 알림 메시지
				notifContent = sendName + " 선생님이 " + recName + " 회원님의 수업 신청을 수락했습니다.";
			} else if (rstate.equals("reject")) { //거절 알림 메시지
				notifContent = sendName + " 선생님이 " + recName + " 회원님의 수업 신청을 거절했습니다.";
			}
			NotificationBean notifBean = new NotificationBean();
			notifBean.setRecId(recId);
			notifBean.setRecName(recName);
			notifBean.setSendId(sendId);
			notifBean.setSendName(sendName);
			notifBean.setRequest(request2);
			notifBean.setNotifContent(notifContent);
			int notif = notificationDao.insertPurchaseNotif(notifBean);
		}else {
			System.out.println("state 업데이트 실패");
		}
		
		//거절하면 (reject) 사용권 올려주기
		if(rb.getRstate().equals("reject")) {
			int cnt1 = usageDao.increaseUsage(rb.getUnum());
			if(cnt1 != -1) {
				System.out.println("승인 거절로 인한 사용권 증가");
			}else {
				System.out.println("사용권 증가 실패");
			}
		}
		
		//총 인원수 비교하고 같은 트레이너의 날짜,시간 데이터 몇갠지 카운트
		int rcount = reservationDao.getTrueCount(rb.getRdate(),rb.getRtime(),rb.getTid(),rb.getPeople()); 
		System.out.println("카운트: "+rcount);
		
		//총 인원수와 동일하면 예약 완료 테이블에 삽입
		if(rcount == people) {
			if(full.equals("false")) { //full로 왔을땐 삽입x
				CompleteBean cb = new CompleteBean();
				cb.setTid(rb.getTid());
				cb.setCpdate(rb.getRdate());
				cb.setCptime(rb.getRtime());
				cb.setCpeople(rb.getPeople());
				int cnt2 = completeDao.insertComplete(cb);
				if(cnt2 != -1) {
					System.out.println("예약 완료 테이블 삽입");
				}else {
					System.out.println("예약 완료 테이블 삽입 실패");
				}
			}
		}
		
		return gotoPage;
	}
}
