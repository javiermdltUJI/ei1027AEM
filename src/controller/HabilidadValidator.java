package controller;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import modelo.Estado;
import modelo.Habilidad;
import modelo.Nivel;

public class HabilidadValidator implements Validator{

	
	private int id_habilidad;
	private String nombre;
	private String tipo;
	private String descripcion;
	private Nivel nivel;
	private Estado estado;
	
	@Override
	public boolean supports(Class<?> cls) {
		return Habilidad.class.equals(cls);
	}
	
	@Override
	public void validate(Object obj, Errors errors) {
		
		Habilidad habilidad = (Habilidad)obj;
		
		
		//nombre
		if(habilidad.getNombre().trim().equals(""))
			errors.rejectValue("nombre", "obligatorio", "Valor requerido");
		
		if(habilidad.getNombre().length() > 50)
			errors.rejectValue("nombre", "obligatorio", "El nombre no puede superar los 50 carácteres");
		
		
		//tipo
		if(habilidad.getTipo().trim().equals(""))
			errors.rejectValue("tipo", "obligatorio", "Valor requerido");
		
		if(habilidad.getTipo().length() > 50)
			errors.rejectValue("tipo", "obligatorio", "El tipo no puede superar los 50 carácteres");

		if(habilidad.getDescripcion().trim().equals(""))
			errors.rejectValue("descripcion", "obligatorio", "Valor requerido");
		
		if(habilidad.getDescripcion().length() > 300)
			errors.rejectValue("descripcion", "obligatorio", "La descripción no puede superar los 300 carácteres");		
	}	
}