package nutrition.model;

import org.springframework.web.multipart.MultipartFile;

public class MealBean {
	
	private int mnum;
	private int nnum;
	private String fimage;
	private String mealtype;
	private MultipartFile upload;
	private String upload2;
	
	public MultipartFile getUpload() {
		return upload;
	}

	public void setUpload(MultipartFile upload) {
		this.upload = upload;
		String fileName = upload.getOriginalFilename();
		
		System.out.println("fileName : " + fileName);
		
		this.fimage = fileName;
	}

	public String getUpload2() {
		return upload2;
	}

	public void setUpload2(String upload2) {
		this.upload2 = upload2;
	}
	
	public int getMnum() {
		return mnum;
	}
	public void setMnum(int mnum) {
		this.mnum = mnum;
	}
	public int getNnum() {
		return nnum;
	}
	public void setNnum(int nnum) {
		this.nnum = nnum;
	}
	public String getFimage() {
		return fimage;
	}
	public void setFimage(String fimage) {
		this.fimage = fimage;
	}
	public String getMealtype() {
		return mealtype;
	}
	public void setMealtype(String mealtype) {
		this.mealtype = mealtype;
	}

}
