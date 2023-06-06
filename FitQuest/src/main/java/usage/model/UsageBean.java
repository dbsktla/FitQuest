package usage.model;

public class UsageBean {
	private int unum;
	private int pnum;
	private int onum;
	private String tid;
	private String mid;
	private int usage;
	
	public UsageBean() {
		super();
	}
	public UsageBean(int unum, int pnum, int onum, String tid, String mid, int usage) {
		super();
		this.unum = unum;
		this.pnum = pnum;
		this.onum = onum;
		this.tid = tid;
		this.mid = mid;
		this.usage = usage;
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
	public int getOnum() {
		return onum;
	}
	public void setOnum(int onum) {
		this.onum = onum;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public int getUsage() {
		return usage;
	}
	public void setUsage(int usage) {
		this.usage = usage;
	}
}
