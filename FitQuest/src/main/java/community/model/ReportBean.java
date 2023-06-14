package community.model;

public class ReportBean {
	private int rpnum;
	private int bcnum;
	private int bnum;
	private String id;
	private String rtype;
	private String status;
	private String rcontent;
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public int getRpnum() {
		return rpnum;
	}
	public void setRpnum(int renum) {
		this.rpnum = renum;
	}
	public int getBcnum() {
		return bcnum;
	}
	public void setBcnum(int bcnum) {
		this.bcnum = bcnum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRtype() {
		return rtype;
	}
	public void setRtype(String rtype) {
		this.rtype = rtype;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRcontent() {
		return rcontent;
	}
	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}
	
	
}
