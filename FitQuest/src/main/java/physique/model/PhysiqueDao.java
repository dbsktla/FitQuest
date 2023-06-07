package physique.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class PhysiqueDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "physique.model.Physique";
	
	public PhysiqueBean getOnePhysique(Map<String, Object> map) {
		PhysiqueBean physiqueBean = sqlSessionTemplate.selectOne(namespace + ".GetOnePhysique", map);
		return physiqueBean;
	}
	public List<String> getPhysiqueByDate(Map<String, String> map) {
		List<String> dateList = new ArrayList<String>();
		dateList = sqlSessionTemplate.selectList(namespace + ".GetPhysiqueByDate", map);
		return dateList;
	}
}
