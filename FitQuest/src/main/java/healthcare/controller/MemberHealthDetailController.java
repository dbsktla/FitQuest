package healthcare.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;

@Controller
public class MemberHealthDetailController {
   
   private final String command = "memberHealthDetail.ht";
   
   @RequestMapping(value = command, method = RequestMethod.POST, produces = "application/text; charset=utf8")
   public String doAction(HttpSession session, HttpServletResponse response,
								@RequestParam(value = "mid") String mid) {
      
      response.setContentType("text/html; charset=UTF-8");
      session.setAttribute("menubar", "memberHealthCare");
      MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
      ModelAndView mav = new ModelAndView();
      
      // 로그인 정보 확인
      if(memberBean == null) { 
         session.setAttribute("destination", "redirect:/memberHealthDetail.ht");
         try {
            response.getWriter().print("<script>alert('로그인이 필요합니다.');location.href='login.mb'</script>");
            response.getWriter().flush(); 
         } catch (IOException e) {
            e.printStackTrace();
         }
         //mav.setViewName(gotoPage);
      }else if(!memberBean.getMtype().equals("trainer")){
         session.setAttribute("destination", "redirect:/main.go");
         try {
            response.getWriter().print("<script>alert('비정상적인 접근입니다.');location.href='login.mb'</script>");
            response.getWriter().flush();
         } catch (IOException e) {
            e.printStackTrace();
         }
      }else {
    	  System.out.println("success mid: " + mid);
         //해당 회원 정보 - 이름, 성별, 나이, 전화번호, 이메일주소
         //운동 정보 - 
         //식단 정보 -
         //신체 정보 - 
         
      }
      
      
      return "";
   }
}