package physique.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import physique.model.PhysiqueBean;
import physique.model.PhysiqueDao;

@Controller
public class MyPhysiqueUpdateController {
	private final String command = "myPhysiqueUpdate.ht";
	private final String getPage = "myPhysiqueUpdateForm";
	private final String gotoPage = "redirect:/myPhysiqueList.ht";
	
	
	@Autowired
	PhysiqueDao physiqueDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView doAction(@RequestParam("phnum") int phnum) {
		ModelAndView mav = new ModelAndView();
		
		PhysiqueBean physiqueBean = physiqueDao.getPhysiqueByPhnum(phnum);
		mav.addObject("physiqueBean", physiqueBean);
		mav.setViewName(getPage);
		return mav;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView doAction(@ModelAttribute("physiqueBean") PhysiqueBean physiqueBean,
								HttpServletResponse response, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		response.setContentType("text/html; charset=UTF-8");
		
		String uploadPath = "C:\\Users\\user\\git\\FitQuest\\FitQuest\\src\\main\\webapp\\resources\\Image\\InbodyImage";
		
		//String uploadPath = "src/main/webapp/resources/Image/InbodyImage";
		
		File destination = new File(uploadPath + File.separator + physiqueBean.getUpload().getOriginalFilename());
		File delFile = new File(uploadPath + File.separator + physiqueBean.getUpload2());
		
		
		System.out.println("up1 : " + physiqueBean.getUpload().getOriginalFilename());
		System.out.println("up2 : " + physiqueBean.getUpload2());
		System.out.println("up1 Img : " + physiqueBean.getPhimage());
		
		if(physiqueBean.getPhimage().equals("")) { // 기존파일
			//System.out.println("test");
			physiqueBean.setPhimage(physiqueBean.getUpload2());
		}
		
		int cnt = physiqueDao.updatePhysique(physiqueBean);
		
		
		if(cnt != -1) {
			
			if(physiqueBean.getPhimage().equals(physiqueBean.getUpload2())) {
				mav.setViewName(gotoPage);
			} else {
				MultipartFile multi = physiqueBean.getUpload();
				try {
					multi.transferTo(destination);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				delFile.delete();
				mav.setViewName(gotoPage);
			}
			
		}else {
			try {
				response.getWriter().print("<script>alert('수정실패');history.go(-1);</script>");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return mav;
	}
}
