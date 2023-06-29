package reservation.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import complete.model.CompleteDao;
import member.model.MemberBean;
import member.model.MemberDao;
import notification.model.NotificationBean;
import notification.model.NotificationDao;
import reservation.model.ReservationBean;
import reservation.model.ReservationDao;
import usage.model.UsageDao;

@Controller
public class GenericCancelController {
	private final String command = "/genericCancel.rv";
	private final String gotoPage = "redirect:/genericCalendar.rv";
	
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
	
	@RequestMapping(command)
	public String doAction(HttpSession session,
			@RequestParam("rnum") int rnum
			) {
		
		//예약 상태 cancel로 변경
		int cnt = reservationDao.cancelReservationM(rnum); 
		
		//사용권 1개 추가후 상태 available로 바꾸기
		ReservationBean rb = reservationDao.getOneByRnum(rnum);
		int cnt1 = usageDao.increaseUsage(rb.getUnum());
		int cnt2 = usageDao.updateUstateU(rb.getUnum()); 
		
		//예약 완료 테이블에서 삭제하기
		//개인 : 삭제
		//단체-마감 : 삭제
		//단체-마감전 : 테이블에 없음
		int cnt3 = completeDao.deleteComplete(rb.getTid(),rb.getRdate(),rb.getRtime(),rb.getPeople());
		
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
			//예약 최소 되면 트레이너에게 취소 알림 보내기.
			String recId = rb.getTid(); //수신자는 트레이너라서 트레이너 ID.
			String recName = memberDao.getName(recId); //따라서 수신자 이름
			String sendId = rb.getMid(); //보내는 회원 - 예약을 했었던 회원.
			String sendName = memberDao.getName(sendId);
			String request = "trainerStateList.rv"; //알림 클릭 하면 보내는 페이지 : 예약 내역 페이지.
			String notifContent = sendName + " 회원님이 " + recName + " 선생님의 수업 신청을 취소했습니다.";
			NotificationBean notifBean = new NotificationBean();
			notifBean.setRecId(recId);
			notifBean.setRecName(recName);
			notifBean.setSendId(sendId);
			notifBean.setSendName(sendName);
			notifBean.setRequest(request);
			notifBean.setNotifContent(notifContent);
			int notif = notificationDao.insertPurchaseNotif(notifBean);
		}else {
			System.out.println("예약 취소 실패");
		}
		return gotoPage;
	}
}
