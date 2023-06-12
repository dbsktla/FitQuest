package health.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
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
import org.springframework.web.servlet.ModelAndView;

import health.model.HealthBean;
import health.model.HealthDao;
import health.model.HealthDateBean;
import health.model.HealthDateDao;
import member.model.MemberBean;
import physique.model.GoalphysiqueBean;
import physique.model.GoalphysiqueDao;
import physique.model.PhysiqueBean;
import physique.model.PhysiqueDao;
import trainer.model.TrainerDao;
import usage.model.UsageDao;
import utility.NullUtil;

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
		}
		mav.setViewName(getPage);
		return mav;
	}
}