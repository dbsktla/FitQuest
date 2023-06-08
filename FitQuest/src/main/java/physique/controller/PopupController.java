package physique.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PopupController {
	private final String command = "pop.ht";
	private final String getPage = "pop";
	
	@RequestMapping(command)
	public String doAction(@RequestParam(value = "phimage", required = false) String phimage, HttpServletResponse response) {
		System.out.println("phimage : " + phimage);
		
		return getPage;
	}
}
