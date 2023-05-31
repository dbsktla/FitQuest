package product.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import product.model.ProductDao;

@Controller
public class ProductTrainerListController {
	private final String command = "list.pd";
	private final String getPage = "trainerList";
	@Autowired
	ProductDao productDao;
	
	@RequestMapping(value = command)
	public String doAction(Model model) {
		
		productDao.getTrainerList();
		return "trainerList";
	}
}
