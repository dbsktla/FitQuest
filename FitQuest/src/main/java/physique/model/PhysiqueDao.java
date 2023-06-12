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

	public int insertPhysique(PhysiqueBean physiqueBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".InsertPhysique", physiqueBean);
		return cnt;
	}

	public int deletePhysique(int phnum) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".DeletePhysique", phnum);
		return cnt;
	}

	public PhysiqueBean getPhysiqueByPhnum(int phnum) {
		PhysiqueBean physiqueBean = sqlSessionTemplate.selectOne(namespace + ".GetPhysiqueByPhnum", phnum);
		return physiqueBean;
	}

	public int updatePhysique(PhysiqueBean physiqueBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".UpdatePhysique", physiqueBean);
		return cnt;
	}

	public List<PhysiqueBean> getPhysiqueList(String id) {
		List<PhysiqueBean> phlist = new ArrayList<PhysiqueBean>();
		phlist = sqlSessionTemplate.selectList(namespace + ".GetPhysiqueList", id);
		return phlist;
	}

	public PhysiqueBean getOnePhysiqueByMaxdate(String id) {
		PhysiqueBean physiqueBean = sqlSessionTemplate.selectOne(namespace + ".GetOnePhysiqueByMaxdate", id);
		return physiqueBean;
	}
}
