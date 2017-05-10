package controller;

import java.util.Date;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;


import modelo.Peticion;


public class PeticionValidator implements Validator{
	
	
	  @Override
	  public boolean supports(Class<?> cls) {
		  return Peticion.class.equals(cls);
	   }
	 
	  @Override
	  public void validate(Object obj, Errors errors) {
			 Peticion peticion = (Peticion)obj;
			 
			 
			 //fechaIni y fechaFin
			 if(peticion.getFechaIni().before(new Date()))
				 errors.rejectValue("fechaIni", "fechaInvalida", "		Día inicio petición no válido");
			 
			 if(peticion.getFechaFin().before(peticion.getFechaIni()))
				 errors.rejectValue("fechaFin", "fechaInvalida", "		Fecha fin es menor que fecha inicio");
			 
			 if(peticion.getFechaFin().equals(peticion.getFechaIni()))
				 errors.rejectValue("fechaIni", "fechaInvalida", "		Fecha inicio igual que fecha fin");
			 
			 if(peticion.getFechaIni().equals(peticion.getFechaFin()))
				 errors.rejectValue("fechaFin", "fechaInvalida", "		Fecha fin igual que fecha inicio");
			 
			 
			 //Descripcion			 
			 if(peticion.getDescripcion().length() > 300)
				 errors.rejectValue("descripcion",  "obligatorio", "	La descripcion debe ser menor de 300 caracteres");
			 	 
	}
}
