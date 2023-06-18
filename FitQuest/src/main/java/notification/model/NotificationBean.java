package notification.model;

public class NotificationBean {
	private int nonum;
	private String recId;
	private String sendId;
	private String recName;
	private String sendName;
	private String request;
	private String notifContent;
	private String notifDate;
	private String notifRead;
	
	public NotificationBean() {
		super();
	}
	public NotificationBean(int nonum, String recId, String sendId, String recName, String sendName, String request,
			String notifContent, String notifDate, String notifRead) {
		super();
		this.nonum = nonum;
		this.recId = recId;
		this.sendId = sendId;
		this.recName = recName;
		this.sendName = sendName;
		this.request = request;
		this.notifContent = notifContent;
		this.notifDate = notifDate;
		this.notifRead = notifRead;
	}
	public int getNonum() {
		return nonum;
	}
	public void setNonum(int nonum) {
		this.nonum = nonum;
	}
	public String getRecId() {
		return recId;
	}
	public void setRecId(String recId) {
		this.recId = recId;
	}
	public String getSendId() {
		return sendId;
	}
	public void setSendId(String sendId) {
		this.sendId = sendId;
	}
	public String getRecName() {
		return recName;
	}
	public void setRecName(String recName) {
		this.recName = recName;
	}
	public String getSendName() {
		return sendName;
	}
	public void setSendName(String sendName) {
		this.sendName = sendName;
	}
	public String getRequest() {
		return request;
	}
	public void setRequest(String request) {
		this.request = request;
	}
	public String getNotifContent() {
		return notifContent;
	}
	public void setNotifContent(String notifContent) {
		this.notifContent = notifContent;
	}
	public String getNotifDate() {
		return notifDate;
	}
	public void setNotifDate(String notifDate) {
		this.notifDate = notifDate;
	}
	public String getNotifRead() {
		return notifRead;
	}
	public void setNotifRead(String notifRead) {
		this.notifRead = notifRead;
	}
	
}
