package healthcare.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class HealthCareDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "healthcare.model.HealthCare";
	
	public List<HealthCareBean> getHealthCareList(Map<String, Object> map) {
		System.out.println("getHealthCareList");
		System.out.println("tid : " + map.get("tid"));
		List<HealthCareBean> hclist = sqlSessionTemplate.selectList(namespace + ".GetHealthCareList", map);
		return hclist;
	}
	
	
}
