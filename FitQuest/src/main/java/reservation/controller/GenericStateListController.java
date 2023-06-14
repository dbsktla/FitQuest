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
        System.out.println("오늘의 날짜: " + today);
        
        //예약 완료된 내역 가져오기 (true)
		String mid = ((MemberBean)session.getAttribute("loginInfo")).getId();
		List<ReservationBean> tList = reservationDao.getReservationTListByMid(mid);
		
		//예약 승인전 내역 가져오기 (false)
		List<ReservationBean> fList = reservationDao.getReservationFListByMid(mid);
		
		//예약 거절된 내역 가져오기 (reject)
		List<ReservationBean> jList = reservationDao.getReservationJListByMid(mid);
		
		for(ReservationBean rb : tList) {
			System.out.println("날짜:"+rb.getRdate());
			System.out.println("시간:"+rb.getRtime());
		}
		for (ReservationBean rb : tList) {
		    LocalDate reservationDate = LocalDate.parse(rb.getRdate());
		    
		    if (reservationDate.isAfter(today)) {
		        System.out.println("예약 날짜가 오늘을 넘었습니다.");
		    } else if (reservationDate.isEqual(today)) {
		        System.out.println("예약 날짜가 오늘과 동일합니다.");
		    } else {
		        System.out.println("예약 날짜가 아직 오지 않았습니다.");
		    }
		}
		
		model.addAttribute("today",today);
		model.addAttribute("tList",tList);
		model.addAttribute("fList",fList);
		model.addAttribute("jList",jList);
		return getPage;
	}
}
