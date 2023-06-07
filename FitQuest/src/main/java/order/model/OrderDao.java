package order.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class OrderDao {
	private final String namespace = "order.model.Order";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int insertOrder(String id) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".InsertOrder", id);
		return cnt;
	}
	public int selectOrderNum(String id) {
		int orderNum = 0;
		orderNum = sqlSessionTemplate.selectOne(namespace + ".SelectOrderNum", id);
		return orderNum;
	}
}
