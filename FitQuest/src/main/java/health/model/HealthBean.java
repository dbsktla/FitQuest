package health.model;


import java.sql.Timestamp;

import org.hibernate.validator.constraints.NotBlank;

public class HealthBean {

	private int hnum;
	@NotBlank(message = "운동명 필수 작성")
	private String hname;
	private String starttime;
	private String endtime;
	private int hcount;
	private int hset;

	public int getHnum() {
		return hnum;
	}

	public void setHnum(int hnum) {
		this.hnum = hnum;
	}

	public String getHname() {
		return hname;
	}

	public void setHname(String hname) {
		this.hname = hname;
	}

	public String getStarttime() {
		return starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public int getHcount() {
		return hcount;
	}

	public void setHcount(int hcount) {
		this.hcount = hcount;
	}

	public int getHset() {
		return hset;
	}

	public void setHset(int hset) {
		this.hset = hset;
	}

}
