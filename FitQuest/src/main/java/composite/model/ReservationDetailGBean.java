package composite.model;

public class ReservationDetailGBean {
	private String name;
	private String rdate;
	private String rtime;
	private String mphone;
	private String gname;
	private String gaddr1;
	private String gaddr2;
	private String gphone;
	private int people;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	public String getRtime() {
		return rtime;
	}
	public void setRtime(String rtime) {
		this.rtime = rtime;
	}
	public String getMphone() {
		return mphone;
	}
	public void setMphone(String mphone) {
		this.mphone = mphone;
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
	public int getPeople() {
		return people;
	}
	public void setPeople(int people) {
		this.people = people;
	}
	public ReservationDetailGBean() {
		
	}
	public ReservationDetailGBean(String name, String rdate, String rtime, String mphone, String gname, String gaddr1,
			String gaddr2, String gphone, int people) {
		super();
		this.name = name;
		this.rdate = rdate;
		this.rtime = rtime;
		this.mphone = mphone;
		this.gname = gname;
		this.gaddr1 = gaddr1;
		this.gaddr2 = gaddr2;
		this.gphone = gphone;
		this.people = people;
	}
	
}
