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
public class TrainerStateListController {
	private final String command = "/trainerStateList.rv";
	private final String getPage = "trainerStateList";

	@Autowired
	ReservationDao reservationDao;
	
	@Autowired
	UsageDao usageDao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction(Model model, HttpServletRequest request,HttpSession session) {
		
		LocalDate today = LocalDate.now();
        
		String tid = ((MemberBean)session.getAttribute("loginInfo")).getId();
		List<ReservationBean> aList = reservationDao.getReservationAllListByTid(tid);
		model.addAttribute("aList",aList);
		
		return getPage;
	}
}
