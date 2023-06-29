package product.controller;



import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import product.model.ProductBean;
import product.model.ProductDao;

@Controller
public class ProductUpdateController {
	private final String command = "updateProduct.pd";
	private final String getPage = "forward:/productDetail.pd?pnum=";
	@Autowired
	ProductDao productDao;
	@RequestMapping(value = command)
	public String doAction(@ModelAttribute("prodBean") ProductBean productBean,
						   Model model,
						   HttpServletResponse response) {
		int cnt = productDao.updateProduct(productBean);
		System.out.println("update cnt:" + cnt);
		response.setContentType("text/html; charset=utf-8");
		if(cnt > 0) {
			try {
				response.getWriter().print("<script>alert('상품 수정됐습니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return getPage + productBean.getPnum();
	}
}
