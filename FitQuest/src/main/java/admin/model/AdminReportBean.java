package admin.model;

public class AdminReportBean {
	private int rpnum;
	private int bcnum;
	private int bnum;
	private String id;
	private String rtype;
	private String status;
	private String rcontent;
	private String name;
	private String bsubject;
	private String ccontent;
	private String btype;
	
	
	public String getBtype() {
		return btype;
	}
	public void setBtype(String btype) {
		this.btype = btype;
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
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBsubject() {
		return bsubject;
	}
	public void setBsubject(String bsubject) {
		this.bsubject = bsubject;
	}
	public String getCcontent() {
		return ccontent;
	}
	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
	}
}
