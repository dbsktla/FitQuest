package composite.model;

public class ReservationDetailBean {
	private String rdate;
	private String rtime;
	private String id;
	private String birth;
	private String mphone;
	private String email;
	private String name;
	private int people;
	
	public ReservationDetailBean() {
		
	}
	public ReservationDetailBean(String rdate, String rtime, String id, String birth, String mphone, String email,
			String name, int people) {
		super();
		this.rdate = rdate;
		this.rtime = rtime;
		this.id = id;
		this.birth = birth;
		this.mphone = mphone;
		this.email = email;
		this.name = name;
		this.people = people;
	}
	public int getPeople() {
		return people;
	}
	public void setPeople(int people) {
		this.people = people;
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getMphone() {
		return mphone;
	}
	public void setMphone(String mphone) {
		this.mphone = mphone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
