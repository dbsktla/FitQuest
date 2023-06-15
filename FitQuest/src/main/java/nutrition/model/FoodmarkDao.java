package nutrition.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class FoodmarkDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	private final String namespace = "nutrition.model.Foodmark";
	
	public int insertFoodmark(FoodmarkBean foodmarkBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".InsertFoodmark", foodmarkBean);
		return cnt;
	}

	public List<FoodBean> getFoodMarkList(String id) {
		List<FoodBean> fklist = sqlSessionTemplate.selectList(namespace + ".GetFoodMarkList", id);
		return fklist;
	}

	public int deleteFoodmark(int fknum) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".DeleteFoodmark", fknum);
		return cnt;
	}

	public int countFoodmark(FoodmarkBean foodmarkBean) {
		int count = sqlSessionTemplate.selectOne(namespace + ".CountFoodmark", foodmarkBean);
		return count;
	}
}
