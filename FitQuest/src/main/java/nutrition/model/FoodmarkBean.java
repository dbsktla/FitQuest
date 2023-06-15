package nutrition.model;

public class FoodmarkBean {

	private int fknum;
	private String id;
	private String fname;
	private double fweight;
	private double calories;
	private double carbohydrate;
	private double protein;
	private double fat;
	private double sugar;
	private double sodium;

	public int getFknum() {
		return fknum;
	}

	public void setFknum(int fknum) {
		this.fknum = fknum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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
