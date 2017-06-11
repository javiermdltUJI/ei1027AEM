package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dao.ColaboracionDao;
import dao.HabilidadDao;
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
	public void setMiColaboracionDao(MiColaboracionDao miColaboracionDao){
		this.miColaboracionDao = miColaboracionDao;
	}
	
	@Autowired
	public void setHabilidadDao(HabilidadDao habilidadDao){
		this.habilidadDao = habilidadDao;
	}
	
	
	
	@RequestMapping(value="/resumen", method = RequestMethod.GET)
	public String listaColaboracion(HttpSession session, Model model){
		session.setAttribute("prevURL", "estadisticas/resumen.html" );
		Usuario u = (Usuario) session.getAttribute("usuario");
		if (u==null)
			return "redirect:../login.html";
		else if(u.getRol().name().equals("ADMIN")){
			
			//Usuarios
			model.addAttribute("usuariosTotales", usuarioDao.getUsuariosTotales());
			model.addAttribute("usuariosBloqueados", usuarioDao.getUsuariosBloqueados());
			model.addAttribute("usuariosEliminados", usuarioDao.getUsuariosEliminados());

			//Habilidad
			model.addAttribute("habilidadesTotales", habilidadDao.getHabilidadesTotales());
			model.addAttribute("habilidadesCanceladas", habilidadDao.getHabilidadesCanceladas());
			model.addAttribute("habilidadMasOfertada", habilidadDao.getHabilidadMasOfertada());
			model.addAttribute("habilidadMasDemandada", habilidadDao.getHabilidadMasDemandada());
			
			//Colaboracion
			model.addAttribute("colaboracionesTotales", colaboracionDao.getColaboracionesTotales());
			model.addAttribute("colaboracionesValoradas", colaboracionDao.getColaboracionesValoradas());
			model.addAttribute("peticionesTotales", peticionDao.getPeticionesTotales());
			model.addAttribute("ofertasTotales", ofertaDao.getOfertasTotales());
			
			
			
			
			return "estadisticas/resumen";
		}else{
			session.setAttribute("prevURL", "estadisticas/resumen.html");
			return "error/error";
		}
	}
	
	
	
	
}
	