package product.model;

import org.hibernate.validator.constraints.NotBlank;

public class ProductBean {
	private int pnum;
	private String id;
	@NotBlank(message = "가격 입력하세요")
	private int price;
	@NotBlank(message ="사용기간 입력하세요")
	private int months; 
	@NotBlank(message = "사용횟수 입력하세요")
	private int pcount;
	@NotBlank(message = "수업 참여 가능한 회원 갯수 입력하세요")
	private int people;
	@NotBlank(message = "개인/그룹 중 하나 선택하세요")
	private String ptype;
	@NotBlank(message = "수업 시간 길이 입력하세요")
	private int ptime;
	public ProductBean() {
		super();
	}
	public ProductBean(int pnum, String id, int price, int months, int pcount, int people, String ptype, int ptime) {
		super();
		this.pnum = pnum;
		this.id = id;
		this.price = price;
		this.months = months;
		this.pcount = pcount;
		this.people = people;
		this.ptype = ptype;
		this.ptime = ptime;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
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
	public int getMonths() {
		return months;
	}
	public void setMonths(int months) {
		this.months = months;
	}
	public int getPcount() {
		return pcount;
	}
	public void setPcount(int pcount) {
		this.pcount = pcount;
	}
	public int getPeople() {
		return people;
	}
	public void setPeople(int people) {
		this.people = people;
	}
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}
	public int getPtime() {
		return ptime;
	}
	public void setPtime(int ptime) {
		this.ptime = ptime;
	}
}
