package product.controller;


import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import orderdetail.model.OrderDetailDao;
import product.model.ProductBean;
import product.model.ProductDao;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;

@Controller
public class ProductTrainerDetailController {
	private final String command = "productDetail.pd";
	private final String getPage = "productDetail";
	@Autowired
	OrderDetailDao orderDetailDao;
	@Autowired
	ProductDao productDao;
	@Autowired
	TrainerDao trainerDao;
	@RequestMapping(value = command)
	public String doAction(Model model,
						   @RequestParam("pnum") int pnum,
						   HttpServletResponse response,
						   HttpSession session) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo"); 
		response.setContentType("text/html; charset=utf-8");
		if(memberBean == null) {
			session.setAttribute("destination", "redirect:/productDetail.pd");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/login.mb";
		}
		ProductBean productBean = productDao.getProductByPnum(pnum);
		int orderCount = orderDetailDao.getOrderCountByPnum(pnum);
		TrainerBean trainerBean = trainerDao.getTrainer(memberBean.getId());
		model.addAttribute("trainerBean", trainerBean);
		model.addAttribute("productBean", productBean);
		model.addAttribute("orderCount", orderCount);
		return getPage;
	}
}
