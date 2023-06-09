package health.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import member.model.MemberDao;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;
import usage.model.UsageBean;
import usage.model.UsageDao;

@Controller
public class MyHealthListController {
	private final String command = "myHealthList.ht";
	private final String getPage = "myHealthList";
	
	@Autowired
	HealthDao healthDao;
	
	@Autowired
	HealthDateDao healthDateDao;
	
	@Autowired
	MemberDao memberDao;
	
	@Autowired
	TrainerDao trainerDao;
	
	@Autowired
	UsageDao usageDao;
	
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
				response.getWriter().print("<script>alert('로그인이 필요합니다.');location.href='login.mb'</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			//mav.setViewName(gotoPage);
		}else {
			String mid = memberBean.getId();
			
			// 운동 날짜 불러옴
			List<HealthDateBean> hdlist = healthDateDao.getMyHealthDateList(mid);
			
			// 사용권 존재하면 트레이너 목록 불러옴
			// 유저가 가지고 있는 사용권을 통해 트레이너 조회
			List<UsageBean> ulist = usageDao.getTListByMid(mid);
			List<TrainerBean> tlist = new ArrayList<TrainerBean>();
			
			System.out.println("ulist : " + ulist);
			if(ulist != null) { // 사용권 잇으면 데이터 넣기
				for(UsageBean ub : ulist) {
					System.out.println("ulist tid : " + ub.getTid());
					TrainerBean trainerBean = trainerDao.getTrainerMember(ub.getTid());
					
					tlist.add(trainerBean);
				}
			}
			
			mav.addObject("tlist", tlist);
			
			
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
	
	
}