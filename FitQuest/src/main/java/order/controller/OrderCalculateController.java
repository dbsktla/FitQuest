package order.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gym.model.GymBean;
import gym.model.GymDao;
import member.model.MemberBean;
import member.model.MemberDao;
import notification.model.NotificationBean;
import notification.model.NotificationDao;
import order.model.OrderDao;
import orderdetail.model.OrderDetailDao;
import product.model.MyShoppingBean;
import product.model.ProductBean;
import product.model.ProductDao;
import review.model.ReviewDao;
import trainer.model.TrainerBean;
import trainer.model.TrainerDao;
import usage.model.UsageBean;
import usage.model.UsageDao;
@Controller
public class OrderCalculateController {
	private final String command = "cartCalculate.od";
	private final String getPage = "orderComplete";
	@Autowired
	ProductDao productDao;
	@Autowired
	OrderDetailDao orderDetailDao;
	@Autowired
	OrderDao orderDao;
	@Autowired
	UsageDao usageDao;
	@Autowired
	MemberDao memberDao;
	@Autowired
	TrainerDao trainerDao;
	@Autowired
	GymDao gymDao;
	@Autowired
	ReviewDao reviewDao;
	@Autowired
	NotificationDao notificationDao;
	
	@RequestMapping(value = command)
	public String doAction(@RequestParam("pnum") int[] pnumArr,
			Model model,
			HttpSession session,
			HttpServletResponse response) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		response.setContentType("text/html; charset=utf-8");
		if(memberBean == null) {
			session.setAttribute("destination", "redirect:/viewMyOrderList.od");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/login.mb";
		} else if(!memberBean.getMtype().equals("generic")){
			try {
				response.getWriter().print("<script>alert('비정상적인 접근입니다.');</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "forward:/main.go";
		}
		int totalAmount = 0;
		boolean flag2 = (Boolean)session.getAttribute("flag2"); //새로고침 하면 다시 주문 안되게 session변수 확인
		if(flag2 == true) {
			
			int cnt = orderDao.insertOrder(memberBean.getId()); //주문 테이블에 먼저 삽입
			int orderNum = orderDao.selectOrderNum(memberBean.getId()); //주문 상세 테이블 다음 삽입.
			
			if(cnt > -1) {
				for(int i = 0; i < pnumArr.length; i++) { //주문 한 상품 하나씩 하나씩 주문 상세 테이블에 넣는거임. 주문을 완료 시키는것.
					int pnum = pnumArr[i]; 
					Map<String, Integer> odMap = new HashMap<String, Integer>();
					odMap.put("pnum", pnum);
					odMap.put("onum", orderNum);
					int cnt2 = orderDetailDao.insertOrderDetail(odMap); //주문에 어떤 상품을 구매 했는지 추가
					System.out.println("cnt2: " + cnt2);
					
					//해당 회원권이 주문되면서 그 해당되는 트레이너에게 알림 보내는 설정
					String recId = productDao.getIdByPnum(pnum); //수신자는 트레이너라서 트레이너 ID.
					String recName = memberDao.getName(recId); //따라서 수신자 이름
					String sendId = memberBean.getId();
					String sendName = memberBean.getName();
					String request = "memberHealthCare.ht";
					String notifContent = sendName + " 회원님이 " + recName + " 선생님의 회원권을 구매했습니다.";
					NotificationBean notifBean = new NotificationBean();
					notifBean.setRecId(recId);
					notifBean.setRecName(recName);
					notifBean.setSendId(sendId);
					notifBean.setSendName(sendName);
					notifBean.setRequest(request);
					notifBean.setNotifContent(notifContent);
					int notif = notificationDao.insertPurchaseNotif(notifBean);
					
					
					if(cnt2 > -1) { //주문 완료 돼서 바로 사용권 테이블로 추가한다.
						ProductBean productBean = productDao.getProductByPnum(pnum);
						String tid = productDao.getIdByPnum(pnum);
						UsageBean usageBean = new UsageBean();
						usageBean.setMid(memberBean.getId());
						System.out.println(tid);
						usageBean.setTid(tid);
						usageBean.setOnum(orderNum);
						usageBean.setPnum(pnum);
						usageBean.setUsage(productBean.getPcount());
						usageBean.setPeople(productBean.getPeople());
						
						int cnt3 = usageDao.insertUsage(usageBean);
						if(cnt3 > -1) { //주문 관련 작업 다 끝나서 이젠 카트를 비우는것.
								session.setAttribute("cartList", null);
								session.setAttribute("cartCount", null);
								session.setAttribute("flag2", false);
						}
						}
					}
				}
			}
		
		//다시 주문 확인 내용 출력 하기 위해 주문한 내용을 생성한다.
		ArrayList<MyShoppingBean> sList = new ArrayList<MyShoppingBean>();
		int orderNum2 = orderDao.selectOrderNum(memberBean.getId());
		List<Integer> pList = orderDetailDao.getPnumList(orderNum2);
		for(int pnum2 : pList) {
			String tid2 = productDao.getIdByPnum(pnum2);
			TrainerBean trainerBean = trainerDao.getTrainer(tid2);
			MemberBean memberBean2 = memberDao.selectMemberById(tid2);
			GymBean gymBean = gymDao.selectGym(trainerBean.getGnum());
			ProductBean productBean2 = productDao.getProductByPnum(pnum2);
			String hasReview = reviewDao.getHasReviewById(tid2);
			double rating = 0.0;
			if(hasReview.equals("Y")) {
				rating = reviewDao.getAverageReviewScore(tid2);
			}
			MyShoppingBean msBean = new MyShoppingBean();
			msBean.setTid(tid2);
			msBean.setTname(memberBean2.getName());
			msBean.setActivity(trainerBean.getActivity());
			msBean.setPurpose(trainerBean.getPurpose());
			msBean.setTimage(trainerBean.getTimage());
			msBean.setGname(gymBean.getGname());
			msBean.setGaddr1(gymBean.getGaddr1());
			msBean.setGaddr2(gymBean.getGaddr2());
			msBean.setPnum(productBean2.getPnum());
			msBean.setPrice(productBean2.getPrice());
			msBean.setMonths(productBean2.getMonths());
			msBean.setPcount(productBean2.getPcount());
			msBean.setPtype(productBean2.getPtype());
			msBean.setPeople(productBean2.getPeople());
			msBean.setRating(rating);
			msBean.setHasReview(hasReview);
			sList.add(msBean);
			totalAmount += productBean2.getPrice();
		}
		model.addAttribute("sList", sList);
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("orderNum", orderNum2);
		model.addAttribute("orderCount", pnumArr.length);
		return getPage;
	}
}