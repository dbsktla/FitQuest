package composite.model;

public class SalesBean {
	private int pnum;
	private String odate;
	private String id;
	private int price;
	public SalesBean(int pnum, String odate, String id, int price) {
		super();
		this.pnum = pnum;
		this.odate = odate;
		this.id = id;
		this.price = price;
	}
	public SalesBean() {
		super();
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public String getOdate() {
		return odate;
	}
	public void setOdate(String odate) {
		this.odate = odate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
}
