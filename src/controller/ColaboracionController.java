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
import dao.MiColaboracionDao;
import dao.OfertaDao;
import dao.PeticionDao;
import modelo.Colaboracion;
import modelo.Oferta;
import modelo.Peticion;
import modelo.Usuario;


//El formato de las fechas es dd-mm-yyyy. En caso contrario APOCALIPSIS!!!!

@Controller
@RequestMapping("/colaboracion")
public class ColaboracionController {
	
	private ColaboracionDao colaboracionDao;
	private OfertaDao ofertaDao;
	private PeticionDao peticionDao;
	private MiColaboracionDao miColaboracionDao;

	
	@Autowired
	public void setColaboracionDao(ColaboracionDao colaboracionDao){
		this.colaboracionDao = colaboracionDao;
	}
	
	@Autowired
	public void setMiColaboracionDao(MiColaboracionDao miColaboracionDao){
		this.miColaboracionDao = miColaboracionDao;
	}
	
	@Autowired
	public void setOfertaDao(OfertaDao ofertaDao){
		this.ofertaDao = ofertaDao;
	}
	
	@Autowired
	public void setPeticionDao(PeticionDao peticionDao){
		this.peticionDao = peticionDao;
	}
	
	@RequestMapping("/listar")
	public String listaColaboracion(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null && u.getRol().name().equals("ADMIN")){
			model.addAttribute("colaboraciones", colaboracionDao.getColaboraciones());
			return "colaboracion/listar";
		}else{
			return "error/error";
		}
	}
	
	@RequestMapping(value="/add")
	public String addColaboracion(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null){
			model.addAttribute("colaboracion", new Colaboracion());
			return "colaboracion/add";
		}else{
			return "error/error";
		}
	}

	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String processAddSubmit(HttpSession session, @ModelAttribute("colaboracion") Colaboracion colaboracion,  BindingResult bindingResult){
		//if(bindingResult.hasErrors())
		//	return "habilidad/add";
		colaboracionDao.addColaboracion(colaboracion);
		return "redirect:listar.html";
	}
	
	@RequestMapping(value="/addOferta/{id_oferta}")
	public String addColaboracionOferta(HttpSession session, Model model, @PathVariable int id_oferta){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null){
			if(colaboracionDao.getHorasColaboraciones(u.getUsuario()) > 20){
				return "error/excesoHorasOferta";
			}else{
				model.addAttribute("colaboracion", new Colaboracion());				
				return "colaboracion/addOferta";
			}
		}else{
			return "error/error";
		}
	}

	@RequestMapping(value="/addOferta/{id_oferta}", method=RequestMethod.POST)
	public String processAddOfertaSubmit(HttpSession session, @ModelAttribute("colaboracion") Colaboracion colaboracion,  BindingResult bindingResult, @PathVariable int id_oferta){
		//if(bindingResult.hasErrors())
		//	return "habilidad/add";
		colaboracion.setIdOferta(id_oferta);
		session.setAttribute("colaboracion", colaboracion);
		return "redirect:../../peticion/seleccionar.html";
	}
	
	@RequestMapping(value="/addPeticion/{id_peticion}")
	public String addColaboracionPeticion(HttpSession session, Model model, @PathVariable int id_peticion){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null){
			if(colaboracionDao.getHorasColaboraciones(u.getUsuario()) < -20){
				return "error/excesoHorasPeticion";
			}else{
				model.addAttribute("colaboracion", new Colaboracion());				
				return "colaboracion/addPeticion";
			}
		}else{
			return "error/error";
		}
	}

	@RequestMapping(value="/addPeticion/{id_peticion}", method=RequestMethod.POST)
	public String processAddPeticionSubmit(HttpSession session, @ModelAttribute("colaboracion") Colaboracion colaboracion,  BindingResult bindingResult, @PathVariable int id_peticion){
		//if(bindingResult.hasErrors())
		//	return "habilidad/add";
		colaboracion.setIdPeticion(id_peticion);
		session.setAttribute("colaboracion", colaboracion);
		return "redirect:../../oferta/seleccionar.html";
	}
	

	
	@RequestMapping(value="/update/{id_colaboracion}", method = RequestMethod.GET)
	public String editColaboracion(HttpSession session, Model model, @PathVariable int id_colaboracion){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null && u.getRol().name().equals("ADMIN")){
			model.addAttribute("colaboracion", colaboracionDao.getColaboracion(id_colaboracion));
			return "colaboracion/update";
		}else{
			return "error/error";
		}
	}
	
	@RequestMapping(value="/update/{id_colaboracion}", method = RequestMethod.POST)
	public String processUpdateSubmit(HttpSession session, @PathVariable int id_colaboracion, @ModelAttribute("colaboracion") Colaboracion colaboracion, BindingResult bindingResult){
	//	if(bindingResult.hasErrors())
		//	return "habilidad/update";
		//habilidad.setIdHabilidad(id_habilidad);
		colaboracionDao.updateColaboracion(colaboracion);
		return "redirect:../listar.html";
	}
	
	@RequestMapping(value="/delete/{id_colaboracion}")
	public String processDelete(HttpSession session, @PathVariable int id_colaboracion){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null && u.getRol().name().equals("ADMIN")){
			colaboracionDao.deleteColaboracion(id_colaboracion);
			return "redirect:../listar.html";
		}else{
			return "error/error";
		}
	}
	
	@RequestMapping(value="/cancelar/{id_colaboracion}")
	public String processCancelar(HttpSession session, @PathVariable int id_colaboracion){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null && u.getRol().name().equals("ADMIN")){
			colaboracionDao.cancelarColaboracion(id_colaboracion);
			return "redirect:../listar.html";
		}else{
			return "error/error";
		}
	}
	
	@RequestMapping("/creada/{id_peticion}")
	public String creadaColaboracion(HttpSession session, Model model, @PathVariable int id_peticion){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null){
			Colaboracion c = (Colaboracion) session.getAttribute("colaboracion");
			c.setIdPeticion(id_peticion);
			colaboracionDao.addColaboracion(c);
			model.addAttribute("colaboracionesOferta", miColaboracionDao.getMisColaboracionesOferta(u.getUsuario()));
			model.addAttribute("colaboracionesPeticion", miColaboracionDao.getMisColaboracionesPeticion(u.getUsuario()));
			return "miColaboracion/listar";
		}else{
			return "error/error";
		}
	}
	
	@RequestMapping("/creadaOferta/{id_oferta}")
	public String creadaColaboracionOferta(HttpSession session, Model model, @PathVariable int id_oferta){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null){
			Colaboracion c = (Colaboracion) session.getAttribute("colaboracion");
			c.setIdOferta(id_oferta);
			colaboracionDao.addColaboracion(c);
			model.addAttribute("colaboracionesOferta", miColaboracionDao.getMisColaboracionesOferta(u.getUsuario()));
			model.addAttribute("colaboracionesPeticion", miColaboracionDao.getMisColaboracionesPeticion(u.getUsuario()));
			return "miColaboracion/listar";
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
