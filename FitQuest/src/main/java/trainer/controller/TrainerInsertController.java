package trainer.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import gym.model.GymBean;
import gym.model.GymDao;
import member.model.MemberDao;
import review.model.ReviewDao;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;
import utility.FitQuestUtil;


@Controller
public class TrainerInsertController {
	private final String command = "/trainerInsert.mb";
	private final String getPage = "trainerInsertForm";
	private final String gotoPage = "redirect:/login.mb";
	@Autowired
	MemberDao memberDao;
	@Autowired
	TrainerDao trainerDao;
	@Autowired
	GymDao gymDao;
	@Autowired
	ServletContext servletContext;
	@Autowired
	ReviewDao reviewDao;
	
	@RequestMapping(value=command,method=RequestMethod.GET)
	public String insert(Model model) {
		List<GymBean> glist = gymDao.getAllGym();
		model.addAttribute("glist", glist);
		return getPage;
	} 

	@RequestMapping(value=command,method=RequestMethod.POST)
	public String insert(@Valid TrainerBean trainerBean, BindingResult result,HttpServletRequest request, Model model) {
		List<GymBean> glist = gymDao.getAllGym();
		String uploadPath = FitQuestUtil.getValueFromProjectProperties("common_directory") + "/TrainerImage";
		
		File destination = new File(uploadPath + File.separator + trainerBean.getUpload().getOriginalFilename());
		MultipartFile multi =  trainerBean.getUpload();

		if(result.hasErrors()) {
			System.out.println("에러 발생");
			model.addAttribute("glist", glist);
			return getPage; 
		} 
		else {
			int cnt = memberDao.insertMember(trainerBean);
			System.out.println("InsertMember cnt : " + cnt);
			if(cnt != -1) {
				try {
					multi.transferTo(destination);
					System.out.println("image : " + trainerBean.getTimage());
					cnt = trainerDao.insertTrainer(trainerBean);
					System.out.println("InsertTrainer cnt : " + cnt);
					if(cnt != -1) {
						reviewDao.insertBaseValue(trainerBean.getId());
						return gotoPage;
					}
					else {
						System.out.println("Trainer 테이블 삽입 실패");
						cnt = memberDao.deleteMember(trainerBean.getId());
						System.out.println("DeleteMember cnt : " + cnt);
						model.addAttribute("glist", glist);
						return getPage;
					}
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			else {
				System.out.println("Member 테이블 삽입 실패");
				model.addAttribute("glist", glist);
				return getPage; 
			}
		}
		return getPage; 
	}

}
