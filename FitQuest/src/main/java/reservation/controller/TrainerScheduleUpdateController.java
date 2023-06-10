package reservation.controller;

import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
public class TrainerScheduleUpdateController {
	private final String command = "/tScheduleUpdate.rv";
	private final String getPage = "trainerScheduleUpdate";
	private final String gotoPage = "redirect:/trainerCalendar.rv";

	@Autowired
	TscheduleDao tscheduleDao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction(HttpSession session,Model model) {
		//설정해놓은 스케줄 가져가기
		String tid = ((MemberBean)session.getAttribute("loginInfo")).getId();
		TscheduleBean tscheduleBean = tscheduleDao.findTschedule(tid);
		
		//날짜 문자열 date 타입으로 변환(기본값으로 넣기 위해)
		String[] tsdateArr = tscheduleBean.getTsdate().split(","); //2023-06-23 2023-06-24
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		List<java.sql.Date> dateList = new ArrayList<java.sql.Date>();

        try {
            for (String dateString : tsdateArr) {
                java.util.Date utilDate = dateFormat.parse(dateString);
                java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                dateList.add(sqlDate);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        //날짜는 따로 담아가기
        model.addAttribute("dateList",dateList);
		model.addAttribute("tscheduleBean",tscheduleBean);
		return getPage;
	}
	
	@RequestMapping(value=command,method = RequestMethod.POST)
	public String doAction(@Valid TscheduleBean tscheduleBean, BindingResult result,HttpServletRequest request, Model model,
			HttpSession session,@RequestParam("tsdate") List<String> tsdateList) {
		System.out.println("빈 안에 tsdate:"+tscheduleBean.getTsdate());
		for(String tsdatelist : tsdateList) {
			System.out.println("날짜 리스트로 받은거:"+tsdatelist);
		}
		
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
			System.out.println("빈에 담아놓은거"+tsdate);
			
			int cnt = tscheduleDao.updateTschedule(tscheduleBean);
			if(cnt != -1) {
				System.out.println("수정 성공");
				return gotoPage;
			}else {
				System.out.println("수정 실패");
				return getPage;
			}
			
		}
	}
}
