package community.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import trainer.model.TrainerBean;
import trainer.model.TrainerDao;

@Controller
public class TrainerInfoPopupController {
	private final String command = "/trainerInfoPopup.co";
	private final String getPage = "trainerInfoPopup";
	
	@Autowired
	TrainerDao trainerDao;
	
	@RequestMapping(value=command)
	public String insert(@RequestParam("id") String id, Model model) {
		TrainerBean trainerBean = null;
		trainerBean = trainerDao.getTrainerMember(id);
		model.addAttribute("trainerBean",trainerBean);
		return getPage;
	} 
	
	
}
