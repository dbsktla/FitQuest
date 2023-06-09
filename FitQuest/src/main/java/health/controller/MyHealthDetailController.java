package health.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import health.model.HealthBean;
import health.model.HealthDao;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class MyHealthDetailController {
	private final String command = "myHealthDetail.ht";
	
	@Autowired
	HealthDao healthDao;
	
	// 상세목록 ajax
	// produces = "application/text; charset=utf8" > ajax 한글처리
	@RequestMapping(value = command, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String doAction(HttpServletResponse response, @RequestParam("hnum") int hnum) {
		response.setContentType("text/html; charset=UTF-8");
		System.out.println("hnum : " + hnum);
		
		// 선택한 번호에 해당하는 상세목록 불러오기
		List<HealthBean> hlist = healthDao.getOneHealth(hnum);
		
		// json 형태로 ajax에 리턴하기 위한 json 배열 생성
		JSONArray jsArr = new JSONArray();
		int i =0;
		for(HealthBean hb : hlist) {
			// 여러개의 목록을 담기 위해서 jsonobject 생성
			JSONObject jsObject = new JSONObject();
			// 가져온 값을 object에 담는다.
			// (String, Object) 형식으로 담을 수 있음!!@@
			jsObject.put("hnum", hb.getHnum());
			jsObject.put("hname", hb.getHname());
			jsObject.put("starttime", hb.getStarttime());
			jsObject.put("endtime", hb.getEndtime());
			jsObject.put("hcount", hb.getHcount());
			jsObject.put("hset", hb.getHset());
			
			// json 배열의 i번째방에 해당 object를 넣음
			jsArr.add(i, jsObject);
			i++;
		}
		
		System.out.println(jsArr);
		
		// toString 형태로 json 배열을 ajax로 넘김
		return jsArr.toString();
	}
}
