package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dao.HabilidadDao;
import modelo.Habilidad;
import modelo.Usuario;

@Controller
@RequestMapping("/habilidad")
public class HabilidadController {
	
	private HabilidadDao habilidadDao;
	
	@Autowired
	public void setHabilidadDao(HabilidadDao habilidadDao){
		this.habilidadDao = habilidadDao;
	}
	
	@RequestMapping("/listar")
	public String listaHabilidad(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "habilidad/listar.html");
		if (u==null)
			return "redirect:../login.html";
		if(u.getRol().name().equals("ADMIN")){
			model.addAttribute("habilidades", habilidadDao.getHabilidades());
			return "habilidad/listar";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	
	@RequestMapping("/listarActivas")
	public String listaHabilidadActiva(HttpSession session, Model model){
		session.setAttribute("prevURL", "habilidad/listarActivas.html");
		model.addAttribute("habilidades", habilidadDao.getHabilidadesActivas());
		return "habilidad/listar";
	}



	@RequestMapping(value="/add")
	public String addHabilidad(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "habilidad/add.html");
		if (u==null)
			return "redirect:../login.html";
		if(u != null && u.getRol().name().equals("ADMIN")){
			model.addAttribute("habilidad", new Habilidad());
			return "habilidad/add";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";	
		}
	}

	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String processAddSubmit(HttpSession session, @ModelAttribute("habilidad") Habilidad habilidad, BindingResult bindingResult){
		//if(bindingResult.hasErrors())
		//	return "habilidad/add";
		habilidadDao.addHabilidad(habilidad);
		return "redirect:listar.html";
	}
	
	@RequestMapping(value="/update/{id_habilidad}", method = RequestMethod.GET)
	public String editHabilidad(HttpSession session, Model model, @PathVariable int id_habilidad){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "habilidad/update/"+id_habilidad+".html");
		if (u==null)
			return "redirect:../login.html";
		if(u != null && u.getRol().name().equals("ADMIN")){
			model.addAttribute("habilidad", habilidadDao.getHabilidad(id_habilidad));
			return "habilidad/update";	
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	
	@RequestMapping(value="/update/{id_habilidad}", method = RequestMethod.POST)
	public String processUpdateSubmit(HttpSession session, @PathVariable int id_habilidad, @ModelAttribute("habilidad") Habilidad habilidad, BindingResult bindingResult){
	//	if(bindingResult.hasErrors())
		//	return "habilidad/update";
		//habilidad.setIdHabilidad(id_habilidad);
		habilidadDao.updateHabilidad(habilidad);
		return "redirect:../listar.html";
	}
	
	@RequestMapping(value="/delete/{id_habilidad}")
	public String processDelete(HttpSession session, @PathVariable int id_habilidad){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "habilidad/listar.html");
		if (u==null)
			return "redirect:../login.html";
		if(u != null && u.getRol().name().equals("ADMIN")){
			habilidadDao.deleteHabilidad(id_habilidad);
			return "redirect:../listar.html";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
}
