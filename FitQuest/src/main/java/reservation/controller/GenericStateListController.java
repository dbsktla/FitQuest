package reservation.controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import member.model.MemberBean;
import reservation.model.ReservationBean;
import reservation.model.ReservationDao;
import usage.model.UsageDao;

@Controller
public class GenericStateListController {
	private final String command = "/genericStateList.rv";
	private final String getPage = "genericStateList";

	@Autowired
	ReservationDao reservationDao;
	
	@Autowired
	UsageDao usageDao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction(Model model, HttpServletRequest request,HttpSession session) {
		
		LocalDate today = LocalDate.now();
        
		String mid = ((MemberBean)session.getAttribute("loginInfo")).getId();
		
		//예약 완료된 내역 가져오기 (true)
		List<ReservationBean> tList = reservationDao.getReservationTListByMid(mid);
		
		//예약 취소된 내역 가져오기 (cancel)
		List<ReservationBean> cList = reservationDao.getReservationCListByMid(mid);
		
		//운동 완료된 내역 가져오기 (complete)
		List<ReservationBean> mList = reservationDao.getReservationMListByMid(mid);
		
		//예약 승인전 내역 가져오기 (false)
		List<ReservationBean> fList = reservationDao.getReservationFListByMid(mid);
		
		//예약 거절된 내역 가져오기 (reject)
		List<ReservationBean> jList = reservationDao.getReservationJListByMid(mid);
		
		model.addAttribute("tList",tList);
		model.addAttribute("cList",cList);
		model.addAttribute("mList",mList);
		model.addAttribute("fList",fList);
		model.addAttribute("jList",jList);
		return getPage;
	}
}
