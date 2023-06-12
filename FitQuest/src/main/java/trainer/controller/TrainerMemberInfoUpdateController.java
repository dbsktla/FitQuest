package trainer.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import member.model.MemberBean;
import member.model.MemberDao;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;

@Controller
public class TrainerMemberInfoUpdateController {
	private final String command = "trainerMemberUpdate.mb";
	private final String getPage = "redirect:/trainerDetail.mb";
	@Autowired
	MemberDao memberDao;
	@Autowired
	TrainerDao trainerDao;
	@RequestMapping(value = command)
	public String doAction(@ModelAttribute("memberBean") @Valid MemberBean memberBean,
						   BindingResult result,
						   Model model,
						   HttpSession session) {
		if(result.hasErrors()) {
			return getPage;
		} else {
			int cnt = memberDao.updateTrainerMember(memberBean);
			if(cnt > 0) {
				System.out.println("수정 성공.");
			}
		}
		TrainerBean trainerBean = trainerDao.getTrainer(memberBean.getId());
		MemberBean memberBean2 = memberDao.selectMemberById(memberBean.getId());
		session.setAttribute("loginInfo", memberBean2);
		model.addAttribute("trainerBean", trainerBean);
		return getPage;
	}
}
