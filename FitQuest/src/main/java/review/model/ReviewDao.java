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
	
	public List<ReviewBean> getReviewListByTid(String id) { //트레이너 id입력 하면 해당 트레이너 모든 리뷰 가져옴.
		List<ReviewBean> rList = new ArrayList<ReviewBean>();
		rList = sqlSessionTemplate.selectList(namespace + ".GetReviewByTid", id);
		return rList;
	}
	public double getAverageReviewScore(String id) { //트레이너 평균 별점 가져옴
		double avgScore = sqlSessionTemplate.selectOne(namespace + ".GetAverageReview", id);
		return avgScore;
	}
	public String getHasReviewById(String tid) { //트래이너의 리뷰 있는 상태 가져옴
		String hasReview = sqlSessionTemplate.selectOne(namespace + ".GetHasReviewById", tid);
		return hasReview;
	}
	public void insertBaseValue(String id) { //트레이너 아이디에 초기 값 - 리뷰 없는 상태로 넣어준다.
		sqlSessionTemplate.insert(namespace + ".InsertBaseValue", id);
	}
	public int getReviewCount(Map<String, String> map) { //트레이너 리뷰 목록 페이징 위해 totalCount계산
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".GetReviewCount", map);
		return cnt;
	}
	public List<ReviewBean> getReviewList(Map<String, String> map, ReviewPaging pageInfo) { //트레이너 리뷰 조회 목록보기
		List<ReviewBean> rList = new ArrayList<ReviewBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		rList = sqlSessionTemplate.selectList(namespace + ".GetReviewList", map, rowBounds);
		return rList;
	}
	public ReviewBean getReviewByRenum(int renum) { //리뷰 빈 가져옴
		ReviewBean reviewBean = new ReviewBean();
		reviewBean = sqlSessionTemplate.selectOne(namespace + ".GetReviewByRenum", renum);
		return reviewBean;
	}
	public int insertReport(int renum) { //리뷰 신고 삽입
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
	public int getMyReviewCount(Map<String, String> map) { //회원의 리뷰 작성 수
		int cnt = sqlSessionTemplate.selectOne(namespace + ".GetMyReviewCount", map);
		return cnt;
	}
	public List<ReviewBean> getMyReviewList(Map<String, String> map, ReviewPaging pageInfo) {//회원의 리뷰 목록 가져옴
		List<ReviewBean> rList = new ArrayList<ReviewBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		rList = sqlSessionTemplate.selectList(namespace + ".GetMyReviewList", map, rowBounds);
		return rList;
	}
	public int deleteReview(int renum) { //리뷰삭제 시킴
		int cnt = sqlSessionTemplate.delete(namespace + ".DeleteReview", renum);
		return cnt;
	}
	public void deleteBaseValue(String id) { //초기 값을 삭제 해준다.
		sqlSessionTemplate.delete(namespace+ ".DeleteBaseValue", id);
		
	}
	public int getTrainerReviewCount(String tid) { //트레이너의 모든 리뷰 수 리턴. 
		int cnt = sqlSessionTemplate.selectOne(namespace + ".GetTrainerReviewCount", tid);
		return cnt;
	}
	public int updateReview(ReviewBean reviewBean) {
		int cnt = sqlSessionTemplate.update(namespace + ".UpdateReview", reviewBean);
		return cnt;
	}
	public int getAdminReviewCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(namespace + ".GetAdminCount", map);
		return cnt;
	}
	public List<ReviewBean> getReviewDeleteRequestList(Map<String, String> map, ReviewPaging pageInfo) {
		List<ReviewBean> rList = new ArrayList<ReviewBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		rList = sqlSessionTemplate.selectList(namespace+ ".DeleteRequestList", map, rowBounds);
		return rList;
	}
	public List<ReviewBean> getReviewReport() {
		List<ReviewBean> reportReviewList = new ArrayList<ReviewBean>();
		reportReviewList = sqlSessionTemplate.selectList(namespace + ".GetReviewReport");
		return reportReviewList;
	}
}
