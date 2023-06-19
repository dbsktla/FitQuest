package reservation.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import member.model.MemberBean;
import product.model.ProductBean;
import reservation.model.TscheduleBean;
import reservation.model.TscheduleDao;

@Controller
public class TrainerScheChooseController {
	private final String command = "/trainerScheChoose.rv";
	private final String getPage = "trainerScheChoose";
	private final String gotoPage = "redirect:/genericCalendar.rv";

	@Autowired
	TscheduleDao tscheduleDao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(Model model, HttpSession session) {

		//등록된 스케줄 목록 가져오기
		String tid = ((MemberBean) session.getAttribute("loginInfo")).getId();
		List<TscheduleBean> tsList = tscheduleDao.findTschedule(tid);
		
		//중복된 값들 하나로 합치기
		Set<Integer> uniqueNumbers = new HashSet<Integer>();
        for (TscheduleBean tsb : tsList) {
            uniqueNumbers.add(tsb.getTspeople());
        }
        Integer[] peopleArr = uniqueNumbers.toArray(new Integer[0]);
        
    	
        model.addAttribute("peopleArr",peopleArr);
        model.addAttribute("tsList",tsList);
		return getPage;

	}
}
