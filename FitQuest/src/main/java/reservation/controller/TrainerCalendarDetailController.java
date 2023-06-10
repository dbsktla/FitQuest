package reservation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import composite.model.CompositeDao;
import composite.model.ReservationDetailBean;
import reservation.model.ReservationDao;
import reservation.model.TscheduleDao;
import usage.model.UsageDao;

@Controller
public class TrainerCalendarDetailController {
	private final String command = "/trainerCalendarDetail.rv";
	private final String getPage = "trainerCalendarDetail";

	@Autowired
	ReservationDao reservationDao;
	
	@Autowired
	UsageDao usageDao;
	
	@Autowired
	CompositeDao compositeDao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction(Model model,
			@RequestParam("rnum") int rnum) {
		
		ReservationDetailBean reservationDetailBean= compositeDao.getReservationDetail(rnum);
		model.addAttribute("reservationDetailBean",reservationDetailBean);
		return getPage;
	}
}
