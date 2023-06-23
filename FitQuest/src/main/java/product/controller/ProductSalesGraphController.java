package product.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import composite.model.CompositeDao;
import composite.model.SalesBean;
import member.model.MemberBean;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class ProductSalesGraphController {
	private final String command = "mySalesGraph.pd";
	private final String command2 = "mySalesGraph2.pd";
	@Autowired
	CompositeDao compositeDao;
	@RequestMapping(value = command, method = RequestMethod.GET)
	@ResponseBody
	public String doAction(HttpSession session) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		List<SalesBean> sList = compositeDao.getWeeklyCount(memberBean.getId());
		JSONArray jsArr = new JSONArray();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		Date date = cal.getTime();
		String[] days = new String[7];
		int[] sales = new int[7];
		days[6] = sdf.format(date);
		for(int i = 5; i >= 0; i--){
		    cal.add(Calendar.DAY_OF_MONTH, -1);
		    date = cal.getTime();
		    days[i] = sdf.format(date);
		}
		if(sList.size() != 0) {
			for(int i = 0; i < sList.size();i++) {
				SalesBean sBean = sList.get(i);
				String[] day = sBean.getOdate().split(" ");
				for(int j = 0; j < days.length; j++) {
					String comp1 = days[j].trim();
					String comp2 = day[0].trim();
					if(comp1.equals(comp2)) {
						sales[j] = sBean.getPnum();
					}
				}
			}
		}
		for(int i = 0; i < days.length; i++) {
			JSONObject jsObject = new JSONObject();
			jsObject.put("count", sales[i]);
			jsObject.put("date", days[i]);
			jsArr.add(i, jsObject);
		}
		return jsArr.toString();
	}
	@RequestMapping(value = command2, method = RequestMethod.GET)
	@ResponseBody
	public String doAction2(HttpSession session) {
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		List<SalesBean> sList = compositeDao.getMonthlyCount(memberBean.getId());
		JSONArray jsArr = new JSONArray();
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM");
		Calendar cal2 = Calendar.getInstance();
		Date date2 = cal2.getTime();
		String[] months = new String[6];
		int[] monthSales = new int[6];
		months[5] = sdf2.format(date2);
		for(int i = 4 ; i >= 0; i--) {
			cal2.add(Calendar.MONTH, -1);
			date2 = cal2.getTime();
			months[i] = sdf2.format(date2);
		}
		if(sList.size() != 0) {
			for(int i = 0; i < sList.size();i++) {
				SalesBean sBean = sList.get(i);
				String[] day = sBean.getOdate().split(" ");
				for(int j = 0; j < months.length; j++) {
					String comp1 = months[j].trim();
					String comp2 = day[0].trim();
					if(comp1.equals(comp2)) {
						monthSales[j] = sBean.getPnum();
					}
				}
			}
		}
		for(int i = 0; i < months.length; i++) {
			JSONObject jsObject = new JSONObject();
			jsObject.put("mcount", monthSales[i]);
			jsObject.put("mdate", months[i]);
			jsArr.add(i, jsObject);
		}
		System.out.println("jsArr" + jsArr);
		return jsArr.toString();
	}
}
