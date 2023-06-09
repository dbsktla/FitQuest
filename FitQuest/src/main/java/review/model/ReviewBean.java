package review.model;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

public class ReviewBean {
	private int renum;
	private String mid;
	private int pnum;
	private String tid;
	@NotNull(message = "별점 선택하세요")
	private double rating;
	@NotBlank(message = "제목 입력하세요")
	private String rtitle;
	@NotBlank(message = "리뷰 내용 입력하세요")
	private String rcontent;
	private String rdate;
	private String hasReview;
	private String report;
	public ReviewBean() {
		
	}
	public ReviewBean(int renum, String mid, int pnum, String tid, double rating, String rtitle, String rcontent,
			String rdate, String hasReview, String report) {
		super();
		this.renum = renum;
		this.mid = mid;
		this.pnum = pnum;
		this.tid = tid;
		this.rating = rating;
		this.rtitle = rtitle;
		this.rcontent = rcontent;
		this.rdate = rdate;
		this.hasReview = hasReview;
		this.report = report;
	}
	public int getRenum() {
		return renum;
	}
	public void setRenum(int renum) {
		this.renum = renum;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public double getRating() {
		return rating;
	}
	public void setRating(double rating) {
		this.rating = rating;
	}
	public String getRtitle() {
		return rtitle;
	}
	public void setRtitle(String rtitle) {
		this.rtitle = rtitle;
	}
	public String getRcontent() {
		return rcontent;
	}
	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	public String getHasReview() {
		return hasReview;
	}
	public void setHasReview(String hasReview) {
		this.hasReview = hasReview;
	}
	public String getReport() {
		return report;
	}
	public void setReport(String report) {
		this.report = report;
	}
	
}
