package review.model;

public class ReviewBean {
	private int renum;
	private String mid;
	private int pnum;
	private String tid;
	private double rating;
	private String rtitle;
	private String rcontent;
	private String rdate;
	private String hasReview;
	public ReviewBean() {
		
	}
	public ReviewBean(int renum, String mid, int pnum, String tid, double rating, String rtitle, String rcontent,
			String rdate, String hasReview) {
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
}
