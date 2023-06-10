package reservation.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import reservation.model.TscheduleBean;
import reservation.model.TscheduleDao;

@Controller
public class TrainerScheduleInsertController {
	private final String command = "/tScheduleInsert.rv";
	private final String getPage = "trainerScheduleInsert";
	private final String gotoPage = "redirect:/trainerCalendar.rv";

	@Autowired
	TscheduleDao tscheduleDao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction(HttpSession session,Model model) {
		return getPage;
	}
	
	@RequestMapping(value=command,method = RequestMethod.POST)
	public String doAction(@Valid TscheduleBean tscheduleBean, BindingResult result,HttpServletRequest request, Model model,
			HttpSession session,@RequestParam("tsdate") List<String> tsdateList) {
		System.out.println("오나 확인 오류시/tsdate:"+tscheduleBean.getTsdate());
		
		if(result.hasErrors()) {
			return getPage;
		}else {
			String tid = ((MemberBean)session.getAttribute("loginInfo")).getId();
			tscheduleBean.setTid(tid);
			
			String tsdate = ""; 
			
			if(tsdateList.size() > 1) {
				for(int i=0;i<tsdateList.size();i++) {
					tsdate += tsdateList.get(i);
			        if (i < tsdateList.size() - 1) {
			            tsdate += ",";
			        }
				}
			}
			tscheduleBean.setTsdate(tsdate);
			int cnt = tscheduleDao.insertTschedule(tscheduleBean);
			
			if(cnt != -1) {
				return gotoPage;
			}else {
				return getPage;
			}
			
		}
	}
}
