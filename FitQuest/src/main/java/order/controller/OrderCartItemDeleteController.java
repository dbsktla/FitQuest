package order.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import product.model.MyCartList;

@Controller
public class OrderCartItemDeleteController {
	private final String command = "cartDelete.od";
	private final String getPage = "redirect:/cartList.od";
	
	@RequestMapping(value = command)
	public String doAction(@RequestParam("pnum") int pnum,
						   HttpSession session) {
		MyCartList cartList = (MyCartList)session.getAttribute("cartList");
		cartList.removeOrder((Integer)pnum);
		return getPage;
	}
}
