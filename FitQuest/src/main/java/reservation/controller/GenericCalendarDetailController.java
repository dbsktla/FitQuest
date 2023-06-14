package reservation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import composite.model.CompositeDao;
import composite.model.ReservationDetailBean;
import composite.model.ReservationDetailGBean;
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
		
		ReservationDetailGBean reservationDetailGBean= compositeDao.getReservationDetailG(rnum);
		
		// 전화번호 변환
		String mphoneNum = reservationDetailGBean.getMphone();
		String gphoneNum = reservationDetailGBean.getGphone();
		String mphone = mphoneNum.substring(0, 3) + "-" + mphoneNum.substring(3, 7) + "-" + mphoneNum.substring(7);
		String gphone = gphoneNum.substring(0, 3) + "-" + gphoneNum.substring(3, 7) + "-" + gphoneNum.substring(7);

		// 생년월일 변환
		
		model.addAttribute("mphone",mphone);
		model.addAttribute("gphone",gphone);
		model.addAttribute("reservationDetailGBean",reservationDetailGBean);
		return getPage;
	}
}
