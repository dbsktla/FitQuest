package member.model;

import javax.validation.constraints.Pattern;

public class GymBean {
	private int gnum;
	private String gname;
	private String gaddr1;
	private String gaddr2;
	
	@Pattern(regexp = "^[0-9]+$", message = "숫자만 입력하세요.")
	private String gphone;
	
	public GymBean() {
		super();
	}
	public GymBean(int gnum, String gname, String gaddr1, String gaddr2, String gphone) {
		super();
		this.gnum = gnum;
		this.gname = gname;
		this.gaddr1 = gaddr1;
		this.gaddr2 = gaddr2;
		this.gphone = gphone;
	}
	
	public int getGnum() {
		return gnum;
	}
	public void setGnum(int gnum) {
		this.gnum = gnum;
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
	public String getGphone() {
		return gphone;
	}
	public void setGphone(String gphone) {
		this.gphone = gphone;
	}
	
	
}
