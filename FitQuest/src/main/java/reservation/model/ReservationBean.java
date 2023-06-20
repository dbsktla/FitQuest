package reservation.model;

public class ReservationBean {
	private int rnum;
	private String mid;
	private String tid;
	private String mname;
	private String tname;
	private int onum;
	private int unum;
	private int people;
	private String rdate;
	private String rtime;
	private String rstate;
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
	public int getPeople() {
		return people;
	}
	public void setPeople(int people) {
		this.people = people;
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
	public ReservationBean(int rnum, String mid, String tid, String mname, String tname, int onum, int unum, int people,
			String rdate, String rtime, String rstate) {
		super();
		this.rnum = rnum;
		this.mid = mid;
		this.tid = tid;
		this.mname = mname;
		this.tname = tname;
		this.onum = onum;
		this.unum = unum;
		this.people = people;
		this.rdate = rdate;
		this.rtime = rtime;
		this.rstate = rstate;
	}
	public ReservationBean() {
		
	}
}
