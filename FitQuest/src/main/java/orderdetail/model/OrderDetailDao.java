package orderdetail.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class OrderDetailDao {
	private final String namespace = "orderdetail.model.Orderdetail";
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	public int insertOrderDetail(Map<String, Integer> odMap) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".InsertOrderDetail", odMap);
		return cnt;
	}
	public List<Integer> getPnumList(int onum) {
		List<Integer> pnumList = new ArrayList<Integer>();
		pnumList = sqlSessionTemplate.selectList(namespace + ".GetPnumList", onum);
		return pnumList;
	}
	public int getOrderCountByPnum(int pnum) {
		int cnt = sqlSessionTemplate.selectOne(namespace + ".GetOrderCountByPnum", pnum);
		return cnt;
	}
	public List<OrderDetailBean> getOrderDetailListByOnum(int onum) {
		List<OrderDetailBean> odList = new ArrayList<OrderDetailBean>();
		odList = sqlSessionTemplate.selectList(namespace + ".GetOrderDetails", onum);
		return odList;
	}
	
}
