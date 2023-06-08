package physique.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import physique.model.PhysiqueDao;

@Controller
public class MyPhysiqueDeleteController {
	private final String command = "myPhysiqueDelete.ht";
	private final String gotoPage = "redirect:/myPhysiqueList.ht";
	
	@Autowired
	PhysiqueDao physiqueDao;
	
	@RequestMapping(value = command)
	public String doAction(@RequestParam("phnum") int phnum) {
		int cnt = physiqueDao.deletePhysique(phnum);
		System.out.println("phy del cnt : " + cnt);
		
		return gotoPage;
	}
	
}
