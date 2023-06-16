package admin.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AdminDao {
	private final String namespace = "admin.model.Admin";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<AdminReportBean> getReportBoardList(){
		List<AdminReportBean> reportBoardList = new ArrayList<AdminReportBean>();
		reportBoardList = sqlSessionTemplate.selectList(namespace + ".GetReportBoardList");
		return reportBoardList;
	}
	
	public List<AdminReportBean> getReportBCommnerList(){
		List<AdminReportBean> reportBcommentList = new ArrayList<AdminReportBean>();
		reportBcommentList = sqlSessionTemplate.selectList(namespace + ".GetReportBCommnerList");
		return reportBcommentList;
	}

	public List<AdminReportBean> getMainReportBoardList() {
		List<AdminReportBean> reportBoardList = new ArrayList<AdminReportBean>();
		reportBoardList = sqlSessionTemplate.selectList(namespace + ".GetMainReportBoardList");
		return reportBoardList;
	}
	
	public List<AdminReportBean> getMainReportBCommnerList(){
		List<AdminReportBean> reportBcommentList = new ArrayList<AdminReportBean>();
		reportBcommentList = sqlSessionTemplate.selectList(namespace + ".GetMainReportBCommnerList");
		return reportBcommentList;
	}
	
}
