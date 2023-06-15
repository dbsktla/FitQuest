package question.model;

import org.hibernate.validator.constraints.NotBlank;

public class QcommentBean {
	private int qcnum;
	private int qnum;
	private String qcomment;
	private String qcdate;
	
	public String getQcdate() {
		return qcdate;
	}
	public void setQcdate(String qcdate) {
		this.qcdate = qcdate;
	}
	public int getQcnum() {
		return qcnum;
	}
	public void setQcnum(int qcnum) {
		this.qcnum = qcnum;
	}
	public int getQnum() {
		return qnum;
	}
	public void setQnum(int qnum) {
		this.qnum = qnum;
	}
	public String getQcomment() {
		return qcomment;
	}
	public void setQcomment(String qcomment) {
		this.qcomment = qcomment;
	}
	
	
}
