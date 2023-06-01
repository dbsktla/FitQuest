package health.model;

import org.hibernate.validator.constraints.NotBlank;

public class HealthDateBean {

	private int hnum;
	private String id;
	@NotBlank(message = "운동 날짜 필수 입력")
	private String hdate;
	private String playtime;

	public String getPlaytime() {
		return playtime;
	}

	public void setPlaytime(String playtime) {
		this.playtime = playtime;
	}

	public int getHnum() {
		return hnum;
	}

	public void setHnum(int hnum) {
		this.hnum = hnum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getHdate() {
		return hdate;
	}

	public void setHdate(String hdate) {
		this.hdate = hdate;
	}

}
