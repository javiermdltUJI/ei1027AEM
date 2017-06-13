package controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
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
import dao.UsuarioDao;
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
	private UsuarioDao usuarioDao;

	
	@Autowired
	public void setPeticionDao(PeticionDao peticionDao){
		this.peticionDao = peticionDao;
	}
	
	@Autowired
	public void setUsuarioDao(UsuarioDao usuarioDao){
		this.usuarioDao = usuarioDao;
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
		session.setAttribute("prevURL", "peticion/listar.html");
		return "peticion/listar";
	}
	
	//Peticiones que no son mias
	@RequestMapping("/listarPeticiones")
	public String listarPeticiones(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		model.addAttribute("accesible", false);
		session.removeAttribute("mis");
		session.setAttribute("prevURL", "peticion/listarPeticiones.html");
		if (u==null)
			return "redirect:../login.html";
		else{
			model.addAttribute("accesible", false);
			model.addAttribute("peticiones", peticionDao.getPeticiones(u.getUsuario()));
			return "peticion/listar";			
		}
	}
	
	//Mis peticiones
	@RequestMapping("/listarMisPeticiones/{usuario}")
	public String listarMisPeticiones(HttpSession session, Model model, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("mis", u.getUsuario());
		session.setAttribute("prevURL", "peticion/listarPeticiones.html");
		if (u==null)
			return "redirect:../login.html";
		else if(u.getUsuario().equals(usuario)){
			model.addAttribute("accesible", true);
			model.addAttribute("peticiones", peticionDao.getMisPeticiones(usuario));
			return "peticion/listar";			
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	
	@RequestMapping("/seleccionar")
	public String seleccionarPeticiones(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "peticion/seleccionar.html");
		if (u==null)
			return "redirect:../login.html";
		else {
			model.addAttribute("accesible", false);
			Colaboracion c = (Colaboracion) session.getAttribute("colaboracion");
			Oferta o = ofertaDao.getOferta(c.getIdOferta());
			Colaboracion colaboracion = (Colaboracion) session.getAttribute("colaboracion");
			Date FechaIniColabo = colaboracion.getFechaIni();
			Date FechaFinColabo = colaboracion.getFechaFin();
			
			List<Peticion> peticiones = peticionDao.getMisPeticionesHabilidad(u.getUsuario(), o.getIdHabilidad());
			
			List<Peticion> peticionesValidas =  new ArrayList<Peticion>();

			for( Peticion peticion:peticiones){
				if(peticion.getFechaIni().compareTo(FechaIniColabo)<=0 && peticion.getFechaFin().compareTo(FechaFinColabo)>=0){
					peticionesValidas.add(peticion);
				}
			}
			model.addAttribute("peticiones", peticionesValidas);
			return "peticion/seleccionar";			
		}
	}
	
	@RequestMapping(value="/addConHabilidad")
	public String addPeticionConHabilidad(HttpSession session, Model model) throws AddressException, MessagingException, EmailException{
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "peticion/addConHabilidad.html");
		if (u==null)
			return "redirect:../login.html";
		else if (session.getAttribute("colaboracion")!=null){
			model.addAttribute("peticion", new Peticion());
			session.setAttribute("feedbackFechas", "Noerror");
			//return "peticion/addConHabilidad";
			Peticion peticion = new Peticion();
			peticion.setUsuario(u.getUsuario());			
			Colaboracion c = (Colaboracion) session.getAttribute("colaboracion");
			Oferta o = ofertaDao.getOferta(c.getIdOferta());
			peticion.setIdHabilidad(o.getIdHabilidad());
			peticion.setFechaFin(c.getFechaFin());
			peticion.setFechaIni(c.getFechaIni());
			peticion.setDescripcion(o.getDescripcion());
					
			int id_peticion = peticionDao.addPeticionInt(peticion);
			c.setIdPeticion(id_peticion);
			colaboracionDao.addColaboracion(c);
			session.removeAttribute("colaboracion");
			
			String correo = usuarioDao.getUsuario(o.getUsuario()).getCorreo();
			mandaCorreo.enviarMensaje(correo, "oferta");

			
			return "redirect:../miColaboracion/listar/"+u.getUsuario()+".html";
			
			
			
			
			
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}

	/*@RequestMapping(value="/addConHabilidad", method=RequestMethod.POST)
	public String processAddConHabilidadSubmit(HttpSession session, @ModelAttribute("peticion") Peticion peticion, BindingResult bindingResult) throws AddressException, MessagingException, EmailException{
		PeticionValidator peticionValidator = new PeticionValidator();
		peticionValidator.validate(peticion, bindingResult);
		if (bindingResult.hasErrors()) {
			session.setAttribute("feedback", "Hay campos incorrectos o falta rellenar");
			return "peticion/addConHabilidad";
		}
		Colaboracion colaboracion = (Colaboracion) session.getAttribute("colaboracion");
		Date FechaIniColabo = colaboracion.getFechaIni();
		Date FechaFinColabo = colaboracion.getFechaFin();
		if(peticion.getFechaIni().compareTo(colaboracion.getFechaIni())>0 || peticion.getFechaFin().compareTo(colaboracion.getFechaFin())<0){
			session.setAttribute("feedbackFechas", "error");
			return "peticion/addConHabilidad";
		}
		
		
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
			
			String correo = usuarioDao.getUsuario(o.getUsuario()).getCorreo();
			mandaCorreo.enviarMensaje(correo, "oferta");

			
			return "redirect:../miColaboracion/listar/"+u.getUsuario()+".html";
		}
		return "redirect:listar.html";
	}
*/
	
	

	@RequestMapping(value="/add")
	public String addPeticion(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "peticion/add.html");
		if (u==null)
			return "redirect:../login.html";
		else{
			model.addAttribute("accesible", true);
			model.addAttribute("peticion", new Peticion());
			model.addAttribute("habilidades", habilidadDao.getHabilidadesActivas());
			return "peticion/add";			
		}
	}

	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String processAddSubmit(HttpSession session, @ModelAttribute("peticion") Peticion peticion, BindingResult bindingResult,  Model model){
		PeticionValidator peticionValidator = new PeticionValidator();
		peticionValidator.validate(peticion, bindingResult);
		if (bindingResult.hasErrors()){
			model.addAttribute("elegida", peticion.getIdHabilidad());
			model.addAttribute("habilidades", habilidadDao.getHabilidadesActivas());
			session.setAttribute("feedback", "Hay campos incorrectos o falta rellenar");
			return "peticion/add";
		} 
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null &&  !u.getRol().name().equals("ADMIN")){
			peticion.setUsuario(u.getUsuario());
			peticionDao.addPeticion(peticion);
			return "redirect:listarMisPeticiones/"+u.getUsuario()+".html";
		}
		peticionDao.addPeticion(peticion);
		return "redirect:listar.html";
	}
	
	@RequestMapping(value="/update/{usuario}/{id_peticion}", method = RequestMethod.GET)
	public String editPeticion(HttpSession session, Model model, @PathVariable int id_peticion, @PathVariable String usuario, @ModelAttribute("peticion") Peticion peticion){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "peticion/update/"+usuario+"/"+id_peticion+".html");
		if (u==null)
			return "redirect:../../login.html";
		if(u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN")){
			model.addAttribute("elegida", peticion.getIdHabilidad());
			model.addAttribute("peticion", peticionDao.getPeticion(id_peticion));
			model.addAttribute("habilidades", habilidadDao.getHabilidadesActivas());
			return "peticion/update";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	
	@RequestMapping(value="/update/{usuario}/{id_peticion}", method = RequestMethod.POST)
	public String processUpdateSubmit2(HttpSession session, @PathVariable int id_peticion, @ModelAttribute("peticion") Peticion peticion, BindingResult bindingResult, Model model){
		PeticionValidator peticionValidator = new PeticionValidator();
		peticionValidator.validate(peticion, bindingResult);
		if (bindingResult.hasErrors()){
			model.addAttribute("elegida", peticion.getIdHabilidad());
			model.addAttribute("habilidades", habilidadDao.getHabilidadesActivas());
			session.setAttribute("feedback", "Hay campos incorrectos o falta rellenar");
			return "peticion/update";
		} 
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
		session.setAttribute("prevURL", "peticion/update/"+id_peticion+".html");
		if (u==null)
			return "redirect:../login.html";
		else if(u.getRol().name().equals("ADMIN")){
			model.addAttribute("peticion", peticionDao.getPeticion(id_peticion));
			model.addAttribute("habilidades", habilidadDao.getHabilidades());
			return "peticion/update";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
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
		session.setAttribute("prevURL", "peticion/listarMisPeticiones/"+usuario+".html");
		if (u==null)
			return "redirect:../login.html";
		if(u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN")){
			Peticion peticion2 = peticionDao.getPeticion(id_peticion);
			if(colaboracionDao.getNumColaboracionesPorPeticion(id_peticion) > 0){
				Calendar cal = Calendar.getInstance();
				cal.add(Calendar.DATE, -1);
				peticion2.setFechaIni(cal.getTime());
				peticion2.setFechaFin(cal.getTime());
				peticionDao.updatePeticion(peticion2);
			}else{
				peticionDao.deletePeticion(id_peticion);
			}
			if (u.getRol().name().equals("ADMIN")){
				session.setAttribute("prevURL", "peticion/listar.html");
				return "redirect:../../listar.html";
			}else{
				return "redirect:../../listarMisPeticiones/"+u.getUsuario()+".html";
			}
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
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
