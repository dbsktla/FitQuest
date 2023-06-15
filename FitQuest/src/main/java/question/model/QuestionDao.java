package question.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component
public class QuestionDao {
	private final String namespace = "question.model.Question";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int getQuestionRequestCount() {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".GetQuestionRequestCount");
		return cnt;
	}

	public List<QuestionBean> getQuestionFinishList(Paging pageInfo, Map<String, String> map) {
		List<QuestionBean> QueReqList = new ArrayList<QuestionBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		QueReqList = sqlSessionTemplate.selectList(namespace + ".GetQuestionFinishList", map, rowBounds);
		return QueReqList;
	}
	
	public int getQuestionFinishCount() {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".GetQuestionRequestCount");
		return cnt;
	}
	
	public List<QuestionBean> getQuestionRequestList(Paging pageInfo, Map<String, String> map) {
		List<QuestionBean> QueFinList = new ArrayList<QuestionBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		QueFinList = sqlSessionTemplate.selectList(namespace + ".GetQuestionFinishList", map, rowBounds);
		return QueFinList;
	}
}
