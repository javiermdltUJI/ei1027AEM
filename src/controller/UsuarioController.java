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
		if(u != null && u.getRol().name().equals("ADMIN")){
			model.addAttribute("usuarios", usuarioDao.getUsuarios());
			return "usuario/listar";
		}else{
			return "error/error";
		}
	}
	
	@RequestMapping(value="/add")
	public String addUsuario(HttpSession session, Model model){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u == null || u.getRol().name().equals("ADMIN")){
			model.addAttribute("usuario", new Usuario());
			return "usuario/add";
		}else{
			return "error/error";
		}
	}

	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String processAddSubmit(HttpSession session, @ModelAttribute("usuario") Usuario usuario, BindingResult bindingResult){
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
		usuarioDao.addUsuario(usuario);
		return "redirect:listar.html";
	}
	
	@RequestMapping(value="/update/{usuario}", method = RequestMethod.GET)
	public String editUsuario(HttpSession session, Model model, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null && (u.getUsuario().equals(usuario) || u.getRol().name().equals("ADMIN"))){
			model.addAttribute("usuario", usuarioDao.getUsuario(usuario));
			return "usuario/update";				
		}else{
			return "error/error";
		}
	}
	
	@RequestMapping(value="/update/{nom_usuario}", method = RequestMethod.POST)
	public String processUpdateSubmit(HttpSession session, @PathVariable String nom_usuario, @ModelAttribute("usuario") Usuario usuario, BindingResult bindingResult){
		if(bindingResult.hasErrors())
			return "usuario/update";
		usuarioDao.updateUsuario(usuario);
		return "redirect:../listar.html";
	}
	
	@RequestMapping(value="/delete/{usuario}")
	public String processDelete(HttpSession session, @PathVariable String usuario){
		Usuario u = (Usuario) session.getAttribute("usuario");
		if(u != null && u.getRol().name().equals("ADMIN")){
			usuarioDao.deleteUsuario(usuario);
			return "redirect:../listar.html";
		}else{
			return "error/error";
		}
	}

}
