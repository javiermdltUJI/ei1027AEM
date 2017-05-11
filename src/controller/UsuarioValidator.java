package controller;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import modelo.Usuario;

public class UsuarioValidator implements Validator{
	
	private static final String PATTERN_EMAIL = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
            + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";

	@Override
	public boolean supports(Class<?> cls){
		return Usuario.class.equals(cls);
	}
	
	@Override
	public void validate(Object obj, Errors errors){
		Usuario usuario = (Usuario) obj;
		
		Pattern pattern = Pattern.compile(PATTERN_EMAIL);
		Matcher matcher = pattern.matcher(usuario.getCorreo());
				
		
		//Contraseña

		if(usuario.getContrasenya().length()<7)
			errors.rejectValue("contrasenya", "obligatorio", "		La contrase�a debe contener como m�nimo 8 d�gitos");
		
		if(usuario.getContrasenya().length()>50)
			errors.rejectValue("contrasenya", "obligatorio", "		La contrase�a�a debe contener como m�ximo 50 d�gitos");
		
		
		//Correo
		if(!matcher.matches())
			errors.rejectValue("correo","obligatorio", "		Formato incorrecto, ej:algo@algo.algo");
		
		
		//Nombre
		if(usuario.getNombre().length() > 50)
			errors.rejectValue("nombre", "obligatorio", "		El nombre no puede superar los 50 carácteres");
		
		
		//DNI
		if(usuario.getDni().length() != 9)
			errors.rejectValue("dni", "obligatorio", "		El DNI contiene 9 dígitos");
	
		//contadorBloqueo
		if(usuario.getContadorBloqueo() < 0 || usuario.getContadorBloqueo() >3)
			errors.rejectValue("contadorBloqueo", "obligatorio", "		El contador debe ser un número entre 0 y 3");
		
		//bloqueado
		if(usuario.getBloqueado() < 0 || usuario.getBloqueado() > 1)
			errors.rejectValue("bloqueado", "obligatorio", "		El usuario bloqueado solo puede ser 0 ó 1");
	}
}
