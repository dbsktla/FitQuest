package gym.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	public String insert(GymBean gymBean) {
		
		int cnt = gymDao.insertGym(gymBean);
		System.out.println("InsertGym cnt : " + cnt);
		if(cnt != -1) {
			return gotoPage;			
		}
		else {
			return getPage;
		}
	}
}
