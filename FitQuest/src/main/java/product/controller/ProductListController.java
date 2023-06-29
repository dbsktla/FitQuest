package product.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
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
	private final String getPage = "myProductList";
	
	@Autowired
	ProductDao productDao;
	@RequestMapping(value = command)
	public String doAction(Model model,
						   HttpSession session,
						   HttpServletResponse response) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		session.setAttribute("menubar", "myProductMain");
		session.setAttribute("topmenu", "trainerMember");
		response.setContentType("text/html; charset=utf-8");
		if(memberBean == null) {
			session.setAttribute("destination", "redirect:/trainerDetail.mb");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/login.mb";
		} else if(!memberBean.getMtype().equals("trainer")){
			try {
				response.getWriter().print("<script>alert('비정상적인 접근입니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/main.go";
		}
		List<ProductBean> pList = productDao.getProductListById(memberBean.getId());
		model.addAttribute("pList", pList);
		return getPage;
	}
	
}
