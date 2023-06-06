package health.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import health.model.HealthBean;
import health.model.HealthDao;
import health.model.HealthDateDao;

@Controller
public class MyHealthDeleteController {
	private final String command = "myHealthDelete.ht";
	private final String getPage = "redirect:/myHealthList.ht";
	
	@Autowired
	HealthDateDao healthDateDao;
	@Autowired
	HealthDao healthDao; 
	
	@RequestMapping(command)
	public String doAction(@RequestParam("rowchk") String[] rowchk) {
		
		for(String chk : rowchk) {
			String[] x = chk.split("@");
			// System.out.println("delecheck : " + x[0] + " / " + x[1] + " / " + x[2]); // 이름/시작시간/hnum
			Map<String, String> map = new HashMap<String, String>();
			map.put("hname", x[0]);
			map.put("starttime", x[1]);
			map.put("hnum", x[2]);
			
			int cnt = healthDao.deleteHealth(map);
			if(cnt != -1) { // 삭제성공
				List<HealthBean> hlist = healthDao.getOneHealth(Integer.parseInt(x[2]));
				// 해당 hnum에 해당하는 운동기록이 없으면 날짜도 함께 삭제
				if(hlist.size() == 0) {
					healthDateDao.deleteHealthDate(x[2]);
				}
			}
		}
		
		
		return getPage;
	}
}
