package reservation.model;

import java.util.ArrayList;
import java.util.List;

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
		System.out.println("넘어오는지 테스트");
		cnt = sqlSessionTemplate.insert(namespace+".InsertTschedule",tscheduleBean);
		return cnt;
	}

	public List<TscheduleBean> findTschedule(String tid) {
		List<TscheduleBean> tsList = new ArrayList<TscheduleBean>();
		tsList = sqlSessionTemplate.selectList(namespace+".FindTschedule",tid);
		return tsList;
	}

	public int updateTschedule(TscheduleBean tscheduleBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace+".UpdateTschedule",tscheduleBean);
		return cnt;
	}

	public List<TscheduleBean> findTscheduleByTspeople(int tspeople,String tid) {
		List<TscheduleBean> tsList = new ArrayList<TscheduleBean>();
		TscheduleBean tb = new TscheduleBean();
		tb.setTspeople(tspeople);
		tb.setTid(tid);
		tsList = sqlSessionTemplate.selectList(namespace+".FindTscheduleByTspeople",tb);
		return tsList;
	}

	public int deleteTschedule(TscheduleBean tsb) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace+".DeleteTschedule",tsb);
		return cnt;
	}

	
	
}
