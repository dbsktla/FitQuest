package usage.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class UsageDao {
	private final String namespace = "usage.model.Usage";
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	public int getUsageCount(Map<String, String> map) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".GetUsageCount", map);
		return cnt;
	}
	public int insertUsage(UsageBean usageBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".InsertUsage", usageBean);
		return cnt;
	}
	public UsageBean getOneUsage(String mid) {
		UsageBean usageBean = null;
		usageBean = sqlSessionTemplate.selectOne(namespace + ".GetOneUsage", mid);
		return usageBean;
	}

	public String getTid(String mid) {
		String tid = "";
		tid = sqlSessionTemplate.selectOne(namespace + ".GetTid",mid);
		return tid;
	}
	public List<UsageBean> getTListByMid(String mid) {
		List<UsageBean> tidList = new ArrayList<UsageBean>();
		tidList = sqlSessionTemplate.selectList(namespace+".GetTListByMid",mid);
		return tidList;
	}
}
