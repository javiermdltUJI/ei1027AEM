package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	public String processAddSubmit(@ModelAttribute("usuario") Usuario usuario, BindingResult bindingResult, HttpSession session){
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
		if (u==null || !u.getRol().name().equals("ADMIN")){
				usuario.setBloqueado(0);
				usuario.setContadorBloqueo(0);
				usuario.setRol(Rol.ESTUDIANTE);
		}
		usuarioDao.addUsuario(usuario);
		return "redirect:listar.html";
	}
	
	@RequestMapping(value="/update/{usuario}", method = RequestMethod.GET)
	public String editUsuario(HttpSession session, Model model, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		session.setAttribute("prevURL", "usuario/update/"+usuario+".html");
		if (u==null)
			return "redirect:../login.html";
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
		UsuarioValidator usuarioValidator = new UsuarioValidator();
		usuarioValidator.validate(usuario, bindingResult);
		if(bindingResult.hasErrors()){
			session.setAttribute("feedback", "Hay campos incorrectos o falta rellenar");
			return "usuario/update";
		}
		usuarioDao.updateUsuario(usuario);
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

}
