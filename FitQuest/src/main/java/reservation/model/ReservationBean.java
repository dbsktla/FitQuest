package reservation.model;

import java.sql.Timestamp;

public class ReservationBean {
	private int rnum;
	private String id;
	private int onum;
	private int unum;
	private Timestamp rdate;
	private String rtime;
	
	public ReservationBean() {
		
	}
	public ReservationBean(int rnum, String id, int onum, int unum, Timestamp rdate, String rtime) {
		super();
		this.rnum = rnum;
		this.id = id;
		this.onum = onum;
		this.unum = unum;
		this.rdate = rdate;
		this.rtime = rtime;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public Timestamp getRdate() {
		return rdate;
	}
	public void setRdate(Timestamp rdate) {
		this.rdate = rdate;
	}
	public String getRtime() {
		return rtime;
	}
	public void setRtime(String rtime) {
		this.rtime = rtime;
	}
	
}
