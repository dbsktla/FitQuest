package order.model;

public class OrderBean {
	private int onum;
	private String id;
	private String date;
	public OrderBean() {
		super();
	}
	public OrderBean(int onum, String id, String date) {
		super();
		this.onum = onum;
		this.id = id;
		this.date = date;
	}
	public int getOnum() {
		return onum;
	}
	public void setOnum(int onum) {
		this.onum = onum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
}
