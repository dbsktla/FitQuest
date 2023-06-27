package question.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TquestionDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	private final String namespace = "question.model.Tquestion";
	
	public int insertTQuestion(TquestionBean tquestionBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".InsertTQuestion", tquestionBean);
		return cnt;
	}

	public List<TquestionBean> getTquestionList(String id) {
		List<TquestionBean> tqlist = new ArrayList<TquestionBean>();
		tqlist = sqlSessionTemplate.selectList(namespace + ".GetTquestionList", id);
		return tqlist;
	}

	public TquestionBean getTquestionDetail(int tqnum) {
		TquestionBean tqbean = sqlSessionTemplate.selectOne(namespace + ".GetTquestionDetail", tqnum);
		return tqbean;
	}

	public int delete30Days() {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".Delete30Days");
		return cnt;
	}
	
}
