package reservation.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ReservationDao {
	private final String namespace = "reservation.model.Reservation";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int insertReservation(ReservationBean reservationBean) {
		int cnt = -1;
		System.out.println("넘어오나 확인");
		cnt = sqlSessionTemplate.insert(namespace+".InsertReservation",reservationBean);
		System.out.println("넘어오나 확인"+cnt);
		return cnt;
	}
	
	public int getReservationCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(namespace + ".GetReservationCount", map);
		return cnt;
	}

	public List<ReservationBean> getReservationList(String tid) {
		List<ReservationBean> rList = new ArrayList<ReservationBean>();
		rList = sqlSessionTemplate.selectList(namespace+".GetReservationList",tid);
		return rList;
	}

	public int updateState(int rnum,String rstate) {
		int cnt = -1;
		ReservationBean reservationBean = new ReservationBean();
		reservationBean.setRnum(rnum);
		reservationBean.setRstate(rstate);
		cnt = sqlSessionTemplate.update(namespace+".UpdateState",reservationBean);
		return cnt;
	}
	
}
