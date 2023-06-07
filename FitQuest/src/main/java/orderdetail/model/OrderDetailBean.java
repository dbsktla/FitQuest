package orderdetail.model;

public class OrderDetailBean {
	private int odnum;
	private int pnum;
	private int onum;
	public OrderDetailBean() {
		super();
	}
	public OrderDetailBean(int odnum, int pnum, int onum) {
		super();
		this.odnum = odnum;
		this.pnum = pnum;
		this.onum = onum;
	}
	public int getOdnum() {
		return odnum;
	}
	public void setOdnum(int odnum) {
		this.odnum = odnum;
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
	
	
}
