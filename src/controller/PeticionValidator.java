package controller;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.ibm.icu.text.SimpleDateFormat;

import modelo.Peticion;


public class PeticionValidator implements Validator{
	@Override
	  public boolean supports(Class<?> cls) {
		  return Peticion.class.equals(cls);
		 // o, si volguérem tractar també les subclasses: 
		 // return Nadador.class.isAssignableFrom(cls);
	   }
	 
	  @Override
	  public void validate(Object obj, Errors errors) {
			 Peticion peticion = (Peticion)obj;
			 System.out.println(peticion.getFechaFin());
			 
		 
	}
}
