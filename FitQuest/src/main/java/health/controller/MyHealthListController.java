package health.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import health.model.HealthBean;
import health.model.HealthDao;
import health.model.HealthDateBean;
import health.model.HealthDateDao;
import member.model.MemberBean;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class MyHealthListController {
	private final String command = "myHealthList.ht";
	private final String getPage = "myHealthList";
	private final String gotoPage = "redirect:/loginForm.mb";
	
	@Autowired
	HealthDao healthDao;
	
	@Autowired
	HealthDateDao healthDateDao;
	
	// 운동 목록 불러오기
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView doAction(HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html; charset=UTF-8");
		ModelAndView mav = new ModelAndView();
		
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		
		// 로그인 정보 확인
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
			// 운동 날짜 불러옴
			List<HealthDateBean> hdlist = healthDateDao.getMyHealthDateList(memberBean.getId());
			
			// 상세 운동 정보 불러와서 운동시간 합한뒤 운동 목록에 노출
			for(HealthDateBean hd : hdlist) {
				List<HealthBean> timelist = healthDao.getOneHealth(hd.getHnum());
				
				long alltime = 0; // 일자별 전체 운동시간
				for(HealthBean time : timelist) {
					
					String stime = time.getStarttime(); // 시작시간
					String etime = time.getEndtime(); // 종료시간
					
					long answer = 0; // 운동 종류별 운동 시간
					Date format1;
					Date format2;
					try {
						// 시작시간과 끝시간 data 타입으로 바꿈
						format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(etime);
						format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(stime);
						
						// 시간 계산한 결과값을 분으로 변경
						answer = (format1.getTime() - format2.getTime())/60000;
						
					} catch (ParseException e) {
						System.out.println("날짜 변경 오류");
						e.printStackTrace();
					}
					// 운동일자별(번호) 합산
					alltime += answer;
				}
				
				String playTime = String.valueOf(alltime)+"분";
				hd.setPlaytime(playTime); // 해당 결과 저장
			}
			mav.addObject("hdlist", hdlist);
			mav.setViewName(getPage);
		}
		return mav;
	} // doAction - list
	
	
	// 상세목록 ajax
	// produces = "application/text; charset=utf8" > ajax 한글처리
	@RequestMapping(value = command, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String doAction(HttpServletResponse response, @RequestParam("hnum") int hnum) {
		response.setContentType("text/html; charset=UTF-8");
		System.out.println("hnum : " + hnum);
		List<HealthBean> hlist = healthDao.getOneHealth(hnum);
		
		JSONArray jsArr = new JSONArray();
		int i =0;
		for(HealthBean hb : hlist) {
			JSONObject jsObject = new JSONObject();
			
			jsObject.put("hnum", hb.getHnum());
			jsObject.put("hname", hb.getHname());
			jsObject.put("starttime", hb.getStarttime());
			jsObject.put("endtime", hb.getEndtime());
			jsObject.put("hcount", hb.getHcount());
			jsObject.put("hset", hb.getHset());
			
			jsArr.add(i, jsObject);
			i++;
		}
		
		System.out.println(jsArr);
		
		return jsArr.toString();
	}
	
}