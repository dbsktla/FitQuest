package product.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component
public class ProductDao {
	private final String trainerNamespace = "trainer.model.Trainer";
	private final String namespace = "composite.model.Composite";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	public int getTrainerCount(Map<String, String> map) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".GetTrainerCount", map);
		return cnt;
	}
	public List<MyTrainerList> getTrainerList(Map<String, String> map, Paging pageInfo) {
		List<MyTrainerList> tList = new ArrayList<MyTrainerList>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		tList = sqlSessionTemplate.selectList(namespace + ".GetTrainerList", tList, rowBounds);
		return tList;
	}
}
