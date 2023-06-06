package health.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class HealthDateDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "health.model.HealthDate";
	
	public List<HealthDateBean> getMyHealthDateList(String id) {
		List<HealthDateBean> hdlist = new ArrayList<HealthDateBean>();
		hdlist = sqlSessionTemplate.selectList(namespace + ".GetMyHealthDateList", id);
		return hdlist;
	}

	public HealthDateBean getHealthByHdate(String hdate) {
		HealthDateBean hdb = sqlSessionTemplate.selectOne(namespace + ".GetHealthByHdate", hdate);
		return hdb;
	}
	
	public HealthDateBean getOneHealthDate(int hnum) {
		HealthDateBean healthDateBean = new HealthDateBean(); 
		healthDateBean = sqlSessionTemplate.selectOne(namespace + ".GetOneHealthDate", hnum);
		return healthDateBean;
	}

	public int insertHealthDate(HealthDateBean healthDateBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".InsertHealthDate", healthDateBean);
		return cnt;
	}

	public void deleteHealthDate(String hnum) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".DeleteHealthDate" , hnum);
		System.out.println("healthDelete cnt : " + cnt);
	}

	public int updateHealthDate(int hnum, String hdate) {
		int cnt = -1;
		HealthDateBean hdb = new HealthDateBean();
		hdb.setHnum(hnum);
		hdb.setHdate(hdate);
		cnt = sqlSessionTemplate.update(namespace + ".UpdateHealthDate" , hdb);
		return 0;
	}

}
