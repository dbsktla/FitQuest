package review.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.ReviewPaging;

@Component
public class ReviewDao {
	private final String namespace = "review.model.Review";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<ReviewBean> getReviewListByTid(String id) {
		List<ReviewBean> rList = new ArrayList<ReviewBean>();
		rList = sqlSessionTemplate.selectList(namespace + ".GetReviewByTid", id);
		return rList;
	}
	public double getAverageReviewScore(String id) {
		double avgScore = sqlSessionTemplate.selectOne(namespace + ".GetAverageReview", id);
		return avgScore;
	}
	public String getHasReviewById(String tid) {
		String hasReview = sqlSessionTemplate.selectOne(namespace + ".GetHasReviewById", tid);
		return hasReview;
	}
	public void insertBaseValue(String id) {
		sqlSessionTemplate.insert(namespace + ".InsertBaseValue", id);
	}
	public int getReviewCount(Map<String, String> map) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".GetReviewCount", map);
		return cnt;
	}
	public List<ReviewBean> getReviewList(Map<String, String> map, ReviewPaging pageInfo) {
		List<ReviewBean> rList = new ArrayList<ReviewBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		rList = sqlSessionTemplate.selectList(namespace + ".GetReviewList", map, rowBounds);
		return rList;
	}
	public ReviewBean getReviewByRenum(int renum) {
		ReviewBean reviewBean = new ReviewBean();
		reviewBean = sqlSessionTemplate.selectOne(namespace + ".GetReviewByRenum", renum);
		return reviewBean;
	}
	public int insertReport(int renum) {
		int cnt = sqlSessionTemplate.update(namespace + ".InsertReport", renum);
		return cnt;
	}
	public int reviewCountCheck(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(namespace + ".ReviewCountCheck", map);
		return cnt;
	}
	public int insertReview(ReviewBean reviewBean) {
		int cnt = sqlSessionTemplate.insert(namespace + ".InsertReview", reviewBean);
		return cnt;
	}
}
