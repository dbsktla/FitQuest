package composite.model;

public class MyUsageBean {
	private int unum; //사용권 번호
	private int pnum; //상품 번호
	private int months; //사용권 사용기간
	private int usage; //사용권 남은 횟수
	private String gname; //헬스장 명 
	private String activity; //운동 종류
	private String name; //트레이너 이름.
	private String ptype; //개인/그룹 수업
	private String timage; //트레이너 
	private String tid; //트레이너 id
	public MyUsageBean() {
		super();
	}
	public MyUsageBean(int unum, int pnum, int months, int usage, String gname, String activity, String name,
			String ptype, String timage, String tid) {
		super();
		this.unum = unum;
		this.pnum = pnum;
		this.months = months;
		this.usage = usage;
		this.gname = gname;
		this.activity = activity;
		this.name = name;
		this.ptype = ptype;
		this.timage = timage;
		this.tid = tid;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getTimage() {
		return timage;
	}
	public void setTimage(String timage) {
		this.timage = timage;
	}
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}
	public int getUnum() {
		return unum;
	}
	public void setUnum(int unum) {
		this.unum = unum;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public int getMonths() {
		return months;
	}
	public void setMonths(int months) {
		this.months = months;
	}
	public int getUsage() {
		return usage;
	}
	public void setUsage(int usage) {
		this.usage = usage;
	}
	public String getGname() {
		return gname;
	}
	public void setGname(String gname) {
		this.gname = gname;
	}
	public String getActivity() {
		return activity;
	}
	public void setActivity(String activity) {
		this.activity = activity;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
