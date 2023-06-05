package reservation.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TscheduleDao {
private final String namespace = "reservation.model.Reservation";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int insertTschedule(TscheduleBean tscheduleBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace+".InsertTschedule",tscheduleBean);
		return cnt;
	}

	public TscheduleBean findTschedule(String tid) {
		TscheduleBean tscheduleBean = null;
		tscheduleBean = sqlSessionTemplate.selectOne(namespace+".FindTschedule",tid);
		return tscheduleBean;
	}
	
	
}
