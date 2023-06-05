package reservation.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import reservation.model.ReservationDao;
import reservation.model.TscheduleBean;
import trainer.model.TrainerBean;

@Controller
public class TscheduleController {
	private final String command = "/tschedule.rv";
	private final String getPage = "tschedule";
	private final String gotoPage = "redirect:/trainerCalendar.rv";

	@Autowired
	ReservationDao reservationDao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction() {
		return getPage;
	}
	
	@RequestMapping(value=command,method = RequestMethod.POST)
	public String doAction(@Valid TscheduleBean tscheduleBean, BindingResult result,HttpServletRequest request, Model model) {
		if(result.hasErrors()) {
			return getPage;
		}else {
			
			return gotoPage;
		}
	}
}
