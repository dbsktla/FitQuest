package notification.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class NotificationDao {
	private final String namespace = "notification.model.Notification";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int insertPurchaseNotif(NotificationBean notifBean) {
		int cnt = sqlSessionTemplate.insert(namespace + ".InsertPurchaseNotif", notifBean);
		return cnt;
	}
	public List<NotificationBean> getAllNotifications(String id){
		List<NotificationBean> nList = new ArrayList<NotificationBean>();
		nList = sqlSessionTemplate.selectList(namespace + ".GetAllNotifs", id);
		return nList;
	}
	public int getNotifCount(String recId) {
		int cnt = sqlSessionTemplate.selectOne(namespace + ".GetNotifCount", recId);
		return cnt;
	}
}
