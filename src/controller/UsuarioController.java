package controller;

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
	public String listaUsuarios(Model model){
		model.addAttribute("usuarios", usuarioDao.getUsuarios());
		return "usuario/listar";
	}
	
	@RequestMapping(value="/add")
	public String addUsuario(Model model){
		model.addAttribute("usuario", new Usuario());
		return "usuario/add";
	}

	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String processAddSubmit(@ModelAttribute("usuario") Usuario usuario, BindingResult bindingResult){
		if(bindingResult.hasErrors())
			return "usuario/add";
		usuarioDao.addUsuario(usuario);
		return "redirect:listar.html";
	}
	
	@RequestMapping(value="/update/{usuario}", method = RequestMethod.GET)
	public String editUsuario(Model model, @PathVariable String usuario){
			model.addAttribute("usuario", usuarioDao.getUsuario(usuario));
			return "usuario/update";	
	}
	
	@RequestMapping(value="/update/{nom_usuario}", method = RequestMethod.POST)
	public String processUpdateSubmit(@PathVariable String nom_usuario, @ModelAttribute("usuario") Usuario usuario, BindingResult bindingResult){
		if(bindingResult.hasErrors())
			return "usuario/update";
		usuarioDao.updateUsuario(usuario);
		return "redirect:../listar.html";
	}
	
	@RequestMapping(value="/delete/{usuario}")
	public String processDelete(@PathVariable String usuario){
		usuarioDao.deleteUsuario(usuario);
		return "redirect:../listar.html";
	}

}
