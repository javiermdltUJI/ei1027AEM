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

import dao.MiColaboracionDao;
import modelo.MiColaboracion;
import modelo.Usuario;


//El formato de las fechas es dd-mm-yyyy. En caso contrario APOCALIPSIS!!!

@Controller
@RequestMapping("/miColaboracion")
public class MiColaboracionController {
	
	private MiColaboracionDao miColaboracionDao;
	
	@Autowired
	public void setHabilidadDao(MiColaboracionDao colaboracionDao){
		this.miColaboracionDao = colaboracionDao;
	}
	
	@RequestMapping("/listar/{usuario}")
	public String listaColaboracion(HttpSession session, Model model, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null && (u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN"))){
			model.addAttribute("colaboracionesOferta", miColaboracionDao.getMisColaboracionesOferta(usuario));
			model.addAttribute("colaboracionesPeticion", miColaboracionDao.getMisColaboracionesPeticion(usuario));
			return "miColaboracion/listar";
		}else{
			return "error/error";
		}
	}
	

	@RequestMapping(value="/add")
	public String addColaboracion(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null){
			model.addAttribute("miColaboracion", new MiColaboracion());
			return "miColaboracion/add";
		}else{
			return "error/error";
		}
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
	    System.out.println();
	    if(u != null && (u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN"))){  
	      model.addAttribute("miColaboracion", miColaboracionDao.getMiColaboracion(id_colaboracion));
	      return "miColaboracion/update";
	    }else{
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
		if(u != null && (u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN"))){
			miColaboracionDao.deleteMiColaboracion(id_colaboracion);
			return "redirect:../listar.html";
		}else{
			return "error/error";
		}
	}
	
	
	
	@RequestMapping(value="/cancelar/{usuario}/{id_colaboracion}", method = RequestMethod.GET)
	  public String processCancelar(HttpSession session, Model model, @PathVariable int id_colaboracion, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null && (u.getRol().name().equals("ADMIN") || usuario.equals(u.getUsuario())) ){
			//session.setAttribute("miColaboracion", miColaboracionDao.getMiColaboracion(id_colaboracion));
		      model.addAttribute("miColaboracion", miColaboracionDao.getMiColaboracion(id_colaboracion));
	      return "miColaboracion/update";
	    }else{
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