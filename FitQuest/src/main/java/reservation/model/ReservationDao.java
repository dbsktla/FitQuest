package reservation.model;

import java.util.Date;

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
	
	
	
}
