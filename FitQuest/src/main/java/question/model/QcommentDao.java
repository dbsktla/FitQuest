package question.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class QcommentDao {
	private final String namespace = "qcomment.model.Qcomment";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public QcommentBean getQcommentByQnum(int qnum) {
		QcommentBean qcommentBean = null;
		qcommentBean = sqlSessionTemplate.selectOne(namespace + ".GetQcommentByQnum", qnum);
		return qcommentBean;
	}
	
	public int getQcommentByQnumCount(int qnum) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".GetQcommentByQnumCount", qnum);
		return cnt;
	}

	public int insertQcomment(QcommentBean qcommentBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".InsertQcomment", qcommentBean);
		return cnt;
	}
	
	public int deleteQcomment(int qcnum) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".DeleteQcomment", qcnum);
		return cnt;
	}

}
