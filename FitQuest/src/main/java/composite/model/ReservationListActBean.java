package composite.model;

public class ReservationListActBean {
	private int rnum;
	private String mid;
	private String tid;
	private String mname;
	private String tname;
	private int onum;
	private int unum;
	private String rdate;
	private String rtime;
	private String rstate;
	private String activity;
	public ReservationListActBean(int rnum, String mid, String tid, String mname, String tname, int onum, int unum,
			String rdate, String rtime, String rstate, String activity) {
		super();
		this.rnum = rnum;
		this.mid = mid;
		this.tid = tid;
		this.mname = mname;
		this.tname = tname;
		this.onum = onum;
		this.unum = unum;
		this.rdate = rdate;
		this.rtime = rtime;
		this.rstate = rstate;
		this.activity = activity;
	}
	public ReservationListActBean() {
		
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public int getOnum() {
		return onum;
	}
	public void setOnum(int onum) {
		this.onum = onum;
	}
	public int getUnum() {
		return unum;
	}
	public void setUnum(int unum) {
		this.unum = unum;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	public String getRtime() {
		return rtime;
	}
	public void setRtime(String rtime) {
		this.rtime = rtime;
	}
	public String getRstate() {
		return rstate;
	}
	public void setRstate(String rstate) {
		this.rstate = rstate;
	}
	public String getActivity() {
		return activity;
	}
	public void setActivity(String activity) {
		this.activity = activity;
	}
	
}
