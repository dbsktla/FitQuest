package product.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import gym.model.GymBean;
import gym.model.GymDao;
import member.model.MemberBean;
import member.model.MemberDao;
import reservation.model.ReservationDao;
import review.model.ReviewBean;
import review.model.ReviewDao;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;

@Controller
public class ProductReviewInsertController {
	private final String command = "reviewWrite.pd";
	private final String getPage=  "reviewWriteForm";
	@Autowired
	ReviewDao reviewDao;
	@Autowired
	ReservationDao reservationDao;
	@Autowired
	TrainerDao trainerDao;
	@Autowired
	MemberDao memberDao;
	@Autowired
	GymDao gymDao;
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(@RequestParam("id") String id,
						   HttpSession session,
						   HttpServletResponse response,
						   Model model) throws IOException {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		TrainerBean trainerBean = trainerDao.getTrainer(id);
		MemberBean tmemberBean = memberDao.selectMemberById(id);
		GymBean gymBean = gymDao.selectGym(trainerBean.getGnum());
		response.setContentType("text/html; charset=utf-8");
		if(memberBean == null) { // 로그인 정보 없을 때
			session.setAttribute("destination", "redirect:/reviewWrite.pd?id=" + id);
			response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
			response.getWriter().flush();
			return "forward:/login.mb";
		} else { //로그인된 상태.
			if(!memberBean.getMtype().equals("generic")) { //일반 회원 확인.
				response.getWriter().print("<script>alert('일반 회원만 리뷰 작성 가능합니다.');</script>");
				response.getWriter().flush();
				return "forward:/main.go";
			}
			Map<String, String> map = new HashMap<String, String>();
			map.put("tid", id);
			map.put("mid", memberBean.getId());
			int revCount = reviewDao.reviewCountCheck(map);
			System.out.print("revCount: " + revCount);
			if(revCount > 0) { //트레이너 리뷰 작성 있는지 확인.
				response.getWriter().print("<script>alert('해당 트레이너 이미 리뷰 작성했습니다.');</script>");
				response.getWriter().flush();
				return "forward:/main.go";
			}
			int reserveCount = reservationDao.getReservationCount(map);
			if(reserveCount < 3) { //수업 3번 이상 받았는지 확인. 
				response.getWriter().print("<script>alert('해당 트레이너에게 수업 3번 이상 받아야 됩니다.');</script>");
				response.getWriter().flush();
				return "forward:/trainerList.pd";
			}
			System.out.println("resCount" + reserveCount);
			model.addAttribute("reserveCount", reserveCount);
		}
		model.addAttribute("trainerBean", trainerBean);
		model.addAttribute("gymBean", gymBean);
		model.addAttribute("memberBean", memberBean);
		model.addAttribute("tmemberBean", tmemberBean);
		return getPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String doAction(@ModelAttribute("reviewBean") @Valid ReviewBean reviewBean,
						   BindingResult result,
						   HttpSession session,
						   Model model,
						   HttpServletResponse response) throws IOException{
		String id = reviewBean.getTid();
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		TrainerBean trainerBean = trainerDao.getTrainer(id);
		MemberBean tmemberBean = memberDao.selectMemberById(id);
		GymBean gymBean = gymDao.selectGym(trainerBean.getGnum());
		response.setContentType("text/html; charset=utf-8");

		Map<String, String> map = new HashMap<String, String>();
		map.put("tid", id);
		map.put("mid", memberBean.getId());
		int reserveCount = reservationDao.getReservationCount(map);

		model.addAttribute("reserveCount", reserveCount);
		model.addAttribute("trainerBean", trainerBean);
		model.addAttribute("gymBean", gymBean);
		model.addAttribute("memberBean", memberBean);
		model.addAttribute("tmemberBean", tmemberBean);
		if(result.hasErrors()) {
			return getPage;
		} else { 
			int cnt = reviewDao.insertReview(reviewBean);
			if(cnt > 0) {
				System.out.println("REVIEW INSERT SUCCESS");
				reviewDao.deleteBaseValue(id);
				response.getWriter().print("<script>alert('리뷰 작성 됐습니다.');</script>");
				response.getWriter().flush();
			}
		}
		return "forward:/main.go";
	}
}
