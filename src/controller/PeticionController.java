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

import dao.HabilidadDao;
import dao.PeticionDao;
import modelo.Peticion;
import modelo.Usuario;

//El formato de las fechas es dd-mm-yyyy. En caso contrario APOCALIPSIS!!!!

@Controller
@RequestMapping("/peticion")
public class PeticionController {

	private PeticionDao peticionDao;
	
	private HabilidadDao habilidadDao;
	
	@Autowired
	public void setPeticionDao(PeticionDao peticionDao){
		this.peticionDao = peticionDao;
	}
	
	@Autowired
	public void setHabilidadDao(HabilidadDao habilidadDao){
		this.habilidadDao=habilidadDao;
	}
	
	@RequestMapping("/listar")
	public String listaPeticion(HttpSession session, Model model){
		model.addAttribute("peticiones", peticionDao.getPeticiones());
		return "peticion/listar";
	}
	
	@RequestMapping("/listarPeticiones")
	public String listarPeticiones(HttpSession session, Model model){
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		model.addAttribute("peticiones", peticionDao.getPeticiones(usuario.getUsuario()));
		return "peticion/listar";
	}
	
	@RequestMapping("/listarMisPeticiones")
	public String listarMisPeticiones(HttpSession session, Model model){
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		model.addAttribute("peticiones", peticionDao.getMisPeticiones(usuario.getUsuario()));
		return "peticion/listar";
	}

	@RequestMapping(value="/add")
	public String addPeticion(HttpSession session, Model model){
		model.addAttribute("peticion", new Peticion());
		model.addAttribute("habilidades", habilidadDao.getHabilidades());
		return "peticion/add";
	}

	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String processAddSubmit(HttpSession session, @ModelAttribute("peticion") Peticion peticion, BindingResult bindingResult){
		//if(bindingResult.hasErrors())
		//	return "habilidad/add";
		// PeticionValidator peticionValidator = new PeticionValidator();
		// peticionValidator.validate(peticion, bindingResult);
		// if (bindingResult.hasErrors()) 
		//		return "nadador/add";
		peticionDao.addPeticion(peticion);
		return "redirect:listar.html";
	}
	
	@RequestMapping(value="/update/{id_peticion}", method = RequestMethod.GET)
	public String editPeticion(HttpSession session, Model model, @PathVariable int id_peticion){
			model.addAttribute("peticion", peticionDao.getPeticion(id_peticion));
			model.addAttribute("habilidades", habilidadDao.getHabilidades());
			return "peticion/update";	
	}
	
	@RequestMapping(value="/update/{id_peticion}", method = RequestMethod.POST)
	public String processUpdateSubmit(HttpSession session, @PathVariable int id_peticion, @ModelAttribute("peticion") Peticion peticion, BindingResult bindingResult){
	//	if(bindingResult.hasErrors())
		//	return "habilidad/update";
		//habilidad.setIdHabilidad(id_habilidad);
		peticionDao.updatePeticion(peticion);
		return "redirect:../listar.html";
	}
	
	@RequestMapping(value="/delete/{id_peticion}")
	public String processDelete(HttpSession session, @PathVariable int id_peticion){
		peticionDao.deletePeticion(id_peticion);
		return "redirect:../listar.html";
	}
	
	/*formateo de fechas	 */
	@InitBinder
	public void initBinder(WebDataBinder webDataBinder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		dateFormat.setLenient(false);
		webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
}
