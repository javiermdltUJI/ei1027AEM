package controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import antlr.collections.List;
import dao.HabilidadDao;
import dao.MiColaboracionDao;
import dao.OfertaDao;
import modelo.Colaboracion;
import modelo.Habilidad;
import modelo.MiColaboracion;
import modelo.Usuario;


//El formato de las fechas es dd-mm-yyyy. En caso contrario APOCALIPSIS!!!

@Controller
@RequestMapping("/miColaboracion")
public class MiColaboracionController {
	
	private HabilidadDao habilidadDao;
	
	@Autowired
	public void setHabilidadDao(HabilidadDao habilidadDao){
		this.habilidadDao = habilidadDao;
	}
	
	
	private OfertaDao ofertaDao;
	
	@Autowired
	public void setOfertaDao(OfertaDao ofertaDao){
		this.ofertaDao = ofertaDao;
	}
	
	
	private MiColaboracionDao miColaboracionDao;
	
	@Autowired
	public void setHabilidadDao(MiColaboracionDao colaboracionDao){
		this.miColaboracionDao = colaboracionDao;
	}
	
	@RequestMapping("/listar/{usuario}")
	public String listaColaboracion(HttpSession session, Model model, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "miColaboracion/listar/"+usuario+".html");
		session.setAttribute("mis", u.getUsuario());

		if(u != null && (u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN"))){
			java.util.List<MiColaboracion> colaboracionesOfertas = miColaboracionDao.getMisColaboracionesOferta(usuario);
			java.util.List<Habilidad> habilidades1 = new ArrayList();
			for(int i=0 ; i < colaboracionesOfertas.size(); i++){
				Habilidad habilidad = habilidadDao.getHabilidad(ofertaDao.getOferta((colaboracionesOfertas.get(i).getIdOferta())).getIdHabilidad());
				habilidades1.add(habilidad);
			}
						
			java.util.List<MiColaboracion> colaboracionesPeticiones = miColaboracionDao.getMisColaboracionesPeticion(usuario);
			java.util.List<Habilidad> habilidades2 = new ArrayList();

			for(int i=0 ; i < colaboracionesPeticiones.size(); i++){
				Habilidad habilidad = habilidadDao.getHabilidad(ofertaDao.getOferta((colaboracionesPeticiones.get(i).getIdOferta())).getIdHabilidad());
				habilidades2.add(habilidad);
			}

			model.addAttribute("colaboracionesOferta", colaboracionesOfertas);
			model.addAttribute("colaboracionesPeticion", colaboracionesPeticiones);
			model.addAttribute("habilidadesOferta", habilidades1);
			model.addAttribute("habilidadesPeticion", habilidades2);

			return "miColaboracion/listar";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	

	@RequestMapping(value="/add")
	public String addColaboracion(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "miColaboracion/add.html");
		if (u==null)
			return "redirect:../login.html";
		else if (u.getRol().name().equals("ADMIN")){
			model.addAttribute("miColaboracion", new MiColaboracion());
			return "miColaboracion/add";
		}else
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
	}

	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String processAddSubmit(HttpSession session, @ModelAttribute("miColaboracion") MiColaboracion miColaboracion,  BindingResult bindingResult){
		//if(bindingResult.hasErrors())
		//	return "habilidad/add";
		miColaboracionDao.addMiColaboracion(miColaboracion);
		return "redirect:listar.html";
	}
	
	@RequestMapping(value="/update/{usuario}/{id_colaboracion}", method = RequestMethod.GET)
	  public String editColaboracion(HttpSession session, Model model, @PathVariable int id_colaboracion, @PathVariable String usuario){
		 Usuario u = (Usuario) session.getAttribute("usuario");
			session.setAttribute("prevURL", "miColaboracion/update/"+usuario+"/"+id_colaboracion+".html");
			if (u==null)
				return "redirect:../login.html";
		    if(u != null && (u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN"))){  
		      model.addAttribute("miColaboracion", miColaboracionDao.getMiColaboracion(id_colaboracion));
		      return "miColaboracion/update";
		    }else{
		    	session.setAttribute("prevURL", "principal/principal.html");
		    	return "error/error";
		    }
	  }
	  
	  @RequestMapping(value="/update/{usuario}/{id_colaboracion}", method = RequestMethod.POST)
	  public String processUpdateSubmit2(HttpSession session,@PathVariable String usuario, @PathVariable int id_colaboracion, @ModelAttribute("miColaboracion") MiColaboracion miColaboracion, BindingResult bindingResult){
	  //  if(bindingResult.hasErrors())
	    //  return "habilidad/update";
	    //habilidad.setIdHabilidad(id_habilidad);
	    MiColaboracion miColaboracion2 = miColaboracionDao.getMiColaboracion(id_colaboracion);
	    miColaboracion2.setHorasTotales(miColaboracion.getHorasTotales());
	    miColaboracion2.setValoracion(miColaboracion.getValoracion());
	    
	    miColaboracionDao.updateMiColaboracion(miColaboracion2);
	    return "redirect:../../listar/"+usuario+".html";
	  }
	
	@RequestMapping(value="/update/{id_colaboracion}", method = RequestMethod.POST)
	public String processUpdateSubmit(HttpSession session, @PathVariable int id_colaboracion, @ModelAttribute("miColaboracion") MiColaboracion miColaboracion, BindingResult bindingResult){
	//	if(bindingResult.hasErrors())
		//	return "habilidad/update";
		//habilidad.setIdHabilidad(id_habilidad);
		miColaboracionDao.updateMiColaboracion(miColaboracion);
		return "redirect:../listar.html";
	}
	
	@RequestMapping(value="/delete/{usuario}/{id_colaboracion}")
	public String processDelete(HttpSession session, @PathVariable int id_colaboracion, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "miColaboracion/listar/"+usuario+".html");
		if (u==null)
			return "redirect:../login.html";
		if(u != null && (u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN"))){
			miColaboracionDao.deleteMiColaboracion(id_colaboracion);
			return "redirect:../listar/"+usuario+".html";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	
	
	
	@RequestMapping(value="/cancelar/{usuario}/{id_colaboracion}", method = RequestMethod.GET)
	public String processCancelar(HttpSession session, Model model, @PathVariable int id_colaboracion, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "miColaboracion/listar/"+usuario+".html");
		if (u==null)
			return "redirect:../login.html";
		if(u != null && (u.getRol().name().equals("ADMIN") || usuario.equals(u.getUsuario())) ){
		    model.addAttribute("miColaboracion", miColaboracionDao.getMiColaboracion(id_colaboracion));
		    return "miColaboracion/update";
	    }else{
	    	session.setAttribute("prevURL", "principal/principal.html");
	    	return "error/error";
	    }
	  }
	  
	  @RequestMapping(value="/cancelar/{usuario}/{id_colaboracion}", method = RequestMethod.POST)
	  public String processCancelarSubmit(HttpSession session,@PathVariable String usuario, @PathVariable int id_colaboracion, @ModelAttribute("miColaboracion") MiColaboracion miColaboracion, BindingResult bindingResult){
	  //  if(bindingResult.hasErrors())
	    //  return "habilidad/update";
	    //habilidad.setIdHabilidad(id_habilidad);
	    MiColaboracion miColaboracion2 = miColaboracionDao.getMiColaboracion(id_colaboracion);
	    miColaboracion2.setHorasTotales(miColaboracion.getHorasTotales());
	    miColaboracion2.setValoracion(miColaboracion.getValoracion());
	    miColaboracion2.setFechaFin( new java.util.Date());
	    miColaboracionDao.updateMiColaboracion(miColaboracion2);
	    return "redirect:../../listar/"+usuario+".html";
	  }
	
	
	
	/*formateo de fechas	 */
	@InitBinder
	public void initBinder(WebDataBinder webDataBinder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		dateFormat.setLenient(false);
		webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

}