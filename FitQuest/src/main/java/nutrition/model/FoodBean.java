package nutrition.model;

import org.springframework.web.multipart.MultipartFile;

public class FoodBean {

	private int fnum;
	private int nnum;
	private int mnum;
	private String fname;
	private double fweight;
	private double calories;
	private double carbohydrate;
	private double protein;
	private double fat;
	private double sugar;
	private double sodium;

	private String id;
	private String nudate;
	private String mealtype;
	private String fimage;

	public String getFimage() {
		return fimage;
	}

	public void setFimage(String fimage) {
		this.fimage = fimage;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNudate() {
		return nudate;
	}

	public void setNudate(String nudate) {
		this.nudate = nudate;
	}

	public String getMealtype() {
		return mealtype;
	}

	public void setMealtype(String mealtype) {
		this.mealtype = mealtype;
	}

	public int getFnum() {
		return fnum;
	}

	public void setFnum(int fnum) {
		this.fnum = fnum;
	}

	public int getNnum() {
		return nnum;
	}

	public void setNnum(int nnum) {
		this.nnum = nnum;
	}

	public int getMnum() {
		return mnum;
	}

	public void setMnum(int mnum) {
		this.mnum = mnum;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public double getFweight() {
		return fweight;
	}

	public void setFweight(double fweight) {
		this.fweight = fweight;
	}

	public double getCalories() {
		return calories;
	}

	public void setCalories(double calories) {
		this.calories = calories;
	}

	public double getCarbohydrate() {
		return carbohydrate;
	}

	public void setCarbohydrate(double carbohydrate) {
		this.carbohydrate = carbohydrate;
	}

	public double getProtein() {
		return protein;
	}

	public void setProtein(double protein) {
		this.protein = protein;
	}

	public double getFat() {
		return fat;
	}

	public void setFat(double fat) {
		this.fat = fat;
	}

	public double getSugar() {
		return sugar;
	}

	public void setSugar(double sugar) {
		this.sugar = sugar;
	}

	public double getSodium() {
		return sodium;
	}

	public void setSodium(double sodium) {
		this.sodium = sodium;
	}

}
