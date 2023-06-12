package community.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import utility.Paging;

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
	
	public List<ScrapBean> getMyScrapList(Map<String, String> map) {
		List<ScrapBean> myScrapList = new ArrayList<ScrapBean>();
		myScrapList = sqlSessionTemplate.selectList(namespace + ".GetMyScrapList", map);
		return myScrapList;
	}

	public int getMyScrapCount(Map<String, String> map) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".GetMyScrapCount",map);
		return cnt;
	}
}
