package member.controller;

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

import member.model.GymBean;
import member.model.GymDao;
import member.model.MemberDao;
import member.model.TrainerBean;
import member.model.TrainerDao;

@Controller
public class TrainerInsertController {
	private final String command = "/insertT.mb";
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

	@RequestMapping(value=command,method=RequestMethod.GET)
	public String insert(Model model) {
		List<GymBean> glist = gymDao.getAllGym();
		model.addAttribute("glist", glist);
		return getPage;
	} 

	@RequestMapping(value=command,method=RequestMethod.POST)
	public String insert(@Valid TrainerBean trainerBean, BindingResult result,HttpServletRequest request) {
		String uploadPath = "c:/TrainerImage";
		
		File destination = new File(uploadPath + File.separator + trainerBean.getUpload().getOriginalFilename());
		MultipartFile multi =  trainerBean.getUpload();

		if(result.hasErrors()) {
			System.out.println("에러 발생");
			return getPage; 
		} 
		else {
			int cnt = memberDao.insertMember(trainerBean);
			if(cnt != -1) {
				try {
					multi.transferTo(destination);
					cnt = trainerDao.insertTrainer(trainerBean);
					if(cnt != -1) {
						System.out.println("삽입 실패");
						return getPage; 
					}
					else {
						return gotoPage;
					}
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			else {
				System.out.println("삽입 실패");
				return getPage; 
			}
		}
		return getPage; 
	}

}
