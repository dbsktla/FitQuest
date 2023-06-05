package trainer.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

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

	public TrainerBean getTrainer(String id) {
		TrainerBean trainerBean = sqlSessionTemplate.selectOne(namespace + ".GetTrainerById", id);
		return trainerBean;
	}
	
}
