package health.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import health.model.HealthBean;
import health.model.HealthDao;
import health.model.HealthDateBean;
import health.model.HealthDateDao;
import member.model.MemberBean;

@Controller
public class MyHealthListController {
	private final String command = "myHealthList.ht";
	private final String getPage = "myHealthList";
	private final String gotoPage = "redirect:/loginForm.mb";
	
	@Autowired
	HealthDao healthDao;
	
	@Autowired
	HealthDateDao healthDateDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView doAction(HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html; charset=UTF-8");
		ModelAndView mav = new ModelAndView();
		
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		if(memberBean == null) {
			session.setAttribute("destination", "redirect:/myHealthList.ht");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			mav.setViewName(gotoPage);
		}else {
			List<HealthDateBean> hdlist = healthDateDao.getMyHealthDateList(memberBean.getId());
			
			for(HealthDateBean hd : hdlist) {
				List<HealthBean> timelist = healthDao.getOneHealth(hd.getHnum());
				
//				SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
//				Calendar allcal1 = Calendar.getInstance();
//				Calendar allcal2 = Calendar.getInstance();
//				int i = 0;
				
				
				long alltime = 0;
				for(HealthBean time : timelist) {
//					System.out.println("hnum : " + time.getHnum());
//					System.out.println("hname : " + time.getHname());
//					System.out.println("stime : " + time.getStarttime());
//					System.out.println("etime : " + time.getEndtime());
					
					String stime = time.getStarttime();
					String etime = time.getEndtime();
					
//					Calendar cal1 = Calendar.getInstance();
//					Calendar cal2 = Calendar.getInstance();
//					
//					cal1.setTime(etime); 
//					cal2.setTime(stime);
//					System.out.println("cal1 : " + cal1.getTime());
//					System.out.println("cal2 : " + cal2.getTime());
					
//					cal1.add(Calendar.HOUR_OF_DAY, -(cal2.get(Calendar.HOUR_OF_DAY)));
//					System.out.println("cal1-cal2 = " + cal1.getTime());
//					
//					System.out.println("play time : "+sdf.format(cal1.getTime()));
//					if(i==0) {
//						allcal1.setTime(cal1.getTime());
//					}else {
//						allcal2.setTime(cal1.getTime());
//					}
//					i++;
					
					//long re = sdf 
					
					System.out.println("stime : " + stime);
					long answer = 0;
					Date format1;
					Date format2;
					try {
						format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(etime);
						format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(stime);
						
						answer = (format1.getTime() - format2.getTime())/60000;
						
					} catch (ParseException e) {
						System.out.println("날짜 변경 오류");
						e.printStackTrace();
					}
					
					alltime += answer;
				}
				
				
//				allcal1.add(Calendar.HOUR_OF_DAY, (allcal2.get(Calendar.HOUR_OF_DAY)));
//				System.out.println("allplay time : " + sdf.format(allcal1.getTime()));
				
				String playTime = String.valueOf(alltime)+"분";
				hd.setPlaytime(playTime);
			}
			mav.addObject("hdlist", hdlist);
			mav.setViewName(getPage);
		}
		return mav;
	} // doAction - list
	
}