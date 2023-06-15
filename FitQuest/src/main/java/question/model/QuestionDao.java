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
	
	public List<QuestionBean> getQuestionRequestList(Paging pageInfo, Map<String, String> map) {
		List<QuestionBean> QueFinList = new ArrayList<QuestionBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		QueFinList = sqlSessionTemplate.selectList(namespace + ".GetQuestionRequestList", map, rowBounds);
		return QueFinList;
	}

	public List<QuestionBean> getQuestionFinishList(Paging pageInfo, Map<String, String> map) {
		List<QuestionBean> QueReqList = new ArrayList<QuestionBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		QueReqList = sqlSessionTemplate.selectList(namespace + ".GetQuestionFinishList", map, rowBounds);
		return QueReqList;
	}
	
	public int getQuestionFinishCount() {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".GetQuestionFinishCount");
		return cnt;
	}
	
	public int getMyQuestionCount(String id) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".GetMyQuestionCount", id);
		return cnt;
	}
	
	public List<QuestionBean> getMyQuestionList(Paging pageInfo, Map<String, String> map) {
		List<QuestionBean> myQuestionList = new ArrayList<QuestionBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		myQuestionList = sqlSessionTemplate.selectList(namespace + ".GetMyQuestionList", map, rowBounds);
		return myQuestionList;
	}

	public int insertQuestion(QuestionBean questionBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".InsertQuestion", questionBean);
		return cnt;
	}

	public QuestionBean getQuestionByQnum(int qnum) {
		QuestionBean questionBean = null;
		questionBean = sqlSessionTemplate.selectOne(namespace + ".GetQuestionByQnum", qnum);
		return questionBean;
	}

	public int updateInsertQstatus(int qnum) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".UpdateInsertQstatus", qnum);
		return cnt;
	}
	
	public int updateDeleteQstatus(int qnum) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".UpdateDeleteQstatus", qnum);
		return cnt;
	}

	public int deleteQuestion(int qnum) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".DeleteQuestion", qnum);
		return cnt;
	}

}
