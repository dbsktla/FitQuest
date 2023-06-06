package review.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

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
}
