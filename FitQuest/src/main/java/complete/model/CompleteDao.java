package complete.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import reservation.model.ReservationBean;

@Component
public class CompleteDao {
	private final String namespace = "complete.model.Complete";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int insertComplete(ReservationBean rb) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace+".InsertComplete",rb);
		return cnt;
	}
}
