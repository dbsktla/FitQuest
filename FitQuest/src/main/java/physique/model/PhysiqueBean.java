package physique.model;

import org.springframework.web.multipart.MultipartFile;

public class PhysiqueBean {

	private int phnum;
	private String id;
	private double height;
	private double weight;
	private double bmi;
	private String phdate; // 측정일
	private double skeletalmuscle; // 골격근량
	private double bodyfatper; // 체지방률
	private int bmr; // 기초대사량
	private String phimage; //인바디 이미지
	private MultipartFile upload;
	
	public MultipartFile getUpload() {
		return upload;
	}

	public void setUpload(MultipartFile upload) {
		
		this.upload = upload;
		
		String fileName = upload.getOriginalFilename();
		this.phimage = fileName;
		
	}

	public String getPhimage() {
		return phimage;
	}

	public void setPhimage(String phimage) {
		this.phimage = phimage;
	}

	public int getPhnum() {
		return phnum;
	}

	public void setPhnum(int phnum) {
		this.phnum = phnum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public double getHeight() {
		return height;
	}

	public void setHeight(double height) {
		this.height = height;
	}

	public double getWeight() {
		return weight;
	}

	public void setWeight(double weight) {
		this.weight = weight;
	}

	public double getBmi() {
		return bmi;
	}

	public void setBmi(double bmi) {
		this.bmi = bmi;
	}

	public String getPhdate() {
		return phdate;
	}

	public void setPhdate(String phdate) {
		this.phdate = phdate;
	}

	public double getSkeletalmuscle() {
		return skeletalmuscle;
	}

	public void setSkeletalmuscle(double skeletalmuscle) {
		this.skeletalmuscle = skeletalmuscle;
	}

	public double getBodyfatper() {
		return bodyfatper;
	}

	public void setBodyfatper(double bodyfatper) {
		this.bodyfatper = bodyfatper;
	}

	public int getBmr() {
		return bmr;
	}

	public void setBmr(int bmr) {
		this.bmr = bmr;
	}

}
