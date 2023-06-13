package member.controller;

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
@Controller
public class MemberUpdateInfoController {
	private final String command = "genericMemberUpdate.mb";
	private final String getPage = "redirect:/genericMemberDetail.mb";
	@Autowired
	MemberDao memberDao;
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
		MemberBean memberBean2 = memberDao.selectMemberById(memberBean.getId());
		session.setAttribute("loginInfo", memberBean2);
		return getPage;
	}
}
