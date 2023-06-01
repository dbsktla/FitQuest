package product.model;

public class MyTrainerList {
	private String id;
	private String gnum;
	private String activity;
	private String purpose;
	private String intro;
	private String exp;
	private String timage;
	private String rating;
	private String maddr1;
	private String name;
	
	public MyTrainerList() {
		super();
	}
	public MyTrainerList(String id, String gnum, String activity, String purpose, String intro, String exp,
			String timage, String rating, String maddr1) {
		super();
		this.id = id;
		this.gnum = gnum;
		this.activity = activity;
		this.purpose = purpose;
		this.intro = intro;
		this.exp = exp;
		this.timage = timage;
		this.rating = rating;
		this.maddr1 = maddr1;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGnum() {
		return gnum;
	}
	public void setGnum(String gnum) {
		this.gnum = gnum;
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
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getExp() {
		return exp;
	}
	public void setExp(String exp) {
		this.exp = exp;
	}
	public String getTimage() {
		return timage;
	}
	public void setTimage(String timage) {
		this.timage = timage;
	}
	public String getRating() {
		return rating;
	}
	public void setRating(String rating) {
		this.rating = rating;
	}
	public String getMaddr1() {
		return maddr1;
	}
	public void setMaddr1(String maddr1) {
		this.maddr1 = maddr1;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
