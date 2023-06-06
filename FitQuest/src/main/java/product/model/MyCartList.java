package product.model;

import java.util.ArrayList;
import java.util.List;

public class MyCartList {
	private List<Integer> cartList = null;
	public MyCartList() {
		cartList = new ArrayList<Integer>();
	}
	public void addOrder(int num) {
		cartList.add(num);
	}
	public List<Integer> getOrderList(){
		return cartList;
	}
	public void removeOrder(int num) {
		cartList.remove((Integer)num);
	}
}
