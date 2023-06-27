package question.model;

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
	
}
