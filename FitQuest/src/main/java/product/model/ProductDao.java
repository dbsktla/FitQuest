package product.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ProductDao {
	private final String trainerNamespace = "trainer.model.Trainer";
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	public void getTrainerList() {
		
	}
	
}
