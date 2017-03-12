package controller;

import org.springframework.stereotype.Controller; 
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProbaController {
	
	@RequestMapping("/prova")
	public String provaWeb(Model model){
		String message = "Provant la configuració feta avui.";
		model.addAttribute("message", message);
		return "prova";
	}
	
}
