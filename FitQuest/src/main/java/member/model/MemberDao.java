package member.model;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import trainer.model.TrainerBean;

@Component
public class MemberDao {
	private String namespace = "member.model.Member";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public boolean searchId(String id) {
		boolean isCheck = false;
		int cnt = sqlSessionTemplate.selectOne(namespace + ".SearchId", id);
		if(cnt > 0) {
			isCheck = true;
		}
		return isCheck;
	}
	
	public boolean searchNickname(String nickname) {
		boolean isCheck = false;
		int cnt = sqlSessionTemplate.selectOne(namespace + ".SearchNickname", nickname);
		if(cnt > 0) {
			isCheck = true;
		}
		return isCheck;
	}
	
	public int insertMember(MemberBean memberBean) {
		int cnt = -1;
		try {
			cnt = sqlSessionTemplate.insert(namespace + ".InsertMember", memberBean);
		} catch(DataAccessException e){
			
		}
		return cnt;
	}

	public MemberBean selectMemberById(String id) {
		MemberBean memberBean = null;
		memberBean = sqlSessionTemplate.selectOne(namespace + ".SelectMemberById", id);
		return memberBean;
	}

	public int insertMember(TrainerBean trainerBean) {
		int cnt = -1;
		try {
			cnt = sqlSessionTemplate.insert(namespace + ".InsertMember", trainerBean);
		} catch(DataAccessException e){
			
		}
		return cnt;
	}

	public int deleteMember(String id) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".DeleteMember", id);
		return cnt;
	}

	public String getName(String mid) {
		String mname = "";
		mname = sqlSessionTemplate.selectOne(namespace+".GetName",mid);
		return mname;
	}

	public int updateTrainerMember(MemberBean memberBean) {
		int cnt = sqlSessionTemplate.update(namespace + ".UpdateTrainerMember", memberBean);
		return cnt;
	}

	public int updatePassword(Map<String, String> map) {
		int cnt = sqlSessionTemplate.update(namespace + ".UpdatePassword", map);
		return cnt;
	}

	public MemberBean selectMemberByNameAndEmail(MemberBean memberBean) {
		MemberBean memberBeanId = null;
		memberBeanId = sqlSessionTemplate.selectOne(namespace + ".SelectMemberByNameAndEmail", memberBean);
		return memberBeanId;
	}

	public MemberBean selectMemberByIdAndEmail(MemberBean memberBean) {
		MemberBean memberBeanPw = null;
		memberBeanPw = sqlSessionTemplate.selectOne(namespace + ".SelectMemberByIdAndEmail", memberBean);
		return memberBeanPw;
	}
	
	
}
