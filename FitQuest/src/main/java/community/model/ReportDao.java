package community.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import admin.model.AdminReportBean;

@Component
public class ReportDao {
	private String namespace = "report.model.Report";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int insertReport(ReportBean reportBean) {
		int cnt = -1;
		try {
			cnt = sqlSessionTemplate.insert(namespace + ".InsertReport", reportBean);
		} catch(DataAccessException e){
			
		}
		return cnt;
	}
	
	public int updateReport(AdminReportBean adminReportBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".UpdateReport", adminReportBean);
		return cnt;
	}
}
