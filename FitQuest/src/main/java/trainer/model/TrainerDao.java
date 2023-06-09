package trainer.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import usage.model.UsageBean;

@Component
public class TrainerDao {
	private final String namespace = "trainer.model.Trainer";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int insertTrainer(TrainerBean trainerBean) {
		int cnt = -1;
		try {
			cnt = sqlSessionTemplate.insert(namespace + ".InsertTrainer", trainerBean);
		} catch(DataAccessException e){
			
		}
		return cnt;
	}

	public TrainerBean getTrainer(String tid) {
		TrainerBean trainerBean = sqlSessionTemplate.selectOne(namespace+".GetTrainer",tid);
		return trainerBean;
	}
	
	
}
