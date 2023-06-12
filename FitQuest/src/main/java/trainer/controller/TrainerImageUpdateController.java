package trainer.controller;

import java.io.File;
import java.io.IOException;

import org.apache.commons.collections.bag.SynchronizedSortedBag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import trainer.model.TrainerBean;
import trainer.model.TrainerDao;
import utility.FitQuestUtil;

@Controller
public class TrainerImageUpdateController {
	private final String command = "trainerUpdateImage.mb";
	private final String getPage = "redirect:/trainerDetail.mb";
	
	@Autowired
	TrainerDao trainerDao;
	@RequestMapping(value = command)
	public String doAction(TrainerBean trainerBean,
						   @RequestParam("oldtimage") String oldtimage,
						   Model model) throws IllegalStateException, IOException {
		System.out.println(trainerBean.getId());
		String uploadPath = FitQuestUtil.getValueFromProjectProperties("common_directory") + "/TrainerImage";
		File destination = new File(uploadPath + File.separator + trainerBean.getUpload().getOriginalFilename());
		MultipartFile multi =  trainerBean.getUpload();
		String fileName = trainerBean.getUpload().getOriginalFilename();
		if(fileName.equals(oldtimage)) {
			trainerBean.setTimage(oldtimage);
		} else {
			trainerBean.setTimage(fileName);
			int cnt = trainerDao.updateTimage(trainerBean);
			File delFile = new File(uploadPath + File.separator + oldtimage);
			boolean delFlag = delFile.delete();
			multi.transferTo(destination);
		}
		model.addAttribute("trainerBean", trainerDao.getTrainer(trainerBean.getId()));
		return getPage;
	}
}
