package reservation.model;




public class TscheduleBean {
	private String tid;
	
	private String tsday;
	
	private String tstime;
	
	private String tsdate;
	
	private String tstype;
	
	private int tspeople;
	
	
	//요일별 시간 임시변수들
	private String suntime;
	private String montime;
	private String tuetime;
	private String wedtime;
	private String thutime;
	private String fritime;
	private String sattime;
	
	public String getTstype() {
		return tstype;
	}
	public void setTstype(String tstype) {
		this.tstype = tstype;
	}
	public int getTspeople() {
		return tspeople;
	}
	public void setTspeople(int tspeople) {
		this.tspeople = tspeople;
	}
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
	public String getTsdate() {
		return tsdate;
	}
	public void setTsdate(String tsdate) {
		this.tsdate = tsdate;
	}
	public TscheduleBean() {
		
	}
	public TscheduleBean(String tid, String tsday, String tstime, String tsdate, String tstype, int tspeople) {
		super();
		this.tid = tid;
		this.tsday = tsday;
		this.tstime = tstime;
		this.tsdate = tsdate;
		this.tstype = tstype;
		this.tspeople = tspeople;
	}
	
	//임시변수들
	public String getSuntime() {
		return suntime;
	}
	public void setSuntime(String suntime) {
		this.suntime = suntime;
	}
	public String getMontime() {
		return montime;
	}
	public void setMontime(String montime) {
		this.montime = montime;
	}
	public String getTuetime() {
		return tuetime;
	}
	public void setTuetime(String tuetime) {
		this.tuetime = tuetime;
	}
	public String getWedtime() {
		return wedtime;
	}
	public void setWedtime(String wedtime) {
		this.wedtime = wedtime;
	}
	public String getThutime() {
		return thutime;
	}
	public void setThutime(String thutime) {
		this.thutime = thutime;
	}
	public String getFritime() {
		return fritime;
	}
	public void setFritime(String fritime) {
		this.fritime = fritime;
	}
	public String getSattime() {
		return sattime;
	}
	public void setSattime(String sattime) {
		this.sattime = sattime;
	}
}
