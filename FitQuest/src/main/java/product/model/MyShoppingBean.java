package product.model;

public class MyShoppingBean {
	//db - trainer
	private String tid; //트레이너 아이디.
	private String tname; //트레이너 이름 Member DB
	private String activity;
	private String purpose;
	private String timage;
	//db - gym
	private String gname; //헬스장 이름
	private String gaddr1;
	private String gaddr2;
	//db - product
	private int pnum;
	private int price;
	private int months;
	private int pcount;
	private String ptype;
	private int ptime;
	private int people;
	//db - review
	private double rating;
	private String hasReview;
	public MyShoppingBean() {
		super();
	}
	
	public MyShoppingBean(String tid, String tname, String activity, String purpose, String timage, String gname,
			String gaddr1, String gaddr2, int pnum, int price, int months, int pcount, String ptype, int ptime,
			int people, double rating) {
		super();
		this.tid = tid;
		this.tname = tname;
		this.activity = activity;
		this.purpose = purpose;
		this.timage = timage;
		this.gname = gname;
		this.gaddr1 = gaddr1;
		this.gaddr2 = gaddr2;
		this.pnum = pnum;
		this.price = price;
		this.months = months;
		this.pcount = pcount;
		this.ptype = ptype;
		this.ptime = ptime;
		this.people = people;
		this.rating = rating;
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
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public String getActivity() {
		return activity;
	}
	public void setActivity(String activity) {
		this.activity = activity;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public String getTimage() {
		return timage;
	}
	public void setTimage(String timage) {
		this.timage = timage;
	}
	public String getGname() {
		return gname;
	}
	public void setGname(String gname) {
		this.gname = gname;
	}
	public String getGaddr1() {
		return gaddr1;
	}
	public void setGaddr1(String gaddr1) {
		this.gaddr1 = gaddr1;
	}
	public String getGaddr2() {
		return gaddr2;
	}
	public void setGaddr2(String gaddr2) {
		this.gaddr2 = gaddr2;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getMonths() {
		return months;
	}
	public void setMonths(int months) {
		this.months = months;
	}
	public int getPcount() {
		return pcount;
	}
	public void setPcount(int pcount) {
		this.pcount = pcount;
	}
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}
	public int getPtime() {
		return ptime;
	}
	public void setPtime(int ptime) {
		this.ptime = ptime;
	}
	public int getPeople() {
		return people;
	}
	public void setPeople(int people) {
		this.people = people;
	}
	public double getRating() {
		return rating;
	}
	public void setRating(double rating) {
		this.rating = rating;
	}

	public String getHasReview() {
		return hasReview;
	}

	public void setHasReview(String hasReview) {
		this.hasReview = hasReview;
	}
	
}
