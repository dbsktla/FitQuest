package member.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import member.model.MemberBean;
import notification.model.NotificationBean;
import notification.model.NotificationDao;

@Controller
public class MemberViewMyNotifsController {
	private final String command = "viewMyNotifications.mb";
	private final String getPage = "myNotificationsList";
	
	@Autowired
	NotificationDao notificationDao;
	
	@RequestMapping(value = command)
	public String doAction(HttpSession session,
						   HttpServletResponse response,
						   Model model) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		response.setContentType("text/html; charset=UTF-8");

		if(memberBean == null) {
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');location.href='login.mb'</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			session.setAttribute("destination", "redirect:/viewMyNotifications.mb");
			return "redirect:/login.mb";
		}
		
		List<NotificationBean> notifList = notificationDao.getAllNotifications(memberBean.getId());
		model.addAttribute("notifList", notifList);
		return getPage;
	}
}
