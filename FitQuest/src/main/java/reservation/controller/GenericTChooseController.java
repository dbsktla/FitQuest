package reservation.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import composite.model.CompositeDao;
import composite.model.TrainerListBean;
import composite.model.TrainerListSBean;
import member.model.MemberBean;
import reservation.model.ReservationDao;
import reservation.model.TscheduleDao;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;
import usage.model.UsageBean;
import usage.model.UsageDao;

@Controller
public class GenericTChooseController {
	private final String command = "/genericTChoose.rv";
	private final String getPage = "genericTChoose";

	@Autowired
	ReservationDao reservationDao;

	@Autowired
	TscheduleDao tscheduleDao;

	@Autowired
	UsageDao usageDao;

	@Autowired
	TrainerDao trainerDao;
	
	@Autowired
	CompositeDao compositeDao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(Model model, HttpSession session) {
		session.setAttribute("topmenu", "genericCalendar");
		
		// 트레이너 목록에 쓸 아이디 갖고오기(사용권이 존재하는)
		String mid = ((MemberBean) session.getAttribute("loginInfo")).getId();
		List<UsageBean> tidList = usageDao.getTListByMid(mid);

		// 트레이너 목록 가져오기
		List<TrainerListSBean> tList = new ArrayList<TrainerListSBean>();
		
		Set<String> uniqueTids = new HashSet<String>();
		for (UsageBean tidBean : tidList) {
		    uniqueTids.add(tidBean.getTid());
		}

		for (String tid : uniqueTids) {
		    List<TrainerListSBean> tempList = compositeDao.getTrainerListByTid(mid, tid);
		    for (TrainerListSBean trainer : tempList) {
		        tList.add(trainer);
		        System.out.println(trainer.getName());
		        System.out.println(trainer.getPeople());
		    }
		}
		
		model.addAttribute("tList", tList);

		return getPage;

	}
}
