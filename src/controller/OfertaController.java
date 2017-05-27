package controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import com.ibm.icu.util.Calendar;

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
@RequestMapping("/oferta")
public class OfertaController {
	
	private OfertaDao ofertaDao;
	private PeticionDao peticionDao;
	
	private ColaboracionDao colaboracionDao;
	
	private HabilidadDao habilidadDao;
	private UsuarioDao usuarioDao;

	@Autowired
	public void setUsuarioDao(UsuarioDao usuarioDao){
		this.usuarioDao = usuarioDao;
	}
	
	@Autowired
	public void setOfertaDao(OfertaDao ofertaDao){
		this.ofertaDao = ofertaDao;
	}
	
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
	
	@RequestMapping("/listar")
	public String listaOferta(HttpSession session, Model model){
		model.addAttribute("accesible", true);
		model.addAttribute("ofertas", ofertaDao.getOfertas());
		session.setAttribute("prevURL", "oferta/listar.html" );
		session.removeAttribute("mis");
		return "oferta/listar";
	}
	
	@RequestMapping("/listarOfertas")
	public String listarOfertas(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		model.addAttribute("accesible", false);
		session.setAttribute("prevURL", "oferta/listarOfertas.html" );
		session.removeAttribute("mis");
		if (u==null)
			return "redirect:../login.html";
		else{
			model.addAttribute("accesible", false);
			model.addAttribute("ofertas", ofertaDao.getOfertas(u.getUsuario()));
			return "oferta/listar";			
		}
	}
	
	//Ofertas del usuario
	@RequestMapping("/listarMisOfertas/{usuario}")
	public String listarMisOfertas(HttpSession session, Model model, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("mis", u.getUsuario());
		session.setAttribute("prevURL", "oferta/listarMisOfertas/"+usuario+".html" );
		if (u==null)
			return "redirect:../login.html";
		else if(u.getUsuario().equals(usuario)){
			model.addAttribute("accesible", false);
			model.addAttribute("ofertas", ofertaDao.getMisOfertas(usuario));
			return "oferta/listar";		
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}

	
	@RequestMapping("/seleccionar")
	public String seleccionarOfertas(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "oferta/seleccionar.html" );
		if (u==null)
			return "redirect:../login.html";
		else{
			model.addAttribute("accesible", false);
			Colaboracion c = (Colaboracion) session.getAttribute("colaboracion");
			Peticion p = peticionDao.getPeticion(c.getIdPeticion());
			Colaboracion colaboracion = (Colaboracion) session.getAttribute("colaboracion");
			Date FechaIniColabo = colaboracion.getFechaIni();
			Date FechaFinColabo = colaboracion.getFechaFin();
			
			List<Oferta> ofertas = ofertaDao.getMisOfertasHabilidad(u.getUsuario(), p.getIdHabilidad());
			
			List<Oferta> ofertasValidas =  new ArrayList<Oferta>();

			for( Oferta oferta:ofertas){
				if(oferta.getFechaIni().compareTo(FechaIniColabo)<=0 && oferta.getFechaFin().compareTo(FechaFinColabo)>=0){
					ofertasValidas.add(oferta);
				}
			}
			
			model.addAttribute("ofertas", ofertasValidas);
			return "oferta/seleccionar";			
		}
	}
	
	@RequestMapping(value="/addConHabilidad")
	public String addOfertaConHabilidad(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "oferta/addConHabilidad.html" );
		if (u==null)
			return "redirect:../login.html";
		else if (session.getAttribute("colaboracion")!=null){
			model.addAttribute("oferta", new Oferta());
			session.setAttribute("feedbackFechas", "Noerror");
			return "oferta/addConHabilidad";			
		} else {
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}

	@RequestMapping(value="/addConHabilidad", method=RequestMethod.POST)
	public String processAddConHabilidadSubmit(HttpSession session, @ModelAttribute("oferta") Oferta oferta, BindingResult bindingResult) throws AddressException, MessagingException, EmailException{
		OfertaValidator ofertaValidator = new OfertaValidator();
		ofertaValidator.validate(oferta, bindingResult);
		if (bindingResult.hasErrors()){
			session.setAttribute("feedback", "Hay campos incorrectos o falta rellenar");
			return "oferta/addConHabilidad";
		}
		Colaboracion colaboracion = (Colaboracion) session.getAttribute("colaboracion");
		Date FechaIniColabo = colaboracion.getFechaIni();
		Date FechaFinColabo = colaboracion.getFechaFin();
		if(oferta.getFechaIni().compareTo(colaboracion.getFechaIni())>0 || oferta.getFechaFin().compareTo(colaboracion.getFechaFin())<0){
			session.setAttribute("feedbackFechas", "error");
			return "peticion/addConHabilidad";
		}
		
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null &&  !u.getRol().name().equals("ADMIN")){
			oferta.setUsuario(u.getUsuario());
			Colaboracion c = (Colaboracion) session.getAttribute("colaboracion");
			Peticion p = peticionDao.getPeticion(c.getIdPeticion());
			oferta.setIdHabilidad(p.getIdHabilidad());
			int id_oferta = ofertaDao.addOfertaInt(oferta);
			c.setIdOferta(id_oferta);
			colaboracionDao.addColaboracion(c);
			session.removeAttribute("colaboracion");
			
			String correo = usuarioDao.getUsuario(p.getUsuario()).getCorreo();
			mandaCorreo.enviarMensaje(correo, "peticion");
			
			return "redirect:../miColaboracion/listar/"+u.getUsuario()+".html";
		}
		return "redirect:listar.html";
	}

	
	@RequestMapping(value="/add")
	public String addOferta(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "oferta/add.html" );
		if (u==null)
			return "redirect:../login.html";
		else {
			model.addAttribute("oferta", new Oferta());
			model.addAttribute("habilidades", habilidadDao.getHabilidadesActivas());
			return "oferta/add";			
		}
	}

	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String processAddSubmit(HttpSession session, @ModelAttribute("oferta") Oferta oferta, BindingResult bindingResult, Model model){
		OfertaValidator ofertaValidator = new OfertaValidator();
		ofertaValidator.validate(oferta, bindingResult);
		if (bindingResult.hasErrors()){
			model.addAttribute("elegida", oferta.getIdHabilidad());
			model.addAttribute("habilidades", habilidadDao.getHabilidadesActivas());
			session.setAttribute("feedback", "Hay campos incorrectos o falta rellenar");
			return "oferta/add";
		}
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null &&  !u.getRol().name().equals("ADMIN")){
			oferta.setUsuario(u.getUsuario());
			ofertaDao.addOferta(oferta);
			return "redirect:listarMisOfertas/"+u.getUsuario()+".html";
		}
		ofertaDao.addOferta(oferta);
		return "redirect:listar.html";


		
	}
	
	@RequestMapping(value="/update/{usuario}/{id_oferta}", method = RequestMethod.GET)
	public String editOferta(HttpSession session, Model model, @PathVariable int id_oferta, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "oferta/update/"+usuario+"/"+id_oferta+".html" );
		if (u==null)
			return "redirect:../login.html";
		if(u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN")){	
			model.addAttribute("oferta", ofertaDao.getOferta(id_oferta));
			model.addAttribute("habilidades", habilidadDao.getHabilidadesActivas());
			return "oferta/update";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	
	@RequestMapping(value="/update/{usuario}/{id_oferta}", method = RequestMethod.POST)
	public String processUpdateSubmit2(HttpSession session, @PathVariable int id_oferta, @ModelAttribute("oferta") Oferta oferta, BindingResult bindingResult, Model model){
		OfertaValidator ofertaValidator = new OfertaValidator();
		ofertaValidator.validate(oferta, bindingResult);
		if (bindingResult.hasErrors()){
			model.addAttribute("elegida", oferta.getIdHabilidad());
			model.addAttribute("habilidades", habilidadDao.getHabilidadesActivas());
			session.setAttribute("feedback", "Hay campos incorrectos o falta rellenar");
			return "oferta/update";
		}		
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null &&  !u.getRol().name().equals("ADMIN")){
			oferta.setUsuario(u.getUsuario());
		}
		ofertaDao.updateOferta(oferta);
		if (u.getRol().name().equals("ADMIN"))
			return "redirect:../../listar.html";
		else 
			return "redirect:../../listarMisOfertas/"+u.getUsuario()+".html";
	}
	
	
	@RequestMapping(value="/update/{id_oferta}", method = RequestMethod.GET)
	public String editOferta(HttpSession session, Model model, @PathVariable int id_oferta){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "oferta/update/"+id_oferta+".html" );
		if (u==null)
			return "redirect:../login.html";
		else if(u.getRol().name().equals("ADMIN")){	
			model.addAttribute("oferta", ofertaDao.getOferta(id_oferta));
			model.addAttribute("habilidades", habilidadDao.getHabilidades());
			return "oferta/update";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	
	@RequestMapping(value="/update/{id_oferta}", method = RequestMethod.POST)
	public String processUpdateSubmit(HttpSession session, @PathVariable int id_oferta, @ModelAttribute("oferta") Oferta oferta, BindingResult bindingResult){
	//	if(bindingResult.hasErrors())
		//	return "habilidad/update";
		//habilidad.setIdHabilidad(id_habilidad);
		//System.out.println(oferta.toString());
		ofertaDao.updateOferta(oferta);
		return "redirect:../listar.html";
	}
	
	@RequestMapping(value="/delete/{usuario}/{id_oferta}")
	public String processDelete(HttpSession session, @PathVariable int id_oferta, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "oferta/listarMisOfertas/"+usuario+".html" );
		if (u==null)
			return "redirect:../login.html";
		if(u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN")){
			Oferta oferta2 = ofertaDao.getOferta(id_oferta);
			if(colaboracionDao.getNumColaboracionesPorOferta(id_oferta) > 0){
				Calendar cal = Calendar.getInstance();
			    cal.add(Calendar.DATE, -1);
				oferta2.setFechaFin( cal.getTime());
				ofertaDao.updateOferta(oferta2);
			}else{
				ofertaDao.deleteOferta(id_oferta);
			}
			if (u.getRol().name().equals("ADMIN")) {
				session.setAttribute("prevURL", "oferta/listar.html" );
				return "redirect:../../listar.html";
			}else{
				return "redirect:../../listarMisOfertas/"+usuario+".html";	
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
