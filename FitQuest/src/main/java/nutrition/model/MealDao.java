package nutrition.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class MealDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace = "nutrition.model.Meal";

	public int insertMeal(MealBean mealBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".InsertMeal", mealBean);
		return cnt;
	}

	public int getMaxMnum() {
		int mnum = sqlSessionTemplate.selectOne(namespace + ".GetMaxMnum");
		return mnum;
	}

	public int deleteMeal(int mnum) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".DeleteMeal", mnum);
		return cnt;
	}

	public List<MealBean> getMealByNnum(int nnum) {
		List<MealBean> mlist = sqlSessionTemplate.selectList(namespace + ".GetMealByNnum", nnum);
		return mlist;
	}
}
