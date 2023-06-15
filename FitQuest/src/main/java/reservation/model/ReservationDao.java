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
		cnt = sqlSessionTemplate.insert(namespace+".InsertReservation",reservationBean);
		return cnt;
	}
	
	public int getReservationCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(namespace + ".GetReservationCount", map);
		return cnt;
	}

	public List<ReservationBean> getReservationFList(String tid) {
		List<ReservationBean> rList = new ArrayList<ReservationBean>();
		rList = sqlSessionTemplate.selectList(namespace+".GetReservationFList",tid);
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

	public List<ReservationBean> getReservationTList(String tid) {
		List<ReservationBean> rList = new ArrayList<ReservationBean>();
		rList = sqlSessionTemplate.selectList(namespace+".GetReservationTList",tid);
		return rList;
	}

	public ReservationBean getOneByRnum(int rnum) {
		ReservationBean reservationBean = sqlSessionTemplate.selectOne(namespace+".GetOneByRnum",rnum);
		return reservationBean;
	}

	public List<ReservationBean> getReservationTListByMid(String mid) {
		List<ReservationBean> tList = new ArrayList<ReservationBean>();
		tList = sqlSessionTemplate.selectList(namespace+".GetReservationTListByMid",mid);
		return tList;
	}
	
	public List<ReservationBean> getReservationFListByMid(String mid) {
		List<ReservationBean> fList = new ArrayList<ReservationBean>();
		fList = sqlSessionTemplate.selectList(namespace+".GetReservationFListByMid",mid);
		return fList;
	}
	
	public List<ReservationBean> getReservationJListByMid(String mid) {
		List<ReservationBean> jList = new ArrayList<ReservationBean>();
		jList = sqlSessionTemplate.selectList(namespace+".GetReservationJListByMid",mid);
		return jList;
	}

	public List<ReservationBean> getReservationAllList(String mid) {
		List<ReservationBean> rList = new ArrayList<ReservationBean>();
		rList = sqlSessionTemplate.selectList(namespace+".GetReservationAllList",mid);
		return rList;
	}

	public int updateStateComplete(int rnum) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace+".UpdateStateComplete",rnum);
		return cnt;
	}

	public List<ReservationBean> getReservationCList(String mid) {
		List<ReservationBean> cList = new ArrayList<ReservationBean>();
		cList = sqlSessionTemplate.selectList(namespace+".GetReservationCList",mid);
		return cList;
	}

	public int cancelReservation(int rnum) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace+".CancelReservation",rnum);
		return cnt;
	}

	public List<ReservationBean> getReservationTCList(String tid) {
		List<ReservationBean> rList = new ArrayList<ReservationBean>();
		rList = sqlSessionTemplate.selectList(namespace+".GetReservationTCList",tid);
		return rList;
	}

	
}
