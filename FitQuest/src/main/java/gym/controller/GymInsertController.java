package gym.controller;


import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import gym.model.GymBean;
import gym.model.GymDao;

@Controller
public class GymInsertController {
	private final String command = "/gymInsert.mb";
	private final String getPage = "gymInsertForm";
	private final String gotoPage = "redirect:/trainerInsert.mb";

	@Autowired
	GymDao gymDao;

	@RequestMapping(value=command,method=RequestMethod.GET)
	public String insert() {
		return getPage;
	} 

	@RequestMapping(value=command,method=RequestMethod.POST)
	public String insert(@Valid GymBean gymBean, BindingResult result, HttpServletResponse response) {
		response.setContentType("text/html;charset=UTF-8");
		if(result.hasErrors()) {
			return getPage;
		}
		else {
			try {
				int cnt = gymDao.insertGym(gymBean);
				System.out.println("InsertGym cnt : " + cnt);
				if(cnt != -1) {
					response.getWriter().print("<script>alert('헬스장 등록되었습니다.');location.href='gymList.mb';</script>");
					response.getWriter().flush();
				}
				else {
					return getPage;
				}
			} catch (IOException e) {
				e.printStackTrace();
			}	
			return "";
		}	
	}
	
	@RequestMapping("/gymList.mb")
	public String list(Model model) {
		List<GymBean> glist = gymDao.getAllGym();
		model.addAttribute("glist",glist);
		return "gymList";
	}
}
