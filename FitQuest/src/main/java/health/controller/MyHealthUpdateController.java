package health.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

@Controller
public class MyHealthUpdateController {
	private final String command = "myHealthUpdate.ht";
	private final String getPage = "myHealthUpdateForm";
	private final String gotoPage = "redirect:/myHealthList.ht";

	@Autowired
	HealthDateDao healthDateDao;
	@Autowired
	HealthDao healthDao;

	// updateForm 으로 이동
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView doAction(@RequestParam("hnum") int hnum, Model model) {
		ModelAndView mav = new ModelAndView();

		HealthDateBean healthDateBean = healthDateDao.getOneHealthDate(hnum);
		List<HealthBean> hlist = healthDao.getOneHealth(hnum);

		// mav.addObject("healthDateBean", healthDateBean);
		// mav.addObject("hlist", hlist);

		System.out.println(healthDateBean.getHdate());

		model.addAttribute("healthDateBean", healthDateBean);
		model.addAttribute("hlist", hlist);

		mav.setViewName(getPage);

		return mav;
	}

	// update작업
	@RequestMapping(value = command)
	public String doAction(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("text/html; charset=UTF-8");

		int hnum = Integer.parseInt(request.getParameter("hnum"));
		String hdate = request.getParameter("hdate");
		String olddate = request.getParameter("olddate");

		if (hdate.equals(olddate)) { // 운동날짜 변경 안함
			healthDao.deleteHealthByHnum(hnum);
			updateHealthRequest(request, hdate, hnum);

		} else { // 운동날짜 변경함

			// 운동날짜가 이미 있으면
			HealthDateBean healthDateBean = healthDateDao.getHealthByHdate(hdate);

			if (healthDateBean != null) {
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
				int cnt = healthDateDao.updateHealthDate(hnum, hdate);
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
