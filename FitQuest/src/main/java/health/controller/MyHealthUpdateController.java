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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import health.model.HealthBean;
import health.model.HealthDao;
import health.model.HealthDateBean;
import health.model.HealthDateDao;
import member.model.MemberBean;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;
import usage.model.UsageBean;
import usage.model.UsageDao;

@Controller
public class MyHealthUpdateController {
	private final String command = "myHealthUpdate.ht";
	private final String getPage = "myHealthUpdateForm";
	private final String gotoPage = "redirect:/myHealthList.ht";

	@Autowired
	HealthDateDao healthDateDao;
	@Autowired
	HealthDao healthDao;
	@Autowired
	TrainerDao trainerDao;
	@Autowired
	UsageDao usageDao;

	// updateForm 으로 이동
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView doAction(@RequestParam("hnum") int hnum, Model model, 
								HttpSession session, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		
		if(memberBean == null) { // 로그인 정보 없을 때
			session.setAttribute("destination", "redirect:/myHealthList.ht");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			mav.setViewName("redirect:/loginForm.mb");
		} else {
			// 유저가 가지고 있는 사용권을 통해 트레이너 조회
			List<HealthDateBean> tlist = healthDateDao.getTrainerList(memberBean.getId());
			
			mav.addObject("tlist", tlist);
			
			HealthDateBean healthDateBean = healthDateDao.getOneHealthDate(hnum);
			List<HealthBean> hlist = healthDao.getOneHealth(hnum);


			System.out.println(healthDateBean.getHdate());

			model.addAttribute("healthDateBean", healthDateBean);
			model.addAttribute("hlist", hlist);

			mav.setViewName(getPage);
		}
		
		return mav;
	}

	// update작업
	@RequestMapping(value = command)
	public String doAction(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setContentType("text/html; charset=UTF-8");
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		
		int hnum = Integer.parseInt(request.getParameter("hnum"));
		String hdate = request.getParameter("hdate");
		String olddate = request.getParameter("olddate");
		String tid = request.getParameter("tid");
		
		if (hdate.equals(olddate)) { // 운동날짜 변경 안함
			
			healthDateDao.updateHealthTid(hnum, tid);
			
			healthDao.deleteHealthByHnum(hnum);
			updateHealthRequest(request, hdate, hnum);

		} else { // 운동날짜 변경함

			// 운동날짜가 이미 있으면
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("hdate", hdate);
			map.put("id", memberBean.getId());
			List<HealthDateBean> hlist = healthDateDao.getHealthByHdate(map);
			
			if (hlist != null) {
				try {
					response.getWriter()
							.print("<script>alert('선택하신 일자는 이미 운동이 등록되어있습니다. 다른 날짜를 선택해주세요');history.go(-1);</script>");
					response.getWriter().flush();
				} catch (IOException e) {
					System.out.println("IOException");
					e.printStackTrace();
				}

			} else {
				healthDao.deleteHealthByHnum(hnum);
				int cnt = healthDateDao.updateHealthDate(hnum, hdate, tid);
				if (cnt != -1) {
					updateHealthRequest(request, hdate, hnum);
				} else {
					System.out.println("HD update fail");
				}
			}
		}

		return gotoPage;
	}

	private void updateHealthRequest(HttpServletRequest request, String hdate, int hnum) {

		String[] hname = request.getParameterValues("hname");
		String[] starthour = request.getParameterValues("starthour");
		String[] startminute = request.getParameterValues("startminute");
		String[] endhour = request.getParameterValues("endhour");
		String[] endminute = request.getParameterValues("endminute");
		String[] hcount = request.getParameterValues("hcount");
		String[] hset = request.getParameterValues("hset");

		for (int i = 0; i < hname.length; i++) {
			HealthBean healthBean = new HealthBean();

			healthBean.setHnum(hnum);
			healthBean.setHname(hname[i]);
			healthBean.setStarttime(hdate + " " + starthour[i] + ":" + startminute[i]);
			healthBean.setEndtime(hdate + " " + endhour[i] + ":" + endminute[i]);
			healthBean.setHcount(Integer.parseInt(hcount[i]));
			healthBean.setHset(Integer.parseInt(hset[i]));

			int cnt = healthDao.insertHealth(healthBean);
			System.out.println("cnt : " + cnt);
		}
	}
}
