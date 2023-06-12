package community.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

@Component
public class ScrapDao {
	private String namespace = "scrap.model.Scrap";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public ScrapBean getScrapByIdAndBnum(String id, int bnum) {
		ScrapBean scrapBean = new ScrapBean();
		scrapBean.setBnum(bnum);
		scrapBean.setId(id);
		scrapBean = sqlSessionTemplate.selectOne(namespace + ".GetScrapByIdAndBnum", scrapBean);
		return scrapBean;
	}

	public int insertScrap(ScrapBean scrapBean) {
		int cnt = -1;
		try {
			cnt = sqlSessionTemplate.insert(namespace + ".InsertScrap", scrapBean);
		} catch(DataAccessException e){
			
		}
		return cnt;
	}

	public int deleteScrap(int snum) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".DeleteScrap", snum);
		return cnt;
	}
}
