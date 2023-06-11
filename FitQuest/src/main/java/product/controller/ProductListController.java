package product.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import member.model.MemberBean;
import product.model.ProductBean;
import product.model.ProductDao;

@Controller
public class ProductListController {
	private final String command = "viewProductList.pd";
	private final String getPage = "productList";
	
	@Autowired
	ProductDao productDao;
	@RequestMapping(value = command)
	public String doAction(Model model,
						   HttpSession session) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		List<ProductBean> pList = productDao.getProductListById(memberBean.getId());
		model.addAttribute("pList", pList);
		return getPage;
	}
	
}
