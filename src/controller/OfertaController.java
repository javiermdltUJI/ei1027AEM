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
import dao.OfertaDao;
import modelo.Oferta;
import modelo.Usuario;


//El formato de las fechas es dd-mm-yyyy. En caso contrario APOCALIPSIS!!!!

@Controller
@RequestMapping("/oferta")
public class OfertaController {
	
	private OfertaDao ofertaDao;
	
	private HabilidadDao habilidadDao;

	
	@Autowired
	public void setOfertaDao(OfertaDao ofertaDao){
		this.ofertaDao = ofertaDao;
	}
	
	@Autowired
	public void setHabilidadDao(HabilidadDao habilidadDao){
		this.habilidadDao=habilidadDao;
	}
	
	
	@RequestMapping("/listar")
	public String listaOferta(HttpSession session, Model model){
		model.addAttribute("ofertas", ofertaDao.getOfertas());
		return "oferta/listar";
	}
	
	@RequestMapping("/listarOfertas")
	public String listarOfertas(HttpSession session, Model model){
		Usuario usuario = (Usuario) session.getAttribute("usuario");
		if(usuario != null){
			model.addAttribute("accesible", false);
			model.addAttribute("ofertas", ofertaDao.getOfertas(usuario.getUsuario()));
			return "oferta/listar";			
		}else{
			return "error/error";
		}
	}
	
	
	@RequestMapping("/listarMisOfertas/{usuario}")
	public String listarMisOfertas(HttpSession session, Model model, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null && (u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN"))){
			model.addAttribute("accesible", true);
			model.addAttribute("ofertas", ofertaDao.getMisOfertas(usuario));
			return "oferta/listar";
		}else{
			return "error/error";
		}
	}

	@RequestMapping(value="/add")
	public String addOferta(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null){
			model.addAttribute("oferta", new Oferta());
			model.addAttribute("habilidades", habilidadDao.getHabilidades());
			return "oferta/add";			
		}else{
			return "error/error";
		}
	}

	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String processAddSubmit(HttpSession session, @ModelAttribute("oferta") Oferta oferta, BindingResult bindingResult){
		//if(bindingResult.hasErrors())
		//	return "habilidad/add";
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null &&  !u.getRol().name().equals("ADMIN")){
			oferta.setUsuario(u.getUsuario());
		}
		ofertaDao.addOferta(oferta);
		return "redirect:listar.html";
	}
	
	@RequestMapping(value="/update/{usuario}/{id_oferta}", method = RequestMethod.GET)
	public String editOferta(HttpSession session, Model model, @PathVariable int id_oferta, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null && (u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN"))){	
			model.addAttribute("oferta", ofertaDao.getOferta(id_oferta));
			model.addAttribute("habilidades", habilidadDao.getHabilidades());
			return "oferta/update";
		}else{
			return "error/error";
		}
	}
	
	@RequestMapping(value="/update/{usuario}/{id_oferta}", method = RequestMethod.POST)
	public String processUpdateSubmit2(HttpSession session, @PathVariable int id_oferta, @ModelAttribute("oferta") Oferta oferta, BindingResult bindingResult){
	//	if(bindingResult.hasErrors())
		//	return "habilidad/update";
		//habilidad.setIdHabilidad(id_habilidad);
		//System.out.println(oferta.toString());
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
		if(u != null || u.getRol().name().equals("ADMIN")){	
			model.addAttribute("oferta", ofertaDao.getOferta(id_oferta));
			model.addAttribute("habilidades", habilidadDao.getHabilidades());
			return "oferta/update";
		}else{
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
		if(u != null && (u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN"))){
			ofertaDao.deleteOferta(id_oferta);
			return "redirect:../../listar.html";
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
