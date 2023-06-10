package reservation.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberDao;
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
	TscheduleDao tscheduleDao;
	
	@Autowired
	UsageDao usageDao;
	
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction(Model model, HttpServletRequest request,HttpSession session,
			@RequestParam("rnum") int rnum,
			@RequestParam("rstate") String rstate) {
		
		int cnt = reservationDao.updateState(rnum,rstate);
		if(cnt != -1) {
			System.out.println("state 업데이트 성공");
		}else {
			System.out.println("state 업데이트 실패");
		}
		return gotoPage;
	}
}
