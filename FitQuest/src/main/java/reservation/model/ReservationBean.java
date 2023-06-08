package reservation.model;

import java.sql.Date;

public class ReservationBean {
	private int rnum;
	private String mid;
	private String tid;
	private int onum;
	private int unum;
	private Date rdate;
	private String rtime;
	private String rstate;
	
	public ReservationBean() {
		
	}

	public ReservationBean(int rnum, String mid, String tid, int onum, int unum, Date rdate, String rtime,
			String rstate) {
		super();
		this.rnum = rnum;
		this.mid = mid;
		this.tid = tid;
		this.onum = onum;
		this.unum = unum;
		this.rdate = rdate;
		this.rtime = rtime;
		this.rstate = rstate;
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

	public Date getRdate() {
		return rdate;
	}

	public void setRdate(Date rdate) {
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
	
	
}
