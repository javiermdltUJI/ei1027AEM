package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dao.ColaboracionDao;
import dao.MiColaboracionDao;
import dao.OfertaDao;
import dao.PeticionDao;
import dao.UsuarioDao;
import modelo.Usuario;

@Controller
@RequestMapping("/estadisticas")
public class EstadisticasController {
	
	private ColaboracionDao colaboracionDao;
	private MiColaboracionDao miColaboracionDao;
	private PeticionDao peticionDao;
	private OfertaDao ofertaDao;
	private UsuarioDao usuarioDao;

	
	
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
	public void setMiColaboracionDao(MiColaboracionDao miColaboracionDao){
		this.miColaboracionDao = miColaboracionDao;
	}
	
	
	
	@RequestMapping(value="/resumen", method = RequestMethod.GET)
	public String listaColaboracion(HttpSession session, Model model){
		session.setAttribute("prevURL", "estadisticas/resumen.html" );
		Usuario u = (Usuario) session.getAttribute("usuario");
		if (u==null)
			return "redirect:../login.html";
		else if(u.getRol().name().equals("ADMIN")){
			return "estadisticas/resumen";
		}else{
			session.setAttribute("prevURL", "estadisticas/resumen.html");
			return "error/error";
		}
	}
	
	
	
	
}
	