package controller;

import java.text.ParseException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ibm.icu.text.SimpleDateFormat;

import dao.UsuarioDao;
import modelo.Rol;
import modelo.Usuario;

@Controller
@RequestMapping("/usuario")
public class UsuarioController {
	
	private UsuarioDao usuarioDao;
	
	@Autowired
	public void setUsuarioDao(UsuarioDao usuarioDao){
		this.usuarioDao = usuarioDao;
	}
	
	
	@RequestMapping("/horas")
	public String horas(HttpSession session, Model model){
		return "usuario/horas";

	}
		
	@RequestMapping("/listar")
	public String listaUsuarios(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "usuario/listar.html");
		if (u==null)
			return "redirect:../login.html";
		else if(u.getRol().name().equals("ADMIN")){
			model.addAttribute("usuarios", usuarioDao.getUsuarios());
			return "usuario/listar";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	
	@RequestMapping(value="/add")
	public String addUsuario(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u == null){
			model.addAttribute("usuario", new Usuario());
			return "usuario/add";
		}else if(u.getRol().name().equals("ADMIN")){
			model.addAttribute("usuario", new Usuario());
			session.setAttribute("prevURL", "usuario/add.html");
			return "usuario/add";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}

	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String processAddSubmit(@ModelAttribute("usuario") Usuario usuario, BindingResult bindingResult, HttpSession session, Model model){
		UsuarioValidator usuarioValidator = new UsuarioValidator();
		usuarioValidator.validate(usuario, bindingResult);
		if(bindingResult.hasErrors()){
			session.setAttribute("feedback", "Hay campos incorrectos o falta rellenar");
			return "usuario/add";
		}
		if(usuarioDao.existeUsuario(usuario.getUsuario())){
			bindingResult.rejectValue("usuario", "badpw", "El nombre de usuario ya existe");
			return "usuario/add";
		}
		Usuario u = (Usuario) session.getAttribute("usuario");
		if (u==null){
				usuario.setBloqueado(0);
				usuario.setEliminado(0);
				usuario.setFechaFin(new Date());
				usuario.setRol(Rol.ESTUDIANTE);
				usuarioDao.addUsuario(usuario);
				return "redirect:../login.html";
		} else{
			usuarioDao.addUsuario(usuario);
			return "redirect:listar.html";
		}

	}
	
	@RequestMapping(value="/update/{usuario}", method = RequestMethod.GET)
	public String editUsuario(HttpSession session, Model model, @PathVariable String usuario, @ModelAttribute("usuario") Usuario usu){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "usuario/update/"+usuario+".html");
		if (u==null)
			return "redirect:../../login.html";
		else if(u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN")){
			model.addAttribute("usuario", usuarioDao.getUsuario(usuario));
			return "usuario/update";				
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	
	@RequestMapping(value="/update/{nom_usuario}", method = RequestMethod.POST)
	public String processUpdateSubmit(HttpSession session, @PathVariable String nom_usuario, @ModelAttribute("usuario") Usuario usuario, BindingResult bindingResult){
		Usuario u = (Usuario) session.getAttribute("usuario");
		UsuarioValidator usuarioValidator = new UsuarioValidator();
		usuarioValidator.validate(usuario, bindingResult);
		if(bindingResult.hasErrors()){
			session.setAttribute("feedback", "Hay campos incorrectos o falta rellenar");
			return "usuario/update";
		}
		if(u.getRol().name().equals("ESTUDIANTE") && u.getUsuario().equals(usuario.getUsuario())) {
			usuario.setBloqueado(0);
			usuario.setEliminado(0);
			usuario.setFechaFin(new Date());
			usuario.setRol(Rol.ESTUDIANTE);
			System.out.println("entro");
		}
		usuarioDao.updateUsuario(usuario);
		if (u.getRol().name().equals("ESTUDIANTE"))
			//TODO mirar de poner un mensaje de que se ha hecho de forma correcta
				return "redirect:../../principal/principal.html";
		return "redirect:../listar.html";
	}
	
	@RequestMapping(value="/delete/{usuario}")
	public String processDelete(HttpSession session, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "usuario/listar.html");
		if (u==null)
		return "redirect:../login.html";
		else if(u.getRol().name().equals("ADMIN")){
			usuarioDao.deleteUsuario(usuario);
			return "redirect:../listar.html";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	
	
	@RequestMapping(value = "/blockUser", method = RequestMethod.POST)
	public String blockUser(HttpServletRequest request) throws ParseException{
		
		String date= request.getParameter("blockDay");
		
		String usuario= request.getParameter("userBlock");
		
		SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
		Date fecha_fin = format.parse(date);

		usuarioDao.lockUsuario(usuario,fecha_fin);
		
		return "redirect:./listar.html";

	}
	
	
	@RequestMapping(value="/lock/{usuario}")
	public String processLock(HttpSession session, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "usuario/listar.html");
		if (u==null)
		return "redirect:../login.html";
		else if(u.getRol().name().equals("ADMIN")){
			//usuarioDao.lockUsuario(usuario,fecha_fin);
			return "redirect:../listar.html";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}
	@RequestMapping(value="/unlock/{usuario}")
	public String processUnlock(HttpSession session, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "usuario/listar.html");
		if (u==null)
		return "redirect:../login.html";
		else if(u.getRol().name().equals("ADMIN")){
			usuarioDao.unlockUsuario(usuario);
			return "redirect:../listar.html";
		}else{
			session.setAttribute("prevURL", "principal/principal.html");
			return "error/error";
		}
	}

}
