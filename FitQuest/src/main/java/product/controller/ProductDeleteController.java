package product.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import product.model.ProductDao;

@Controller
public class ProductDeleteController {
	private final String command = "deleteProduct.pd";
	private final String getPage = "forward:/viewProductList.pd";
	@Autowired
	ProductDao productDao;
	
	@RequestMapping(value = command)
	public String doAction(@RequestParam("pnum") int pnum,
						   HttpServletResponse response) {
	    int cnt = productDao.deleteProduct(pnum);
		System.out.println("Cnt delete: " + cnt);
		response.setContentType("text/html; charset=utf-8");
		if(cnt > 0) {
			try {
				response.getWriter().print("<script>alert('상품 삭제됬습니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return getPage;
	}
}
