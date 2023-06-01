package gym.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

@Component
public class GymDao {
	private String namespace = "gym.model.Gym";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<GymBean> getAllGym(){
		List<GymBean> glist = new ArrayList<GymBean>();
		glist = sqlSessionTemplate.selectList(namespace + ".GetAllGym");
		return glist;
	}
	
	public int insertGym(GymBean gymBean) {
		int cnt = -1;
		try {
			cnt = sqlSessionTemplate.insert(namespace + ".InsertGym", gymBean);
		} catch(DataAccessException e){
			
		}
		return cnt;
	}

	public boolean searchGname(String gname) {
		boolean isCheck = false;
		int cnt = sqlSessionTemplate.selectOne(namespace + ".SearchGname", gname);
		if(cnt > 0) {
			isCheck = true;
		}
		return isCheck;
	}
}
