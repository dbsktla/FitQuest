package trainer.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import gym.model.GymBean;
import gym.model.GymDao;
import member.model.MemberBean;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;

@Controller
public class TrainerDetailController {
	private final String command = "trainerDetail.mb";
	private final String getPage = "myTrainerDetail";
	@Autowired
	TrainerDao trainerDao;
	@Autowired
	GymDao gymDao;
	@RequestMapping(value = command)
	public String doAction(HttpSession session,
						   HttpServletResponse response,
						   Model model) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo"); 
		response.setContentType("text/html; charset=utf-8");
		session.setAttribute("topmenu", "trainerMember");
		
		if(memberBean == null) {
			session.setAttribute("destination", "redirect:/trainerDetail.mb");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/login.mb";
		}
		TrainerBean trainerBean = trainerDao.getTrainer(memberBean.getId());
		GymBean gymBean = gymDao.selectGym(trainerBean.getGnum());
		String[] date = memberBean.getBirth().split(" ");
		memberBean.setBirth(date[0]);
		model.addAttribute("trainerBean", trainerBean);
		model.addAttribute("memberBean", memberBean);
		model.addAttribute("gymBean", gymBean);
		return getPage;
	}
}
