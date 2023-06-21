package complete.model;

public class CompleteBean {
	private int cpnum;
	private String tid;
	private String cpdate;
	private String cptime;
	private int cpeople;
	
	public int getCpnum() {
		return cpnum;
	}
	public void setCpnum(int cpnum) {
		this.cpnum = cpnum;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getCpdate() {
		return cpdate;
	}
	public void setCpdate(String cpdate) {
		this.cpdate = cpdate;
	}
	public String getCptime() {
		return cptime;
	}
	public void setCptime(String cptime) {
		this.cptime = cptime;
	}
	public int getCpeople() {
		return cpeople;
	}
	public void setCpeople(int cpeople) {
		this.cpeople = cpeople;
	}
	public CompleteBean(int cpnum, String tid, String cpdate, String cptime, int cpeople) {
		super();
		this.cpnum = cpnum;
		this.tid = tid;
		this.cpdate = cpdate;
		this.cptime = cptime;
		this.cpeople = cpeople;
	}
	public CompleteBean() {
		
	}
}
