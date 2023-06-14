package health.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import health.model.HealthDao;
import health.model.HealthDateBean;
import health.model.HealthDateDao;
import member.model.MemberBean;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import physique.model.GoalphysiqueBean;
import physique.model.GoalphysiqueDao;
import physique.model.PhysiqueBean;
import physique.model.PhysiqueDao;
import trainer.model.TrainerDao;
import usage.model.UsageDao;

@Controller
public class HealthMainController {
	private final String command = "health.ht";
	// 일반회원
	private final String getPage = "myHealthMain";
	// 트레이너
	private final String getPageT = "trainerHealthMain";
	
	@Autowired
	HealthDateDao healthDateDao;
	
	@Autowired
	HealthDao healthDao;
	
	@Autowired
	TrainerDao trainerDao;
	
	@Autowired
	UsageDao usageDao;
	
	@Autowired
	PhysiqueDao physiqueDao;
	
	@Autowired
	GoalphysiqueDao goalphysiqueDao;
	
	// 내 운동 관리 페이지로 이동
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView doAction(HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html; charset=UTF-8");
		ModelAndView mav = new ModelAndView();
		
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		
		Date nowDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		if(memberBean == null) {
			session.setAttribute("destination", "redirect:/health.ht");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');location.href='login.mb'</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			String mid = memberBean.getId();
			
			// 오늘 운동정보 - 오늘 운동일자 데이터 조회, 없으면 운동작성하러가기 버튼 필요, 있으면 운동내역 가져올것
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", mid);
			map.put("nowDate", sdf.format(nowDate));
			
			// 오늘 운동 목록
			List<HealthDateBean> hblist = healthDateDao.getMyHealthDateList(map);
			mav.addObject("hblist", hblist);
			
			// 오늘 식단정보 - 오늘 식단일자 데이터 조회, 없으면 식단 작성하러기가 , 있으면 식단내역 가져올것
			
			
			// 함께하는 트레이너 정보 - 트레이너 이름, 구매일자, 어떤 운동인지
			List<HealthDateBean> mainHealthList = healthDateDao.getMainHealthList(mid);
			mav.addObject("mainHealthList", mainHealthList);
			
			// 가장 최근에 작성한 신체정보 - 작성된 신체정보 중 가장 최근 일자와 신체 데이터 가져오기
			PhysiqueBean phsiqueBean = physiqueDao.getOnePhysiqueByMaxdate(mid);
			mav.addObject("phsiqueBean", phsiqueBean);
			
			// 목표 체중정보 - 신체정보에서 설정
			GoalphysiqueBean goalBean = goalphysiqueDao.getOneGoal(mid);
			mav.addObject("goalBean", goalBean);
			
			// 이달의 변화 - 신체정보 불러오기
			List<PhysiqueBean> phlist = physiqueDao.getPhysiqueList(memberBean.getId());
			mav.addObject("phlist", phlist);
			
			
			// 주별 운동 시간 데이터 합산
			Calendar scal = Calendar.getInstance();
			Calendar ecal = Calendar.getInstance();
			scal.setTime(nowDate);
			scal.add(Calendar.DATE, 2 - scal.get(Calendar.DAY_OF_WEEK));
			ecal.setTime(nowDate);
			ecal.add(Calendar.DATE, 8 - ecal.get(Calendar.DAY_OF_WEEK));
			
			Map<String, Object> datemap = new HashMap<String, Object>();
			datemap.put("id", mid);
			datemap.put("sdate", sdf.format(scal.getTime()));
			datemap.put("edate", sdf.format(ecal.getTime()));
			
			System.out.println("sdate : " + datemap.get("sdate"));
			System.out.println("edate : " + datemap.get("edate"));
			
			String weekPlaytime = healthDateDao.allWeekPlaytime(datemap);
			System.out.println("weekPlaytime : " + weekPlaytime);
			if(weekPlaytime == null) {
				weekPlaytime = "0";
			}
			mav.addObject("weekPlaytime", weekPlaytime);
		}
		mav.setViewName(getPage);
		return mav;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String doActionJS(HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html; charset=UTF-8");
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		
		Date nowDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		JSONArray jsArr = new JSONArray();
		
		if(memberBean == null) {
			session.setAttribute("destination", "redirect:/health.ht");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');location.href='login.mb'</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			String id = memberBean.getId();
			// 주 운동시간
			// 오늘 날짜 기준으로 월화수목금토일 가져오기
			Calendar scal = Calendar.getInstance();
			scal.setTime(nowDate);
			scal.add(Calendar.DATE, 2 - scal.get(Calendar.DAY_OF_WEEK));
			
			// 오늘 날짜 기준 이번 주 데이터 가져오기
			// 운동 시간이 없는 날짜는 0 삽입하기
			for(int i=0; i<7; i++) {
				JSONObject jsObject = new JSONObject();
				
				String dat = sdf.format(scal.getTime());
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", id);
				map.put("date", dat);
				
				HealthDateBean hdb = healthDateDao.getWeekPlaytime(map);
				
				jsObject.put("hdate", dat);
				
				if(hdb == null) {
					jsObject.put("playtime", "0");
				}else {
					jsObject.put("playtime", hdb.getPlaytime());
				}
				scal.add(Calendar.DATE, +1);
				jsArr.add(jsObject);
			}
		}
		return jsArr.toString();
	}
}