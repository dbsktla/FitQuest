package member.model;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;

public class MemberBean {
	private String id;
	private String mtype;
	private String name;
	
	@Pattern(regexp = "(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\\W)(?=\\S+$).{8,16}", message = "��й�ȣ ���� �°� �ۼ��� �ּ���.")
	private String password;
	private String nickname;
	private String birth;
	
	@Pattern(regexp = "^[0-9]+$", message = "���ڸ� �Է��ϼ���.")
	private String mphone;
	private String email;
	private String maddr1; 
	private String maddr2;
	
	@NotBlank(message = "성별을 선택해 주세요.")
	private String gender;
	
	public MemberBean() {
			
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public MemberBean(String id, String mtype, String name, String password, String nickname, String birth, String mphone,
			String email, String maddr1, String maddr2) {
		this.id = id;
		this.mtype = mtype;
		this.name = name;
		this.password = password;
		this.nickname = nickname;
		this.birth = birth;
		this.mphone = mphone;
		this.email = email;
		this.maddr1 = maddr1;
		this.maddr2 = maddr2;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMtype() {
		return mtype;
	}
	public void setMtype(String mtype) {
		this.mtype = mtype;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
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
	public String getMaddr1() {
		return maddr1;
	}
	public void setMaddr1(String maddr1) {
		this.maddr1 = maddr1;
	}
	public String getMaddr2() {
		return maddr2;
	}
	public void setMaddr2(String maddr2) {
		this.maddr2 = maddr2;
	}
}