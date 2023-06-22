package reservation.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import composite.model.CompositeDao;
import composite.model.ReservationDetailBean;

@Controller
public class TrainerCalendarDetailController {
	private final String command = "/trainerCalendarDetail.rv";
	private final String getPage = "trainerCalendarDetail";

	@Autowired
	CompositeDao compositeDao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction(Model model,
			@RequestParam("tid") String tid,
			@RequestParam("date") String date,
			@RequestParam("time") String time,
			@RequestParam("people") int people
			) {
		 
		List<ReservationDetailBean> rList = compositeDao.getReservationDetail(tid,date,time,people);
		
		for (ReservationDetailBean rb : rList) {
		    // 전화번호 변환
		    String phone = rb.getMphone();
		    String mphone = phone.substring(0, 3) + "-" + phone.substring(3, 7) + "-" + phone.substring(7);

		    // 생년월일 변환
		    String birth = rb.getBirth();
		    String birthday = birth.substring(0, 10);
		    System.out.println("디테링 테으스:"+rb.getName());
		    System.out.println("디테링 테으스:"+rb.getEmail());
		    System.out.println("디테링 테으스:"+rb.getRtime());
		    System.out.println("디테링 테으스:"+rb.getRdate());
		    System.out.println("디테링 테으스:"+rb.getPeople());
		    // 수정된 값을 다시 ReservationDetailBean 객체에 저장
		    rb.setMphone(mphone);
		    rb.setBirth(birthday);

		}
		model.addAttribute("rList",rList);
		return getPage;
	}
}
