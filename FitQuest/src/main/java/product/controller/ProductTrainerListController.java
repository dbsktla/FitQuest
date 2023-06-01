package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import product.model.MyTrainerList;
import product.model.ProductDao;
import utility.Paging;

@Controller
public class ProductTrainerListController {
	private final String command = "/list.pd";
	private final String getPage = "trainerList";
	@Autowired
	ProductDao productDao;
	
	@RequestMapping(value = command)
	public String doAction(Model model,
						   @RequestParam(value = "activity", required = false) String activity,
						   @RequestParam(value = "purpose", required = false) String purpose,
						   @RequestParam(value = "order", required = false) String order,
						   @RequestParam(value = "addressDo", required = false) String addressDo,
						   @RequestParam(value = "addressSiGunGu", required = false) String addressSiGunGu,
						   @RequestParam(value = "pageNumber", required = false) String pageNumber,
						   HttpServletRequest request) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("activity", activity);
		map.put("purpose", purpose);
		map.put("order", order);
		map.put("addressDo", "%" + addressDo + "%");
		map.put("addressSiGunGu", "%" + addressSiGunGu + "%");
		System.out.println("addr: " + map.get("addressDo"));
		System.out.println("addr: " + map.get("addressSiGunGu"));
		int count = productDao.getTrainerCount(map);
		String url = request.getContextPath() + command;
		Paging pageInfo = new Paging(pageNumber, "3", count, url, activity, purpose, order, addressDo, addressSiGunGu);
		System.out.println(count);
		List<MyTrainerList> tList = productDao.getTrainerList(map, pageInfo);
		model.addAttribute("tList", tList);
		model.addAttribute("pageInfo", pageInfo);
		return "trainerList";
	}
}
