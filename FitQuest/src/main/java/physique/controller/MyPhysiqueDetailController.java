package physique.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.MemberBean;
import member.model.MemberDao;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import physique.model.PhysiqueBean;
import physique.model.PhysiqueDao;

@Controller
public class MyPhysiqueDetailController {
	private final String command = "myPhysiqueDetail.ht";
	
	@Autowired
	PhysiqueDao physiqueDao;
	
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(value = command, method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String doAction(HttpSession session, HttpServletResponse response,
							@RequestParam("selectDay") String selectDay,
							@RequestParam("selectYear") String selectYear,
							@RequestParam("selectMon") String selectMon,
							@RequestParam(value = "mid", required = false) String mid) {
		response.setContentType("text/html; charset=UTF-8");
		MemberBean memberBean =  (MemberBean)session.getAttribute("loginInfo");
		
		JSONObject jsObject = new JSONObject();
		
		System.out.println("Physique select");
		System.out.println("memberBean : " + memberBean);
		
		if(memberBean == null) {
			session.setAttribute("destination", "redirect:/myPhysiqueList.ht");
			jsObject.put("returnData", "idNull");
			return jsObject.toString();
		} else {
			
			if(selectMon.length() == 1)
				selectMon = "0" + selectMon;
			if(selectDay.length() == 1)
				selectDay = "0" + selectDay;
			
			String selectDate = selectYear + "-" + selectMon + "-" + selectDay;
			
			String name = "";
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("phdate", selectDate);
			if(mid != null) {
				map.put("id", mid);
				name = memberDao.getName(mid);
			}else {
				map.put("id", memberBean.getId());
				name = memberBean.getName();
			}
			
			PhysiqueBean physiqueBean = physiqueDao.getOnePhysique(map);
			
			
			System.out.println("physiqueBean : " + physiqueBean);
			
			if(physiqueBean == null) {
				jsObject.put("returnData", "BeanNull");
				return jsObject.toString();
			}else {
				
				jsObject.put("name", name);
				jsObject.put("id", physiqueBean.getId());
				jsObject.put("phnum", physiqueBean.getPhnum());
				jsObject.put("height", physiqueBean.getHeight());
				jsObject.put("weight", physiqueBean.getWeight());
				jsObject.put("bmi", physiqueBean.getBmi());
				jsObject.put("phdate", (physiqueBean.getPhdate()).substring(0,10));
				jsObject.put("skeletalmuscle", physiqueBean.getSkeletalmuscle());
				jsObject.put("bodyfatper", physiqueBean.getBodyfatper());
				jsObject.put("bmr", physiqueBean.getBmr());
				jsObject.put("phimage", physiqueBean.getPhimage());
				
				System.out.println("jsObject : " + jsObject.toString());
				
				return jsObject.toString();
			}
			
		}
		
	}
	
}
