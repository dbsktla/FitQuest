package physique.controller;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import physique.model.PhysiqueBean;
import physique.model.PhysiqueDao;

@Controller
public class MyPhysiqueInsertController {
	private final String command = "myPhysiqueInsert.ht";
	private final String getPage = "myPhysiqueInsertForm";
	private final String gotoPage = "redirect:/myPhysiqueList.ht";
	
	@Autowired
	ServletContext servletContext;
	
	@Autowired
	PhysiqueDao physiqueDao;
	
	// form 이동
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(@RequestParam("phdate") String phdate, HttpSession session, HttpServletResponse response,
							Model model) {
		response.setContentType("text/html; charset=UTF-8");
		MemberBean memberBean =  (MemberBean)session.getAttribute("loginInfo");
		if(memberBean == null) {
			session.setAttribute("destination", "redirect:/myPhysiqueList.ht");
			try {
				response.getWriter().print("<script>alert('로그인이 필요합니다.');location.href='login.mb'</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		phdate = phdate.replace(',', '-');
		model.addAttribute("phdate", phdate);
		
		return getPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String doAction(@ModelAttribute("physiqueBean") PhysiqueBean physiqueBean,
								HttpServletRequest request, HttpSession session,
								HttpServletResponse response) {
		
//		String uploadPath = request.getContextPath() + "/resources/image/InbodyImage";
//		System.out.println("uploadPath : " + uploadPath);
		
//		ClassPathResource repath = new ClassPathResource("/resources");
//		System.out.println("repath : " + repath.getPath());
//		
//		URL upath = this.getClass().getResource("/");
//		String path = upath.getPath();
//		
//		System.out.println("upath : " + upath.toString());
//		System.out.println("path : " + path);
//		System.out.println("path2 : " + request.getRealPath("/"));
		
		String uploadPath = "C:\\Users\\user\\git\\FitQuest\\FitQuest\\src\\main\\webapp\\resources\\Image\\InbodyImage";
		
		
		File destination = new File(uploadPath + File.separator + physiqueBean.getUpload().getOriginalFilename());
		MultipartFile multi =  physiqueBean.getUpload();
		
		physiqueBean.setId(((MemberBean)session.getAttribute("loginInfo")).getId());
		
		int cnt = physiqueDao.insertPhysique(physiqueBean);
		if(cnt != -1) {
			try {
				multi.transferTo(destination);
			} catch (IllegalStateException e) {
				System.out.println("이미지 삽입 실패");
				e.printStackTrace();
			} catch (IOException e) {
				System.out.println("이미지 삽입 실패");
				e.printStackTrace();
			}
			
		}else {
			try {
				response.getWriter().print("<script>alert('삽입실패');history.go(-1);</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return gotoPage;
		
	}
}
