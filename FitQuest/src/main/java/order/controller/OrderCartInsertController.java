package order.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import gym.model.GymBean;
import member.model.MemberBean;
import product.model.MyCartList;
import product.model.MyShoppingBean;
import product.model.ProductBean;
import product.model.ProductDao;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;
import usage.model.UsageBean;
import usage.model.UsageDao;

@Controller
public class OrderCartInsertController {
	private final String command = "cartInsert.od";
	private final String getPage = "redirect:/cartList.od";
	@Autowired 
	UsageDao usageDao;
	@Autowired
	ProductDao productDao;
	@Autowired
	TrainerDao trainerDao;
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(@RequestParam("pnum") int pnum,
			@RequestParam("id") String tid,
			Model model,
			HttpSession session,
			HttpServletResponse response) throws IOException {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		boolean flag1 = (Boolean)session.getAttribute("flag1");
		MyCartList cartList = (MyCartList)session.getAttribute("cartList");
		response.setContentType("text/html; charset=utf-8");
		if(flag1 == true) {
			if(memberBean == null) { // 로그인 정보 없을 때
				session.setAttribute("destination", "redirect:/cartInsert.od?pnum=" + pnum + "&id=" + tid);
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
				return "forward:/login.mb";
			} else { //로그인된 상태.
				if(memberBean.getMtype().equals("generic")) { //일반 회원만 장바구니 추가 가능.
					model.addAttribute("memberBean", memberBean);
					if(cartList == null) { //카트 생성된거 없으면 생성 시킴.
						cartList = new MyCartList();
					}
					Map<String, String> map = new HashMap<String, String>(); //회원 아이디, 트레이너 아이디를 담을 맵.
					map.put("tid", tid);
					map.put("mid", memberBean.getId());
					ProductBean productBean = productDao.getProductByPnum(pnum); //추가하려하는 하는 상품 정보
					
					List<UsageBean> uList = usageDao.getAvailableUsageListByMid(memberBean.getId()); //현재 회원이 사용 가능한 모든 상품 가져옴.
					for(UsageBean uBean : uList) {
						ProductBean uproductBean = productDao.getProductByPnum(uBean.getPnum()); //각 사용권의 상품 정보 가져오기
						if(productBean.getPeople() == uproductBean.getPeople() && uproductBean.getId().equals(productBean.getId())) { 
							//조건 : 상품의 인원 갯수가 같고, 트레이너 아이디도 같으면 구매 불가능 - 어차피 상품 등록시 개인 수업이면 1으로 넣을수 밖에 없음.
							//그룹이라고 해도 인원수 구매 가능.
							try { 
								response.getWriter().print("<script>alert('이미 해당 트레이너의 " + productBean.getPtype() + " (" +productBean.getPeople() + "명) 회원권이 있어서 구매 불가능합니다.');</script>");
								response.getWriter().flush();
								return "forward:/trainerList.pd";
							} catch (IOException e) {
								e.printStackTrace();
							}
						}
					}
					List<Integer> cartPnumList = cartList.getOrderList();
					for(int x : cartPnumList) { //현재 장바구니에 있는 인원 맞는 회원권이 있는지 확인.
						ProductBean cartProductBean = productDao.getProductByPnum(x);
						if(productBean.getPeople() == cartProductBean.getPeople() && productBean.getId().equals(cartProductBean.getId())){
							try { 
								response.getWriter().print("<script>alert('이미 해당 트레이너의 " + productBean.getPtype() + " (" +productBean.getPeople() + "명) 회원권이 장마구니에 있어서 구매 불가능합니다.');</script>");
								response.getWriter().flush();
								return "forward:/trainerList.pd";
							} catch (IOException e) {
								e.printStackTrace();
							}
						}
							
					}
					//for문 실행 지나면 구매 조건에 맞다는 뜻. 장바구니에 추가하기.
					cartList.addOrder(pnum);
					
				} else {
					response.getWriter().print("<script>alert('일반 회원만 구매 가능합니다.');</script>");
					response.getWriter().flush();
					return "forward:/trainerList.pd";
				}

			}
		}
		session.setAttribute("cartCount", cartList.getOrderList().size());
		session.setAttribute("cartList", cartList);
		return getPage;	
	}
}