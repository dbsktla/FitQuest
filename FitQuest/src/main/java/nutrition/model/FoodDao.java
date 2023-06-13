package nutrition.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class FoodDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace = "nutrition.model.Food";

	public List<FoodBean> getAllDetailByDate(Map<String, Object> map) {
		List<FoodBean> flist = sqlSessionTemplate.selectList(namespace + ".GetAllDetailByDate", map);
		return flist;
	}
}
