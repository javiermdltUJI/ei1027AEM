package controller;


import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/principal")
public class PrincipalController {
	
	@RequestMapping(value="/index", method = RequestMethod.GET)
	public String inicio(Model model, HttpSession session) {
		//model.addAttribute("usuarioLogin", new Usuario());
		session.setAttribute("prevURL", "principal/index.html" );
		return "principal/index";
	}
	
	@RequestMapping(value="/principal", method = RequestMethod.GET)
	public String principal(Model model, HttpSession session) {
		//model.addAttribute("usuarioLogin", new Usuario());
		session.setAttribute("prevURL", "principal/principal.html" );		
		return "principal/principal";
	}
	
	@RequestMapping(value="/politicas", method = RequestMethod.GET)
	public String politicas(Model model, HttpSession session) {
		//model.addAttribute("usuarioLogin", new Usuario());
		session.setAttribute("prevURL", "principal/politicas.html" );		
		return "principal/politicas";
	}
	
	@RequestMapping(value="/ok", method = RequestMethod.POST, produces="application/json")
	public @ResponseBody String cookieOK(Model model, HttpSession session) {
		session.setAttribute("ok", 1);
		return "OK";
	}
}