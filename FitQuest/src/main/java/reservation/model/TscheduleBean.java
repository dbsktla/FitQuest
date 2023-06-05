package reservation.model;

import java.security.Timestamp;

import org.hibernate.validator.constraints.NotBlank;

public class TscheduleBean {
	private String tid;
	@NotBlank(message = "요일을 선택해 주세요")
	private String tsday;
	@NotBlank(message = "시간을 선택해 주세요")
	private String tstime;
	private Timestamp tsdate;
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getTsday() {
		return tsday;
	}
	public void setTsday(String tsday) {
		this.tsday = tsday;
	}
	public String getTstime() {
		return tstime;
	}
	public void setTstime(String tstime) {
		this.tstime = tstime;
	}
	public Timestamp getTsdate() {
		return tsdate;
	}
	public void setTsdate(Timestamp tsdate) {
		this.tsdate = tsdate;
	}
	public TscheduleBean(String tid, String tsday, String tstime, Timestamp tsdate) {
		super();
		this.tid = tid;
		this.tsday = tsday;
		this.tstime = tstime;
		this.tsdate = tsdate;
	}
	public TscheduleBean() {
		
	}
}
