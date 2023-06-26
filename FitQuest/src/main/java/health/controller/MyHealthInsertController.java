package health.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import health.model.HealthBean;
import health.model.HealthDao;
import health.model.HealthDateBean;
import health.model.HealthDateDao;
import member.model.MemberBean;
import oracle.net.aso.h;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;
import usage.model.UsageBean;
import usage.model.UsageDao;
import utility.NullUtil;

@Controller
public class MyHealthInsertController {
	private final String command = "myHealthInsert.ht";
	private final String getPage = "myHealthInsertForm";
	private final String gotoPage = "redirect:/myHealthList.ht";
	
	@Autowired
	HealthDateDao healthDateDao;
	
	@Autowired
	HealthDao healthDao;
	
	@Autowired
	TrainerDao trainerDao;
	
	@Autowired
	UsageDao usageDao;
	
	
	/* form으로 이동 */
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView doAction(HttpSession session, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		
		if(memberBean == null) { // 로그인 정보 없을 때
			session.setAttribute("destination", "redirect:/myHealthInsert.ht");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			mav.setViewName("redirect:/loginForm.mb");
		} else { // 로그인 정보 존재할때
			
			List<HealthDateBean> tlist = healthDateDao.getTrainerList(memberBean.getId());
			
			mav.addObject("tlist", tlist);
			mav.setViewName(getPage);
		}
		return mav;
	}
	
	/* 추가하기 */
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView doAction(HttpSession session, HttpServletRequest request,
								HealthDateBean hdb) {
		ModelAndView mav = new ModelAndView();
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("hdate", hdb.getHdate());
		map.put("id", memberBean.getId());
		List<HealthDateBean> oldlist = healthDateDao.getHealthByHdate(map);
		
		boolean flag = false;
		HealthDateBean oldhdbean = new HealthDateBean();
		for(HealthDateBean oldhb : oldlist) {
			if(oldhb.getTid().equals(hdb.getTid())) { // 있으면 true
				flag = true;
				oldhdbean = oldhb;
			}
		}
		
		if(NullUtil.isNull(oldlist) || !flag) { // 날짜가 없거나 해당날짜에 트레이너정보가 없을때. insert
			hdb.setId(memberBean.getId());
			int cnt = healthDateDao.insertHealthDate(hdb);
			
			if(cnt == -1) {
				System.out.println("hdate 삽입 실패");
				mav.setViewName(getPage);
			} else {
				// 삽입 성공하면 해당 날짜 번호 시퀀스를 얻기 위해서 날짜를 다시 가져온다.
				map.put("hdate", hdb.getHdate());
				map.put("tid", hdb.getTid());
				
				HealthDateBean healthDateBean = healthDateDao.getHealthByHdateTid(map);
				
				insertHealthRequest(request, healthDateBean, hdb.getHdate());
				mav.setViewName(gotoPage); // 리스트
			}
		} else {
			insertHealthRequest(request, oldhdbean, hdb.getHdate());
			mav.setViewName(gotoPage); // 리스트
		}
		
		return mav;
	}// 추가

	
	// 여러개 운동 삽입 처리
	private void insertHealthRequest(HttpServletRequest request, HealthDateBean healthDateBean, String hdate) {
		
		String[] hname = request.getParameterValues("hname");
		String[] starthour = request.getParameterValues("starthour");
		String[] startminute = request.getParameterValues("startminute");
		String[] endhour = request.getParameterValues("endhour");
		String[] endminute = request.getParameterValues("endminute");
		String[] hcount = request.getParameterValues("hcount");
		String[] hset = request.getParameterValues("hset");
		
		for(int i = 0; i < hname.length; i++) {
			HealthBean healthBean = new HealthBean();
			
			healthBean.setHnum(healthDateBean.getHnum());
			healthBean.setHname(hname[i]);
			healthBean.setStarttime(hdate + " " + starthour[i] + ":" + startminute[i]);
			healthBean.setEndtime(hdate + " " + endhour[i] + ":" + endminute[i]);
			healthBean.setHcount(Integer.parseInt(hcount[i]));
			healthBean.setHset(Integer.parseInt(hset[i]));
			
			int cnt2 = healthDao.insertHealth(healthBean);
			System.out.println("cnt2 : " + cnt2);
		}
		
	}
	
}
