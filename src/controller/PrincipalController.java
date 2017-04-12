package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import modelo.Usuario;

@Controller
@RequestMapping("/principal")
public class PrincipalController {
	
	@RequestMapping(value="/index", method = RequestMethod.GET)
	public String inicio(Model model, HttpSession session) {
		//model.addAttribute("usuarioLogin", new Usuario());
		
		return "principal/index";
	}	
}