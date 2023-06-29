package product.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import member.model.MemberBean;
import product.model.ProductBean;
import product.model.ProductDao;

@Controller
public class ProductInsertController {
	private final String command = "insertProduct.pd";
	private final String getPage = "insertProductForm";
	private final String gotoPage = "forward:/viewProductList.pd";
	@Autowired
	ProductDao productDao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction() {
		return getPage;
	}
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String doAction(ProductBean productBean,
			HttpServletResponse response,
			HttpSession session) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		boolean insertFlag = (Boolean)session.getAttribute("insertFlag");
		if(insertFlag == true) {
			productBean.setId(memberBean.getId());
			int cnt = productDao.insertProduct(productBean);
			session.setAttribute("insertFlag", false);
			response.setContentType("text/html; charset=utf-8");
			if(cnt > 0) {
				try {
					response.getWriter().print("<script>alert('상품 등록됐습니다.');</script>");
					response.getWriter().flush();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return gotoPage;
	}
}
