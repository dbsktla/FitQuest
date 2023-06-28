package trainer.model;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

public class TrainerBean {
	private String id;
	private String mtype;
	private String name;
	
	@Pattern(regexp = "(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\\W)(?=\\S+$).{8,16}", message = "비밀번호 형식 맞게 작성해 주세요.")
	private String password;
	private String nickname;
	private String birth;
	
	@Pattern(regexp = "^[0-9]+$", message = "숫자만 입력 해주세요.")
	private String mphone;
	private String email;
	private String maddr1;
	private String maddr2;
	
	@NotBlank(message = "성별을 선택해 주세요.")
	private String gender;
	
	@NotBlank(message = "헬스장을 선택해 주세요.")
	private String gnum;
	
	@NotBlank(message = "운동 종류를 선택해 주세요.")
	private String activity;
	
	@NotBlank(message = "운동 목적을 선택해 주세요.")
	private String purpose;
	
	@NotBlank(message = "소개를 작성해 주세요.")
	private String intro;
	
	@NotBlank(message = "경력을 작성해 주세요.")
	private String exp;
	private String timage;
	
	private MultipartFile upload;
	
	private String eCheck;

	public String geteCheck() {
		return eCheck;
	}

	public void seteCheck(String eCheck) {
		this.eCheck = eCheck;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
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

	public String getGnum() {
		return gnum;
	}

	public void setGnum(String gnum) {
		this.gnum = gnum;
	}

	public String getActivity() {
		return activity;
	}

	public void setActivity(String activity) {
		this.activity = activity;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getExp() {
		return exp;
	}

	public void setExp(String exp) {
		this.exp = exp;
	}

	public String getTimage() {
		return timage;
	}

	public void setTimage(String timage) {
		this.timage = timage;
	}

	public MultipartFile getUpload() {
		return upload;
	}

	public void setUpload(MultipartFile upload) {
		this.upload = upload;
		String fileName = upload.getOriginalFilename();
		System.out.println("fileName : " + fileName);
		this.timage = fileName;
	}
	
	
	
}