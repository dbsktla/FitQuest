package member.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import notification.model.NotificationBean;
import notification.model.NotificationDao;

@Controller
public class MemberClearNotificationController {
	private final String command = "clearMyNotifications.mb";

	@Autowired
	NotificationDao notificationDao;
	@RequestMapping(value = command)
	public String doAction(HttpServletRequest request,
						   HttpSession session) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		notificationDao.clearAllNotifs(memberBean.getId());
		session.setAttribute("notifList", null);
		session.setAttribute("notifCount", null);		
		if (request.getHeader("Referer") != null) {
			return "redirect:" + request.getHeader("Referer");
		} else {
			return "redirect:/main.go";
		}
	}
	@RequestMapping("clearNotification.mb")
	public String clearOneNotif(HttpServletRequest request,
			   HttpSession session,
			   @RequestParam("nonum") int nonum) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		//알림 하나만 삭제
		notificationDao.clearOneNotif(nonum);
		//삭제하고 남아서 남았는지 확인. 있으면 다시 가져오기. 
		int notifCount = notificationDao.getNotifCount(memberBean.getId());
		List<NotificationBean> notifList = null;
		if(notifCount > 0) {
			notifList = notificationDao.getAllNotifications(memberBean.getId());
		}
		session.setAttribute("notifList", notifList);
		session.setAttribute("notifCount", notifCount);		
		//조건으로 알림이 없으면 메인 페이지로 보냄. 있으면 다시 알림 목록보기 
		if (notifCount > 0) {
			return "redirect:viewMyNotifications.mb";
		} else {
			return "redirect:/main.go";
		}
	}
}
