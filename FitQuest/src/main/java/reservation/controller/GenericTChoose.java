package reservation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import reservation.model.ReservationDao;
import reservation.model.TscheduleDao;
import usage.model.UsageDao;

@Controller
public class GenericTChoose {
	private final String command = "/genericTChoose.rv";
	private final String getPage = "genericTChoose";
	private final String gotoPage = "redirect:/genericCalendar.rv";

	@Autowired
	ReservationDao reservationDao;
	
	@Autowired
	TscheduleDao tscheduleDao;
	
	@Autowired
	UsageDao usageDao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction() {
		
		return getPage;
	}
}
