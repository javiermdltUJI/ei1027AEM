package controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Controller; 
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult; 
import org.springframework.web.bind.annotation.ModelAttribute; 
import org.springframework.web.bind.annotation.RequestMapping; 
import org.springframework.web.bind.annotation.RequestMethod;

import dao.UserDao;
import dao.UsuarioDao;
import modelo.Usuario;

import org.springframework.validation.Errors; 
import org.springframework.validation.Validator;

class UserValidator implements Validator { 	
	
    @Override
    public boolean supports(Class<?> cls) { 
        return Usuario.class.isAssignableFrom(cls);
    }
    @Override 
    public void validate(Object obj, Errors errors) {
    	Usuario userDetails = (Usuario)obj;
    	if (userDetails.getUsuario().trim().equals(""))
	           errors.rejectValue("usuario", "obligatori",
	                              "Cal introduir un valor");
		if (userDetails.getContrasenya().trim().equals(""))
	           errors.rejectValue("contrasenya", "obligatori",
	                              "Cal introduir un valor");
    }
}

@Controller
public class LoginController {
    @Autowired
    private UserDao userDao;
    
    @Autowired
	private UsuarioDao usuarioDao;

    @RequestMapping(value="/login", method=RequestMethod.GET)
    public String login(Model model, HttpSession session) {
    	if (session.getAttribute("usuarioLogin") == null) {
			session.setAttribute("usuarioLogin", new Usuario()); 
			model.addAttribute("usuarioLogin", session.getAttribute("usuarioLogin"));
			return "login";
		}
        model.addAttribute("usuarioLogin", new Usuario());
        /**
        if(session.getAttribute("perfilBloqueado")!=null){
        	model.addAttribute("perfilBloqueado", session.getAttribute("perfilBloqueado"));
        	session.removeAttribute("perfilBloqueado");
        	session.removeAttribute("usuarioLogin");
        }
        **/
        return "login";
    }

    @RequestMapping(value="/login", method=RequestMethod.POST)
    public String checkLogin(@ModelAttribute("usuarioLogin") Usuario usuario,          
                BindingResult bindingResult, HttpSession session) {
        UserValidator userValidator = new UserValidator(); 
        userValidator.validate(usuario, bindingResult); 
        if (bindingResult.hasErrors()) {
            return "login";
        }
           // Comprova que el login siga correcte 
        // intentant carregar les dades de l'usuari 
        
        if(! usuarioDao.existeUsuario(usuario.getUsuario())){
        	bindingResult.rejectValue("usuario", "badpw", "Nombre usuario invalido");
        	return "login";
        }

        usuario = userDao.loadUserByUsername(usuario.getUsuario(),usuario.getContrasenya()); 

        if (usuario == null) {
            bindingResult.rejectValue("contrasenya", "badpw", "Contraseña incorrecta"); 
            return "login";
        }
        /**
        if(usuario.getActivo() == false){
        	bindingResult.rejectValue("contrasenya", "badpw", "Usuario desactivado pongase en contacto con el administrador"); 
        	session.setAttribute("perfilBloqueado", "Su perfil está desactivado. Póngase en contacto con el administrador para más información.");
            return "login";
        }
        **/
                
        // Autenticats correctament. 
        // Guardem les dades de l'usuari autenticat a la sessio
        session.setAttribute("usuarioLogin", usuario); 
            
        // Torna a la pagina principal
        String url = (String) session.getAttribute("nextUrl");
        if ( url != null){
        	session.removeAttribute("nextUrl");
        	return "redirect:" + url;
        }else{
        	if (usuario.getRol().name().equals("ESTUDIANTE"))
        		return "redirect:principal/index.html";
        	else //Para administradores
        		return "redirect:principal/index.html";
        }
    }

    @RequestMapping("/logout") 
    public String logout(HttpSession session) {//capturar evento pag atras comprobar sesion
        session.invalidate(); 
        return "redirect:index.jsp";
    }
}

