package controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dao.ColaboracionDao;
import dao.HabilidadDao;
import dao.OfertaDao;
import dao.PeticionDao;
import modelo.Colaboracion;
import modelo.Oferta;
import modelo.Peticion;
import modelo.Usuario;

//El formato de las fechas es dd-mm-yyyy. En caso contrario APOCALIPSIS!!!!

@Controller
@RequestMapping("/peticion")
public class PeticionController {

	private PeticionDao peticionDao;
	
	private HabilidadDao habilidadDao;
	
	private ColaboracionDao colaboracionDao;
	
	private OfertaDao ofertaDao;
	
	@Autowired
	public void setPeticionDao(PeticionDao peticionDao){
		this.peticionDao = peticionDao;
	}
	
	@Autowired
	public void setHabilidadDao(HabilidadDao habilidadDao){
		this.habilidadDao=habilidadDao;
	}
	
	@Autowired
	public void setColaboracionDao(ColaboracionDao colaboracionDao){
		this.colaboracionDao = colaboracionDao;
	}
	
	@Autowired
	public void setOfertaDao(OfertaDao ofertaDao){
		this.ofertaDao = ofertaDao;
	}
	
	@RequestMapping("/listar")
	public String listaPeticion(HttpSession session, Model model){
		model.addAttribute("accesible", true);
		model.addAttribute("peticiones", peticionDao.getPeticiones());
		return "peticion/listar";
	}
	
	@RequestMapping("/listarPeticiones")
	public String listarPeticiones(HttpSession session, Model model){
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if(usuario != null){
			model.addAttribute("accesible", false);
			model.addAttribute("peticiones", peticionDao.getPeticiones(usuario.getUsuario()));
			return "peticion/listar";			
		}
		else{
			return "error/error";
		}
	}
	
	@RequestMapping("/listarMisPeticiones/{usuario}")
	public String listarMisPeticiones(HttpSession session, Model model, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null && (u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN"))){
			model.addAttribute("accesible", true);
			model.addAttribute("peticiones", peticionDao.getMisPeticiones(usuario));
			return "peticion/listar";			
		}else{
			return "error/error";
		}
	}
	
	@RequestMapping("/seleccionar")
	public String seleccionarPeticiones(HttpSession session, Model model){
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if(usuario != null){
			model.addAttribute("accesible", false);
			Colaboracion c = (Colaboracion) session.getAttribute("colaboracion");
			Oferta o = ofertaDao.getOferta(c.getIdOferta());
			model.addAttribute("peticiones", peticionDao.getMisPeticionesHabilidad(usuario.getUsuario(), o.getIdHabilidad()));
			return "peticion/seleccionar";			
		}
		else{
			return "error/error";
		}
	}
	
	@RequestMapping(value="/addConHabilidad")
	public String addPeticionConHabilidad(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null){
			model.addAttribute("peticion", new Peticion());
			return "peticion/addConHabilidad";			
		}else{
			return "error/error";
		}
	}

	@RequestMapping(value="/addConHabilidad", method=RequestMethod.POST)
	public String processAddConHabilidadSubmit(HttpSession session, @ModelAttribute("peticion") Peticion peticion, BindingResult bindingResult){
		//if(bindingResult.hasErrors())
		//	return "habilidad/add";
		// PeticionValidator peticionValidator = new PeticionValidator();
		// peticionValidator.validate(peticion, bindingResult);
		// if (bindingResult.hasErrors()) 
		//		return "nadador/add";
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null &&  !u.getRol().name().equals("ADMIN")){
			peticion.setUsuario(u.getUsuario());
			Colaboracion c = (Colaboracion) session.getAttribute("colaboracion");
			Oferta o = ofertaDao.getOferta(c.getIdOferta());
			peticion.setIdHabilidad(o.getIdHabilidad());
			int id_peticion = peticionDao.addPeticionInt(peticion);
			c.setIdPeticion(id_peticion);
			colaboracionDao.addColaboracion(c);
			session.removeAttribute("colaboracion");
			return "redirect:../miColaboracion/listar/"+u.getUsuario()+".html";
		}
		return "redirect:listar.html";
	}

	
	

	@RequestMapping(value="/add")
	public String addPeticion(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null){
			model.addAttribute("accesible", true);
			model.addAttribute("peticion", new Peticion());
			model.addAttribute("habilidades", habilidadDao.getHabilidades());
			return "peticion/add";			
		}else{
			return "error/error";
		}
	}

	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String processAddSubmit(HttpSession session, @ModelAttribute("peticion") Peticion peticion, BindingResult bindingResult){
		PeticionValidator peticionValidator = new PeticionValidator();
		peticionValidator.validate(peticion, bindingResult);
		if (bindingResult.hasErrors()){
			session.setAttribute("feedback", "Hay campos incorrectos o falta rellenar");
			return "peticion/add";
		} 
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null &&  !u.getRol().name().equals("ADMIN")){
			peticion.setUsuario(u.getUsuario());
		}
		peticionDao.addPeticion(peticion);
		return "redirect:listar.html";
	}
	
	@RequestMapping(value="/update/{usuario}/{id_peticion}", method = RequestMethod.GET)
	public String editPeticion(HttpSession session, Model model, @PathVariable int id_peticion, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null && (u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN"))){
			model.addAttribute("peticion", peticionDao.getPeticion(id_peticion));
			model.addAttribute("habilidades", habilidadDao.getHabilidades());
			return "peticion/update";
		}else{
			return "error/error";
		}
	}
	
	@RequestMapping(value="/update/{usuario}/{id_peticion}", method = RequestMethod.POST)
	public String processUpdateSubmit2(HttpSession session, Model model, @PathVariable int id_peticion, @ModelAttribute("peticion") Peticion peticion){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null &&  !u.getRol().name().equals("ADMIN")){
			peticion.setUsuario(u.getUsuario());
		}
		peticionDao.updatePeticion(peticion);
		if (u.getRol().name().equals("ADMIN"))
				return "redirect:../../listar.html";
		else 
			return "redirect:../../listarMisPeticiones/"+u.getUsuario()+".html";
	}
	
	
	@RequestMapping(value="/update/{id_peticion}", method = RequestMethod.GET)
	public String editPeticion(HttpSession session, Model model, @PathVariable int id_peticion, BindingResult bindingResult){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null || u.getRol().name().equals("ADMIN")){
			model.addAttribute("peticion", peticionDao.getPeticion(id_peticion));
			model.addAttribute("habilidades", habilidadDao.getHabilidades());
			return "peticion/update";
		}else{
			return "error/error";
		}
	}
	
	@RequestMapping(value="/update/{id_peticion}", method = RequestMethod.POST)
	public String processUpdateSubmit(HttpSession session, @PathVariable int id_peticion, @ModelAttribute("peticion") Peticion peticion, BindingResult bindingResult){
	//	if(bindingResult.hasErrors())
		//	return "habilidad/update";
		//habilidad.setIdHabilidad(id_habilidad);
		peticionDao.updatePeticion(peticion);
		return "redirect:../listar.html";
	}
	
	@RequestMapping(value="/delete/{usuario}/{id_peticion}")
	public String processDelete(HttpSession session, @PathVariable int id_peticion, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null && (u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN"))){
			peticionDao.deletePeticion(id_peticion);
			if (u.getRol().name().equals("ADMIN"))
				return "redirect:../../listar.html";
			else 
				return "redirect:../../listarMisPeticiones/"+u.getUsuario()+".html";
		}else{
			return "error/error";
		}
	}
	
	/*formateo de fechas	 */
	@InitBinder
	public void initBinder(WebDataBinder webDataBinder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		dateFormat.setLenient(false);
		webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
}
