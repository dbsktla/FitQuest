package health.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class HealthDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "health.model.Health";
	
	
	public List<HealthBean> getOneHealth(int hnum) {
		List<HealthBean> timelist = new ArrayList<HealthBean>();
		timelist = sqlSessionTemplate.selectList(namespace + ".GetOneHealth", hnum);
		return timelist;
	}

}
