package question.model;

import org.hibernate.validator.constraints.NotBlank;

public class TquestionBean {

	private int tqnum;
	private String id;
	private String tqemail;
	private String tqdate;
	private String tqsubject;
	private String tqcontent;
	private String tqanswer;

	public int getTqnum() {
		return tqnum;
	}

	public void setTqnum(int tqnum) {
		this.tqnum = tqnum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTqemail() {
		return tqemail;
	}

	public void setTqemail(String tqemail) {
		this.tqemail = tqemail;
	}

	public String getTqdate() {
		return tqdate;
	}

	public void setTqdate(String tqdate) {
		this.tqdate = tqdate;
	}

	public String getTqsubject() {
		return tqsubject;
	}

	public void setTqsubject(String tqsubject) {
		this.tqsubject = tqsubject;
	}

	public String getTqcontent() {
		return tqcontent;
	}

	public void setTqcontent(String tqcontent) {
		this.tqcontent = tqcontent;
	}

	public String getTqanswer() {
		return tqanswer;
	}

	public void setTqanswer(String tqanswer) {
		this.tqanswer = tqanswer;
	}

}
