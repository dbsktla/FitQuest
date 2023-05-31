package member.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import member.model.GymBean;
import member.model.GymDao;

@Controller
public class GymInsertController {
	private final String command = "/insertG.mb";
	private final String getPage = "gymInsertForm";
	private final String gotoPage = "redirect:/insertT.mb";

	@Autowired
	GymDao gymDao;

	@RequestMapping(value=command,method=RequestMethod.GET)
	public String insert() {
		return getPage;
	} 

	@RequestMapping(value=command,method=RequestMethod.POST)
	public String insert(GymBean gymBean) {

		System.out.println("gname : " + gymBean.getGname());
		System.out.println("gaddr1 : " + gymBean.getGaddr1());
		System.out.println("gaddr2 : " + gymBean.getGaddr2());
		System.out.println("gphone : " + gymBean.getGphone());
		
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
