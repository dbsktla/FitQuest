package complete.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CompleteDao {
	private final String namespace = "complete.model.Complete";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
}
