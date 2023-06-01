package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import composite.model.CompositeDao;
import composite.model.TrainerListBean;
import utility.Paging;

@Controller
public class ProductTrainerListController {
	private final String command = "/trainerList.pd";
	private final String getPage = "trainerList";
	@Autowired
	CompositeDao productDao;
	
	@RequestMapping(value = command)
	public String doAction(Model model,
						   @RequestParam(value = "activity", required = false) String activity,
						   @RequestParam(value = "purpose", required = false) String purpose,
						   @RequestParam(value = "ordering", required = false) String ordering,
						   @RequestParam(value = "addressDo", required = false) String addressDo,
						   @RequestParam(value = "addressSiGunGu", required = false) String addressSiGunGu,
						   @RequestParam(value = "pageNumber", required = false) String pageNumber,
						   HttpServletRequest request, HttpSession session) {
		Map<String, String> map = new HashMap<String, String>();
		if(purpose == null) {
			purpose = "null,null,null,null";
		}
		String[] abcd = {"A", "B", "C", "D"};
		String[] purposeArr = purpose.split(",");
		for(int i = 1; i <= purposeArr.length; i++) {
			map.put("purpose" + abcd[i-1], "%" + purposeArr[i-1] + "%");
			System.out.println(purposeArr[i-1]);
			System.out.println("i" +i);
		}
		for(int j = purposeArr.length; j <= 3; j++) {
			map.put("purpose" + abcd[j], "%null%");
			System.out.println("j" + j);
		}
		map.put("activity", "%" + activity + "%");
		map.put("ordering", ordering);
		map.put("addressDo", "%" + addressDo + "%");
		map.put("addressSiGunGu", "%" + addressSiGunGu + "%");
		int count = productDao.getTrainerCount(map);
		String url = request.getContextPath() + command;
		Paging pageInfo = new Paging(pageNumber, "3", count, url, activity, purpose, ordering, addressDo, addressSiGunGu);
		System.out.println("count:"+count);
		List<TrainerListBean> tList = productDao.getTrainerList(map, pageInfo);
		model.addAttribute("tList", tList);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("activity", activity);
		model.addAttribute("purpose", purpose);
		model.addAttribute("ordering", ordering);
		model.addAttribute("addressDo", addressDo);
		model.addAttribute("addressSiGunGu", addressSiGunGu);
		System.out.println("size:" + tList.size());
		session.setAttribute("destination", getPage);
		return getPage;
	}
}
