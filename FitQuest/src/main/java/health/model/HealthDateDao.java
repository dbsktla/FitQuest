package health.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class HealthDateDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "health.model.HealthDate";
	
	public List<HealthDateBean> getMyHealthDateList(Map<String, Object> map) {
		List<HealthDateBean> hdlist = new ArrayList<HealthDateBean>();
		hdlist = sqlSessionTemplate.selectList(namespace + ".GetMyHealthDateList", map);
		return hdlist;
	}

	public List<HealthDateBean> getHealthByHdate(String hdate) {
		List<HealthDateBean> oldList = sqlSessionTemplate.selectList(namespace + ".GetHealthByHdate", hdate);
		return oldList;
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

	public int updateHealthDate(int hnum, String hdate, String tid) {
		int cnt = -1;
		HealthDateBean hdb = new HealthDateBean();
		hdb.setHnum(hnum);
		hdb.setHdate(hdate);
		hdb.setTid(tid);
		cnt = sqlSessionTemplate.update(namespace + ".UpdateHealthDate" , hdb);
		return 0;
	}

	public void updateHealthTid(int hnum, String tid) {
		HealthDateBean hdb = new HealthDateBean();
		hdb.setHnum(hnum);
		hdb.setTid(tid);
		sqlSessionTemplate.update(namespace + ".UpdateHealthTid" , hdb);
		
	}

	public String getComp(int onum) {
		String str = sqlSessionTemplate.selectOne(namespace + ".GetComp", onum);
		return str;
	}

	public HealthDateBean getHealthByHdateTid(Map<String, Object> map) {
		HealthDateBean hdb = sqlSessionTemplate.selectOne(namespace + ".GetHealthByHdateTid", map);
		return hdb;
	}

}
