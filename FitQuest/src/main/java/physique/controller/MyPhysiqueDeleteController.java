package physique.controller;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import physique.model.PhysiqueDao;
import utility.FitQuestUtil;

@Controller
public class MyPhysiqueDeleteController {
	private final String command = "myPhysiqueDelete.ht";
	private final String gotoPage = "redirect:/myPhysiqueList.ht";
	
	@Autowired
	PhysiqueDao physiqueDao;
	
	@RequestMapping(value = command)
	public String doAction(@RequestParam("phnum") int phnum) {
		String delimg = physiqueDao.getPhysiqueByPhnum(phnum).getPhimage();
		
		int cnt = physiqueDao.deletePhysique(phnum);
		System.out.println("phy del cnt : " + cnt);
		
		File delfilePath = new File(FitQuestUtil.getValueFromProjectProperties("common_directory") + "/InbodyImage/" + delimg);
		
		if(cnt != -1) {
			delfilePath.delete();
		}
		
		return gotoPage;
	}
	
}
