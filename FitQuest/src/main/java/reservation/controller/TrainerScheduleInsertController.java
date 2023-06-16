package reservation.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import product.model.ProductBean;
import product.model.ProductDao;
import reservation.model.TscheduleBean;
import reservation.model.TscheduleDao;

@Controller
public class TrainerScheduleInsertController {
	private final String command = "/tScheduleInsert.rv";
	private final String getPage = "trainerScheduleInsert";
	private final String gotoPage = "redirect:/trainerCalendar.rv";

	@Autowired
	TscheduleDao tscheduleDao;
	
	@Autowired
	ProductDao productDao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction(HttpSession session,Model model) {
		String tid = ((MemberBean)session.getAttribute("loginInfo")).getId();
		List<ProductBean> pList = productDao.getProductListById(tid);
		
		//중복된 운동인원(개월수에 따라 분리됨) 하나로 합치기
		Set<Integer> uniqueNumbers = new HashSet<Integer>();
        for (ProductBean pb : pList) {
            uniqueNumbers.add(pb.getPeople());
        }
        Integer[] peopleArray = uniqueNumbers.toArray(new Integer[0]);

        //중복된 개인/단체 유형 하나로 합치기
        Set<String> uniqueTypes = new HashSet<String>();
        for (ProductBean pb : pList) {
            uniqueTypes.add(pb.getPtype());
        }
        String[] typeArray = uniqueTypes.toArray(new String[0]);
        
        model.addAttribute("peopleArray",peopleArray);
        model.addAttribute("typeArray",typeArray);
        model.addAttribute("pList",pList);
		return getPage;
	}
	
	@RequestMapping(value=command,method = RequestMethod.POST)
	public String doAction(@Valid TscheduleBean tscheduleBean, BindingResult result,HttpServletRequest request, Model model,
			HttpSession session,@RequestParam("tsdate") List<String> tsdateList) {
		System.out.println("오나 확인 오류시/tsdate:"+tscheduleBean.getTsdate());
		
			
		System.out.println("타입"+tscheduleBean.getTstype());
		System.out.println("인원수"+tscheduleBean.getTspeople());
		System.out.println("요일"+tscheduleBean.getTsday());
		System.out.println("쉬는날"+tscheduleBean.getTsdate());
		System.out.println("일"+tscheduleBean.getSuntime());
		System.out.println("월"+tscheduleBean.getMontime());
		System.out.println("화"+tscheduleBean.getTuetime());
		System.out.println("수"+tscheduleBean.getWedtime());
		System.out.println("목"+tscheduleBean.getThutime());
		System.out.println("금"+tscheduleBean.getFritime());
		System.out.println("토"+tscheduleBean.getSattime());
		
		//tsday에 요일 집어넣고 tstime에 해당 요일의 시간대 집어넣기
		
		if(result.hasErrors()) {
			return getPage;
		}else {
			String tid = ((MemberBean)session.getAttribute("loginInfo")).getId();
			tscheduleBean.setTid(tid);
			
			String tsdate = ""; 
			
			if(tsdateList.size() > 1) {
				for(int i=0;i<tsdateList.size();i++) {
					tsdate += tsdateList.get(i);
			        if (i < tsdateList.size() - 1) {
			            tsdate += ",";
			        }
				}
			}
			tscheduleBean.setTsdate(tsdate);
			int cnt = tscheduleDao.insertTschedule(tscheduleBean);
			
			if(cnt != -1) {
				return gotoPage;
			}else {
				return getPage;
			}
			
		}
	}
}
