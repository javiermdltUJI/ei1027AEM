package controller;

import java.security.InvalidParameterException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
import dao.MiColaboracionDao;
import dao.OfertaDao;
import dao.PeticionDao;
import dao.UsuarioDao;
import modelo.Colaboracion;
import modelo.Oferta;
import modelo.Peticion;
import modelo.Usuario;



import javax.mail.MessagingException;
import javax.mail.internet.AddressException;


//El formato de las fechas es dd-mm-yyyy. En caso contrario APOCALIPSIS!!!!

@Controller
@RequestMapping("/colaboracion")
public class ColaboracionController {
	
	private ColaboracionDao colaboracionDao;
	private MiColaboracionDao miColaboracionDao;
	private PeticionDao peticionDao;
	private OfertaDao ofertaDao;
	private UsuarioDao usuarioDao;
	private HabilidadDao habilidadDao;

	
	
	@Autowired
	public void setUsuarioDao(UsuarioDao UsuarioDao){
		this.usuarioDao = UsuarioDao;
	}
	
	
	@Autowired
	public void setOfertaDao(OfertaDao OfertaDao){
		this.ofertaDao = OfertaDao;
	}
	
	
	@Autowired
	public void setPeticionDao(PeticionDao PeticionDao){
		this.peticionDao = PeticionDao;
	}
	
	@Autowired
	public void setColaboracionDao(ColaboracionDao colaboracionDao){
		this.colaboracionDao = colaboracionDao;
	}
	
	@Autowired
	public void setHabilidadDao(HabilidadDao habilidadDao){
		this.habilidadDao = habilidadDao;
	}
	
	@Autowired
	public void setMiColaboracionDao(MiColaboracionDao miColaboracionDao){
		this.miColaboracionDao = miColaboracionDao;
	}
	
	
	@RequestMapping("/listar")
	public String listaColaboracion(HttpSession session, Model model){
		session.setAttribute("prevURL", "colaboracion/listar.html" );
		Usuario u = (Usuario) session.getAttribute("usuario");
		if (u==null)
			return "redirect:../login.html";
		else if(u.getRol().name().equals("ADMIN")){
			model.addAttribute("colaboraciones", colaboracionDao.getAColaboraciones());
			return "colaboracion/listar";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	
	@RequestMapping(value="/add")
	public String addColaboracion(HttpSession session, Model model){
		session.setAttribute("prevURL", "colaboracion/add.html" );
		Usuario u = (Usuario) session.getAttribute("usuario");
		if (u==null)
			return "redirect:../login.html";
		else if(u.getRol().name().equals("ADMIN")){
			model.addAttribute("colaboracion", new Colaboracion());
			return "colaboracion/add";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}

	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String processAddSubmit(HttpSession session, @ModelAttribute("colaboracion") Colaboracion colaboracion,  BindingResult bindingResult){
		ColaboracionValidator colaboracionValidator = new ColaboracionValidator();
		colaboracionValidator.setColaboracionValidator(colaboracionDao);
		colaboracionValidator.validate(colaboracion, bindingResult);	
		if(bindingResult.hasErrors()){
			session.setAttribute("feedback", "Hay campos incorrectos o falta rellenar");
			return "colaboracion/add";
		}
		try {
			try{
				colaboracionDao.addColaboracion(colaboracion);
			}catch (IllegalArgumentException e ){
				return "redirect:../error/noOfertaPeticion";
			}
		}catch (InvalidParameterException err){
			return "redirect:../error/noHabilidad";
		}
		return "redirect:listar.html";
	}
	
	
	@RequestMapping(value="/addColaboracion")
	public String addColaboracion2(HttpSession session, Model model){
		session.setAttribute("prevURL", "colaboracion/addColaboracion.html" );
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("error",false);

		if (u==null)
			return "redirect:../login.html";
		else if(u.getRol().name().equals("ADMIN")){
			model.addAttribute("colaboracion", new Colaboracion());
			model.addAttribute("usuarios", usuarioDao.getUsuariosNoEliminadosNoAdmin());
			model.addAttribute("habilidades", habilidadDao.getHabilidadesActivas());
			return "colaboracion/addColaboracion";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}

	@RequestMapping(value="/addColaboracion", method=RequestMethod.POST)
	public String processAddSubmit2(HttpSession session, @ModelAttribute("colaboracion") Colaboracion colaboracion,  BindingResult bindingResult,  Model model) throws AddressException, MessagingException, EmailException{
		ColaboracionValidator colaboracionValidator = new ColaboracionValidator();
		colaboracionValidator.setColaboracionValidator(colaboracionDao);
		colaboracionValidator.validate(colaboracion, bindingResult);	
		if(bindingResult.hasErrors()){
			session.setAttribute("error",true);

			session.setAttribute("feedback", "Hay campos incorrectos o falta rellenar");
			model.addAttribute("elegida", colaboracion.getIdHabilidad());
			model.addAttribute("habilidades", habilidadDao.getHabilidadesActivas());
			model.addAttribute("usuarios", usuarioDao.getUsuariosNoEliminadosNoAdmin());
			model.addAttribute("ofertanteElegido",colaboracion.getOfertante());
			model.addAttribute("demandanteElegido",colaboracion.getDemandante());
			return "colaboracion/addColaboracion";
		}
		try {
			try{
				session.setAttribute("error",false);

				String descripcion = habilidadDao.getHabilidad(colaboracion.getIdHabilidad()).getDescripcion();

				Oferta oferta = new Oferta();
				oferta.setDescripcion(descripcion);
				oferta.setFechaIni(colaboracion.getFechaIni());
				oferta.setFechaFin(colaboracion.getFechaFin());
				oferta.setIdHabilidad(colaboracion.getIdHabilidad());
				oferta.setUsuario(colaboracion.getOfertante());
				int idOferta = ofertaDao.addOfertaInt(oferta);
				
				Peticion peticion = new Peticion();
				peticion.setDescripcion(descripcion);
				peticion.setFechaIni(colaboracion.getFechaIni());
				peticion.setFechaFin(colaboracion.getFechaFin());
				peticion.setIdHabilidad(colaboracion.getIdHabilidad());
				peticion.setUsuario(colaboracion.getDemandante());
				int idPeticion = peticionDao.addPeticionInt(peticion);
				
				colaboracion.setIdOferta(idOferta);
				colaboracion.setIdPeticion(idPeticion);
				
				colaboracionDao.addColaboracion(colaboracion);
				
				String correo = usuarioDao.getUsuario(oferta.getUsuario()).getCorreo();
				mandaCorreo.enviarMensaje(correo, "oferta");
				
				correo = usuarioDao.getUsuario(peticion.getUsuario()).getCorreo();
				mandaCorreo.enviarMensaje(correo,"peticion");
				
				
			}catch (IllegalArgumentException e ){
				return "redirect:../error/noOfertaPeticion";
			}
		}catch (InvalidParameterException err){
			return "redirect:../error/noHabilidad";
		}
		return "redirect:listar.html";
	}
	/*//para admin
	@RequestMapping(value="/ofertaAdd/{id_oferta}")
	public String addColaboracionOfertaAdd(HttpSession session, Model model, @PathVariable int id_oferta){
		session.setAttribute("prevURL", "colaboracion/ofertaAdd/"+id_oferta+".html");
		Usuario u = (Usuario) session.getAttribute("usuario");
		if (u==null)
			return "redirect:../login.html";
		else if(u.getRol().name().equals("ADMIN")){
			model.addAttribute("colaboracion", new Colaboracion());
			int id_habilidad = ofertaDao.getOferta(id_oferta).getIdHabilidad();
			model.addAttribute("peticiones", peticionDao.getNoMisPeticionesHabilidad(ofertaDao.getOferta(id_oferta).getUsuario(), id_habilidad));
			return "colaboracion/ofertaAdd";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	*/
	
	
	
	
	@RequestMapping(value="/consultaHoras")
	public String consultarHoras(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("horas", colaboracionDao.getHorasColaboraciones(u.getUsuario()));
		
		return "usuario/horas";
		
	}
	
	
	
	@RequestMapping(value="/addOferta/{id_oferta}")
	public String addColaboracionOferta(HttpSession session, Model model, @PathVariable int id_oferta){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "colaboracion/addOferta/"+id_oferta+".html" );
		if(u != null){
			if(colaboracionDao.getHorasColaboraciones(u.getUsuario()) < -20){
				session.setAttribute("horas", Math.abs(20+colaboracionDao.getHorasColaboraciones(u.getUsuario())));
				return "error/excesoHorasPeticion";
			}else{
				Oferta ofertaSeleccionada = ofertaDao.getOferta(id_oferta);
				
				session.setAttribute("oferta", ofertaSeleccionada);
				Colaboracion colaboracion = new Colaboracion();
				colaboracion.setIdOferta(id_oferta);
				model.addAttribute("colaboracion", colaboracion);
				session.setAttribute("feedbackFechas", "bien");
				return "colaboracion/addOferta";
			}
		}else{
			return "redirect:../login.html";
		}
	}

	@RequestMapping(value="/addOferta/{id_oferta}", method=RequestMethod.POST)
	public String processAddOfertaSubmit(HttpSession session, @ModelAttribute("colaboracion") Colaboracion colaboracion,  BindingResult bindingResult, @PathVariable int id_oferta){
		ColaboracionValidator colaboracionValidator = new ColaboracionValidator();
		colaboracionValidator.setColaboracionValidator(colaboracionDao);
		colaboracionValidator.validate(colaboracion, bindingResult);
		if(bindingResult.hasErrors()){
			session.setAttribute("feedback", "Hay campos incorrectos o falta rellenar");
			return "colaboracion/addOferta";
		}
		Oferta ofertaSeleccionada = ofertaDao.getOferta(id_oferta);
		if(ofertaSeleccionada.getFechaIni().compareTo(colaboracion.getFechaIni())>0 || ofertaSeleccionada.getFechaFin().compareTo(colaboracion.getFechaFin())<0){
			session.setAttribute("feedbackFechas", "error");
			return "colaboracion/addOferta";
		}
		session.setAttribute("feedbackFechas", "bien");
		colaboracion.setIdOferta(id_oferta);
		session.setAttribute("colaboracion", colaboracion);
		return "redirect:../../peticion/seleccionar.html";
	}
	
	@RequestMapping(value="/addPeticion/{id_peticion}")
	public String addColaboracionPeticion(HttpSession session, Model model, @PathVariable int id_peticion){
		session.setAttribute("prevURL", "colaboracion/addPeticion/"+id_peticion+".html" );
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null){
			if(colaboracionDao.getHorasColaboraciones(u.getUsuario()) > 20){
				session.setAttribute("horas", Math.abs(20-colaboracionDao.getHorasColaboraciones(u.getUsuario())));
				return "error/excesoHorasOferta";
			}else{
				Peticion peticionSeleccionada = peticionDao.getPeticion(id_peticion);
				
				session.setAttribute("peticion", peticionSeleccionada);
				session.setAttribute("feedbackFechas", "bien");
				Colaboracion colaboracion = new Colaboracion();
				colaboracion.setIdPeticion(id_peticion);
				model.addAttribute("colaboracion", colaboracion);
				return "colaboracion/addPeticion";
			}
		}else{
			return "redirect:../login.html";
		}
	}

	@RequestMapping(value="/addPeticion/{id_peticion}", method=RequestMethod.POST)
	public String processAddPeticionSubmit(HttpSession session, @ModelAttribute("colaboracion") Colaboracion colaboracion,  BindingResult bindingResult, @PathVariable int id_peticion){
		ColaboracionValidator colaboracionValidator = new ColaboracionValidator();
		colaboracionValidator.setColaboracionValidator(colaboracionDao);
		colaboracionValidator.validate(colaboracion, bindingResult);	
		if(bindingResult.hasErrors()){
			session.setAttribute("feedback", "Hay campos incorrectos o falta rellenar");	
			return "colaboracion/addPeticion";
		}
		Peticion peticionSeleccionada = peticionDao.getPeticion(id_peticion);
		if(peticionSeleccionada.getFechaIni().compareTo(colaboracion.getFechaIni())>0 || peticionSeleccionada.getFechaFin().compareTo(colaboracion.getFechaFin())<0){
			session.setAttribute("feedbackFechas", "error");
			return "colaboracion/addPeticion";
		}
		session.setAttribute("feedbackFechas", "bien");
		colaboracion.setIdPeticion(id_peticion);
		session.setAttribute("colaboracion", colaboracion);
		return "redirect:../../oferta/seleccionar.html";
	}
	

	
	@RequestMapping(value="/update/{id_colaboracion}", method = RequestMethod.GET)
	public String editColaboracion(HttpSession session, Model model, @PathVariable int id_colaboracion){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if (u==null)
			return "redirect:../login.html";
		session.setAttribute("prevURL", "colaboracion/update/"+id_colaboracion+".html" );
		if(u != null && u.getRol().name().equals("ADMIN")){
			model.addAttribute("colaboracion", colaboracionDao.getColaboracion(id_colaboracion));
			session.setAttribute("id_oferta", colaboracionDao.getColaboracion(id_colaboracion).getIdOferta());
			session.setAttribute("id_peticion", colaboracionDao.getColaboracion(id_colaboracion).getIdPeticion());
			return "colaboracion/update";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	
	@RequestMapping(value="/update/{id_colaboracion}", method = RequestMethod.POST)
	public String processUpdateSubmit(HttpSession session, @PathVariable int id_colaboracion, @ModelAttribute("colaboracion") Colaboracion colaboracion, BindingResult bindingResult){
		ColaboracionValidator colaboracionValidator = new ColaboracionValidator();
		colaboracionValidator.setColaboracionValidator(colaboracionDao);
		colaboracionValidator.validate(colaboracion, bindingResult);	
		if(bindingResult.hasErrors()){
			session.setAttribute("feedback", "Hay campos incorrectos o falta rellenar");
			return "colaboracion/update";
		}
		colaboracion.setIdOferta((int) session.getAttribute("id_oferta"));
		colaboracion.setIdPeticion((int) session.getAttribute("id_peticion"));
		colaboracionDao.updateColaboracion(colaboracion);
		session.removeAttribute("id_oferta");
		session.removeAttribute("id_peticion");
		return "redirect:../listar.html";
	}
	
	@RequestMapping(value="/delete/{id_colaboracion}")
	public String processDelete(HttpSession session, @PathVariable int id_colaboracion){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "colaboracion/listar.html" );
		if (u==null)
			return "redirect:../login.html";
		if(u != null && u.getRol().name().equals("ADMIN")){
			colaboracionDao.deleteColaboracion(id_colaboracion);
			return "redirect:../listar.html";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	
	@RequestMapping(value="/cancelar/{id_colaboracion}")
	public String processCancelar(HttpSession session, @PathVariable int id_colaboracion){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "colaboracion/listar.html" );
		if (u==null)
			return "redirect:../login.html";
		if(u != null && u.getRol().name().equals("ADMIN")){
			colaboracionDao.cancelarColaboracion(id_colaboracion);
			return "redirect:../listar.html";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	
	@RequestMapping(value="/cancelar/{usuario}/{id_colaboracion}")
	public String processCancelar(HttpSession session, @PathVariable int id_colaboracion, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "miColaboracion/cancelar/"+usuario+"/"+id_colaboracion+".html" );
		if (u==null)
			return "redirect:../login.html";
		if(u != null && (u.getRol().name().equals("ADMIN") || usuario.equals(u.getUsuario())) ){
			session.setAttribute("colaboracion", colaboracionDao.getColaboracion(id_colaboracion));
			return "miColaboracion/update";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	
	
		
	
	// AQUI HABRA QUE COGER LA OFERTA Y DE LA OFERTA SU USUARIO PARA PODER MANDARLE UN CORREO
	@RequestMapping("/creada/{id_peticion}")
	public String creadaColaboracion(HttpSession session, Model model, @PathVariable int id_peticion) throws AddressException, MessagingException, EmailException{
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "colaboracion/creada/"+id_peticion+".html");
		if (u==null)
			return "redirect:../login.html";
		else{
			Colaboracion c = (Colaboracion) session.getAttribute("colaboracion");
			c.setIdPeticion(id_peticion);
			colaboracionDao.addColaboracion(c);
			model.addAttribute("colaboracionesOferta", miColaboracionDao.getMisColaboracionesOferta(u.getUsuario()));
			model.addAttribute("colaboracionesPeticion", miColaboracionDao.getMisColaboracionesPeticion(u.getUsuario()));

			Oferta oferta = ofertaDao.getOferta(c.getIdOferta());
			
			String correo = usuarioDao.getUsuario(oferta.getUsuario()).getCorreo();

			mandaCorreo.enviarMensaje(correo, "oferta");
			
//			return "/sendEmail";
			return "miColaboracion/listar";

		}
	}
	
	
	
	
	// AQUI HABRA QUE COGER LA PETICION Y DE LA PETICION SU USUARIO PARA PODER MANDARLE UN CORREO
	@RequestMapping("/creadaOferta/{id_oferta}")
	public String creadaColaboracionOferta(HttpSession session, Model model, @PathVariable int id_oferta) throws AddressException, MessagingException, EmailException{
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "colaboracion/creadaOferta/"+id_oferta+".html");
		if (u==null)
			return "redirect:../login.html";
		else{
			Colaboracion c = (Colaboracion) session.getAttribute("colaboracion");
			c.setIdOferta(id_oferta);
			colaboracionDao.addColaboracion(c);
			model.addAttribute("colaboracionesOferta", miColaboracionDao.getMisColaboracionesOferta(u.getUsuario()));
			model.addAttribute("colaboracionesPeticion", miColaboracionDao.getMisColaboracionesPeticion(u.getUsuario()));
			
			Peticion peticion = peticionDao.getPeticion(c.getIdPeticion());
			
			String correo = usuarioDao.getUsuario(peticion.getUsuario()).getCorreo();

			
			mandaCorreo.enviarMensaje(correo, "oferta");
			
//			return "/sendEmail";
			return "miColaboracion/listar";
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
