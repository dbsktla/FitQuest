package nutrition.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class NutritionDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace = "nutrition.model.Nutrition";

	public List<String> getNutritionDate(Map<String, String> map) {
		List<String> dateList = new ArrayList<String>();
		dateList = sqlSessionTemplate.selectList(namespace + ".GetNutritionDate", map);
		return dateList;
	}
	
	public NutritionBean getNutritionDateOne(Map<String, Object> map) {
		NutritionBean nb = sqlSessionTemplate.selectOne(namespace + ".GetNutritionDateOne", map);
		return nb;
	}

	public int insertNutrition(NutritionBean nutritionBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".InsertNutrition", nutritionBean);
		return cnt;
	}

	public int getMaxNnum() {
		int nnum = sqlSessionTemplate.selectOne(namespace + ".GetMaxNnum");
		return nnum;
	}

}
