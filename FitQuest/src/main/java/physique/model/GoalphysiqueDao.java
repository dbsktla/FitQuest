package physique.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class GoalphysiqueDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "physique.model.Goalphysique";
	
	public GoalphysiqueBean getOneGoal(String id) {
		GoalphysiqueBean goalBean = sqlSessionTemplate.selectOne(namespace + ".GetOneGoal", id);
		return goalBean;
	}

	public void insertGoal(GoalphysiqueBean goalphysiqueBean) {
		sqlSessionTemplate.insert(namespace + ".InsertGoal", goalphysiqueBean);
	}
	
	public void updateGoal(GoalphysiqueBean goalphysiqueBean) {
		sqlSessionTemplate.update(namespace + ".UpdateGoal", goalphysiqueBean);
	}
	
}
