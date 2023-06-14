package member.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class MemberLoginController {
	private final String command = "/login.mb";
	private final String getPage = "memberLoginForm";
	private final String gotoPage = "redirect:/main.go";

	@Autowired
	MemberDao memberDao;

	@RequestMapping(value=command,method=RequestMethod.GET)
	public String login() {
		return getPage;
	}
	
	@RequestMapping(value=command,method=RequestMethod.POST)
	public String login(
			@RequestParam("id") String id, 
			@RequestParam("password") String password, 
			HttpServletResponse response, 
			HttpSession session
			) {
		response.setContentType("text/html; charset=UTF-8");
		MemberBean memberBean = memberDao.selectMemberById(id);
		try {
			if(memberBean == null) {
				response.getWriter().print("<script>alert('해당 아이디가 존재하지 않습니다.');history.go(-1);</script>");
				response.getWriter().flush();
				return getPage;
			}
			else {
				if(memberBean.getPassword().equals(password)) {
					session.setAttribute("loginInfo", memberBean);
					if(id.equals("admin")) {
						return "redirect:/adminMain.ad";
					}
					String destination = (String)session.getAttribute("destination");
					// 이전 페이지 정보가 있으면 이전 페이지로 이동한다.
					if(destination != null) {
						return destination;
					}
					// 이전 페이지 정보가 없으면 메인페이지로 이동함.
					else {
						return gotoPage;
					}
					
				}
				else {
					response.getWriter().print("<script>alert('비밀번호가 일치하지 않습니다.');history.go(-1);</script>");
					response.getWriter().flush();
					return getPage;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return getPage;
	}
	
	@RequestMapping(value="/logout.mb")
	public String logout(HttpSession session) {
		session.setAttribute("loginInfo", null);
		return "redirect:/main.go";
	}
	
	@RequestMapping(value="/naverLoginPopup.mb")
	public String naverPopup() {
		return "memberNaverLogin";
	}
	
	@RequestMapping(value="/naverLogin.mb")
	public String naver(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html; charset=UTF-8");
		MemberBean memberBean = new MemberBean();
		
		String id = "naver" + (request.getParameter("id").replace("_", "")).substring(0,10);
		String name = request.getParameter("name");
		String nickname = request.getParameter("nickname");
		String birthday = request.getParameter("birthday");
		String birthyear = request.getParameter("birthyear");
		String phone = request.getParameter("mphone");
		String email = request.getParameter("email");
		String gender = request.getParameter("gender");
		if(gender.equals("F")) {
			gender = "여자";
		}
		else if(gender.equals("M")) {
			gender = "남자";
		}
		
		String birth = birthyear + "-" + birthday;
		
		String[] phoneArr = phone.split("-");
		String mphone = "";
		for(int i=0;i<phoneArr.length;i++) {
			mphone += phoneArr[i];
		}
		
		memberBean.setId(id);
		memberBean.setMtype("generic");
		memberBean.setName(name);
		memberBean.setPassword("소셜 로그인");
		memberBean.setNickname(nickname);
		memberBean.setBirth(birth);
		memberBean.setMphone(mphone);
		memberBean.setGender(gender);
		memberBean.setMaddr1("");
		memberBean.setMaddr2("");
		memberBean.setEmail(email);
		
		boolean login = memberDao.searchId(id);
		if(login) {
			session.setAttribute("loginInfo", memberBean);
			
			String destination = (String)session.getAttribute("destination");
			// 이전 페이지 정보가 있으면 이전 페이지로 이동한다.
			if(destination != null) {
				return destination;
			}
			// 이전 페이지 정보가 없으면 메인페이지로 이동함.
			else {
				return gotoPage;
			}
		}
		else {
			try {
				int cnt = memberDao.insertMember(memberBean);
				System.out.println("InsertNaver cnt : " + cnt);
				response.getWriter().print("<script>alert('소셜 회원가입되었습니다.');history.go(-1);</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return getPage;
		}
		
	}
	
	@RequestMapping(value="/kakaoLogin.mb")
	public String kakao(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		response.setContentType("text/html; charset=UTF-8");
		
		MemberBean memberBean = new MemberBean();
		
		String id = "kakao" + request.getParameter("id");
		String name = request.getParameter("name");
		String nickname = request.getParameter("nickname");
		String birthday = request.getParameter("birthday");
		String birthyear = request.getParameter("birthyear");
		String phone = request.getParameter("mphone");
		String email = request.getParameter("email");
		String gender = request.getParameter("gender");
		if(gender.equals("female")) {
			gender = "여자";
		}
		else if(gender.equals("male")) {
			gender = "남자";
		}
		
		String birth = birthyear + "-" + birthday.substring(0, 2) + "-" + birthday.substring(2);
		String[] mphoneArr = phone.substring(4).split("-");
		String mphone = "0";
		for(int i=0;i<mphoneArr.length;i++) {
			mphone += mphoneArr[i];
		}
		
		memberBean.setId(id);
		memberBean.setMtype("generic");
		memberBean.setName(name);
		memberBean.setPassword("소셜 로그인");
		memberBean.setNickname(nickname);
		memberBean.setBirth(birth);
		memberBean.setMphone(mphone);
		memberBean.setGender(gender);
		memberBean.setMaddr1("");
		memberBean.setMaddr2("");
		memberBean.setEmail(email);
		
		boolean login = memberDao.searchId(id);
		if(login) {
			session.setAttribute("loginInfo", memberBean);
			String destination = (String)session.getAttribute("destination");
			// 이전 페이지 정보가 있으면 이전 페이지로 이동한다.
			if(destination != null) {
				return destination;
			}
			// 이전 페이지 정보가 없으면 메인페이지로 이동함.
			else {
				return gotoPage;
			}
		}
		else {
			try {
				int cnt = memberDao.insertMember(memberBean);
				System.out.println("InsertKaKao cnt : " + cnt);
				response.getWriter().print("<script>alert('소셜 회원가입되었습니다.');history.go(-1);</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return getPage;
		}
	}

}
