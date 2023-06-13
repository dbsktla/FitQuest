package community.model;


import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

public class BoardBean {
	private int bnum;
	private String id;
	private String name;
	private String btype;
	
	@NotBlank(message = "카테고리를 선택해 주세요.")
	private String bcategory;
	
	@NotBlank(message = "제목을 작성해 주세요.")
	private String bsubject;
	private String bregdate;
	private int breadcount;
	private int bref;
	private int brestep;
	private int brelevel;
	
	@NotBlank(message = "내용을 작성해 주세요.")
	private String bcontent;
	private String bimage;
	private String bimageOld;
	
	public String getBimageOld() {
		return bimageOld;
	}

	public void setBimageOld(String bimageOld) {
		this.bimageOld = bimageOld;
	}

	private MultipartFile upload;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getBnum() {
		return bnum;
	}

	public void setBnum(int bnum) {
		this.bnum = bnum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getBtype() {
		return btype;
	}

	public void setBtype(String btype) {
		this.btype = btype;
	}

	public String getBcategory() {
		return bcategory;
	}

	public void setBcategory(String bcategory) {
		this.bcategory = bcategory;
	}

	public String getBsubject() {
		return bsubject;
	}

	public void setBsubject(String bsubject) {
		this.bsubject = bsubject;
	}

	public String getBregdate() {
		return bregdate;
	}

	public void setBregdate(String bregdate) {
		this.bregdate = bregdate;
	}

	public int getBreadcount() {
		return breadcount;
	}

	public void setBreadcount(int breadcount) {
		this.breadcount = breadcount;
	}

	public int getBref() {
		return bref;
	}

	public void setBref(int bref) {
		this.bref = bref;
	}

	public int getBrestep() {
		return brestep;
	}

	public void setBrestep(int brestep) {
		this.brestep = brestep;
	}

	public int getBrelevel() {
		return brelevel;
	}

	public void setBrelevel(int brelevel) {
		this.brelevel = brelevel;
	}

	public String getBcontent() {
		return bcontent;
	}

	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}

	public String getBimage() {
		return bimage;
	}

	public void setBimage(String bimage) {
		this.bimage = bimage;
	}

	public MultipartFile getUpload() {
		return upload;
	}

	public void setUpload(MultipartFile upload) {
		this.upload = upload;
		String fileName = upload.getOriginalFilename();
		System.out.println("fileName : " + fileName);
		this.bimage = fileName;
	}
	
	
}
