package complete.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CompleteDao {
	private final String namespace = "complete.model.Complete";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int insertComplete(CompleteBean cb) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace+".InsertComplete",cb);
		return cnt;
	}

	public List<CompleteBean> getAllComplete(String tid) {
		List<CompleteBean> cList = new ArrayList<CompleteBean>();
		cList = sqlSessionTemplate.selectList(namespace+".GetAllComplete",tid);
		return cList;
	}

	public List<CompleteBean> getCompleteByPeople(String tid, int people) {
		CompleteBean cb = new CompleteBean();
		cb.setTid(tid);
		cb.setCpeople(people);
		List<CompleteBean> cList = new ArrayList<CompleteBean>();
		cList = sqlSessionTemplate.selectList(namespace+".GetCompleteByPeople",cb);
		return cList;
	}
}
