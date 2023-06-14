package composite.model;

public class MyOrderBean {
	private int orderCount;
	private int totalPrice; 
	private String odate;
	private String onum;
	
	public MyOrderBean() {
		super();
	}
	public MyOrderBean(int orderCount, int totalPrice, String odate, String onum) {
		super();
		this.orderCount = orderCount;
		this.totalPrice = totalPrice;
		this.odate = odate;
		this.onum = onum;
	}
	public int getOrderCount() {
		return orderCount;
	}
	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getOdate() {
		return odate;
	}
	public void setOdate(String odate) {
		this.odate = odate;
	}
	public String getOnum() {
		return onum;
	}
	public void setOnum(String onum) {
		this.onum = onum;
	}
	
	
}
