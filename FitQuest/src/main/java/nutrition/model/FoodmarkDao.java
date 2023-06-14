package nutrition.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class FoodmarkDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	private final String namespace = "nutrition.model.Foodmark";
}
