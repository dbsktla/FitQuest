package health.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import health.model.HealthBean;
import health.model.HealthDao;
import member.model.MemberBean;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class MyHealthModalController {
	private final String commnad = "myHealthModal.ht";
	
	@Autowired
	HealthDao healthDao;
	
	@RequestMapping(value = commnad, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String doAction(@RequestParam("info") String info,
							HttpSession session, HttpServletResponse response) {
		
		System.out.println("info : " + info);
		System.out.println("info : " + info.indexOf('-'));
		System.out.println("info : " + info.length());
		
		response.setContentType("text/html; charset=UTF-8");
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		
		String id = memberBean.getId();
		String hnum = info.substring(info.indexOf('-')+1, info.indexOf('-')+2);
		
		System.out.println("hnum : " + hnum);
		
		// 선택한 번호에 해당하는 상세목록 불러오기
		List<HealthBean> hlist = healthDao.getOneHealth(Integer.parseInt(hnum));
		
		JSONArray jsArr = new JSONArray();
		int i =0;
		for(HealthBean hb : hlist) {
			JSONObject jsObject = new JSONObject();
			jsObject.put("hnum", hb.getHnum());
			jsObject.put("hname", hb.getHname());
			jsObject.put("starttime", hb.getStarttime());
			jsObject.put("endtime", hb.getEndtime());
			jsObject.put("hcount", hb.getHcount());
			jsObject.put("hset", hb.getHset());
			
			jsArr.add(i, jsObject);
			i++;
		}
		
		System.out.println(jsArr.toString());
		
		return jsArr.toString();
	}
}
