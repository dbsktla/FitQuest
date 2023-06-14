package community.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import admin.model.AdminReportBean;


@Component
public class BcommentDao {
	private String namespace="comment.model.Comment";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<BcommentBean> getBcommentList(int bnum) {
		List<BcommentBean> BcommentList = new ArrayList<BcommentBean>();
		BcommentList = sqlSessionTemplate.selectList(namespace + ".GetBcommentList", bnum);
		return BcommentList;
	}

	public int insertBcomment(BcommentBean bcommentBean) {
		int cnt = -1;
		try {
			cnt = sqlSessionTemplate.insert(namespace + ".InsertBcomment", bcommentBean);
		} catch(DataAccessException e){
			
		}
		return cnt;
	}
	
	public int deleteBcomment(int cnum) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".DeleteBcomment",cnum);
		return cnt;
	}

	public int replyBcomment(BcommentBean bcommentBean) {
		int up_cnt = -1, cnt = -1;
		up_cnt = sqlSessionTemplate.update(namespace + ".UpdateCrestep", bcommentBean);
		System.out.println("up_cnt : " + up_cnt);
		if(up_cnt != -1) {
			bcommentBean.setCrestep(bcommentBean.getCrestep() + 1);
			bcommentBean.setCrelevel(bcommentBean.getCrelevel() + 1);
			try {
				cnt = sqlSessionTemplate.insert(namespace + ".ReplyBcomment", bcommentBean);
			} catch(Exception e){
				
			}
		}
		return cnt;
	}
	
	public int updateBcomment(AdminReportBean adminReportBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".UpdateBcomment",adminReportBean);
		return cnt;
	}
	
}
