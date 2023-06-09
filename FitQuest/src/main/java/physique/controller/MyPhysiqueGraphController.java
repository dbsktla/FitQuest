package physique.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import health.model.HealthBean;
import member.model.MemberBean;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import physique.model.PhysiqueBean;
import physique.model.PhysiqueDao;

@Controller
public class MyPhysiqueGraphController {
	private final String command = "myPhysiqueGraph.ht";

	@Autowired
	PhysiqueDao physiqueDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET, produces = "application/text; charset=utf8")
	@ResponseBody
	public String doAction(HttpSession session) {
		
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		// 전체목록
		List<PhysiqueBean> phlist = physiqueDao.getPhysiqueList(memberBean.getId());
		
		JSONArray jsArr = new JSONArray();
		int i =0;
		for(PhysiqueBean pb : phlist) {
			JSONObject jsObject = new JSONObject();
			jsObject.put("id", pb.getId());
			jsObject.put("phnum", pb.getPhnum());
			jsObject.put("height", pb.getHeight());
			jsObject.put("weight", pb.getWeight());
			jsObject.put("bmi", pb.getBmi());
			jsObject.put("phdate", pb.getPhdate().substring(0, 11));
			jsObject.put("skeletalmuscle", pb.getSkeletalmuscle());
			jsObject.put("bodyfatper", pb.getBodyfatper());
			jsObject.put("bmr", pb.getBmr());
			jsObject.put("phimage", pb.getPhimage());
			
			jsArr.add(i, jsObject);
			i++;
		}
		
		System.out.println(jsArr);
		
		return jsArr.toString();
	}
}
