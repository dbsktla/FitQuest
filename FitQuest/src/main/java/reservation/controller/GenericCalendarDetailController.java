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
public class GenericCalendarDetailController {
	private final String command = "/genericCalendarDetail.rv";
	private final String getPage = "genericCalendarDetail";

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
		
		// 전화번호 변환
		String phone = reservationDetailBean.getMphone();
		String mphone = phone.substring(0, 3) + "-" + phone.substring(3, 7) + "-" + phone.substring(7);

		// 생년월일 변환
		String birth = reservationDetailBean.getBirth();
		String birthday = birth.substring(0, 10);
		
		model.addAttribute("mphone",mphone);
		model.addAttribute("birthday",birthday);
		model.addAttribute("reservationDetailBean",reservationDetailBean);
		return getPage;
	}
}
