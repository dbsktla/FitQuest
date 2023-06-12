package trainer.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import trainer.model.TrainerBean;
import trainer.model.TrainerDao;

@Controller
public class TrainerInfoUpdateController {
	private final String command = "trainerInfoUpdate.mb";
	private final String getPage = "redirect:/trainerDetail.mb";
	@Autowired
	TrainerDao trainerDao;
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String doAction(@Valid TrainerBean trainerBean,
			BindingResult result,
			Model model) {
		int cnt = trainerDao.updateTrainer(trainerBean);
		if(cnt > 0) {
			System.out.println("수정 성공");
		}
		return getPage;
	}
}
