package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class OrderClearCartController {
	public final String command = "clearCart.od";
	
	@RequestMapping(value = command)
	public String doAction(HttpServletRequest request,
						   HttpSession session) {
		//장바구니 비워줌
		session.setAttribute("cartList", null);
		session.setAttribute("cartCount", null);
		if (request.getHeader("Referer") != null) {
			return "redirect:" + request.getHeader("Referer"); //전페이지로 이동 시킨.
		} else {
			return "redirect:/main.go";
		}
	}
}
