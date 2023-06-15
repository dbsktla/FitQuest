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

	public int insertFood(FoodBean foodBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".InsertFood", foodBean);
		return cnt;
	}

	public int getMaxFnum() {
		int fnum = sqlSessionTemplate.selectOne(namespace + ".GetMaxFnum");
		return fnum;
	}

	public List<FoodBean> getAllByMnum(Map<String, Object> map) {
		List<FoodBean> flist = sqlSessionTemplate.selectList(namespace + ".GetAllByMnum", map);
		return flist;
	}

	public void deleteFood(int delfnum) {
		sqlSessionTemplate.delete(namespace + ".DeleteFood", delfnum);
	}
}
