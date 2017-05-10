package controller;

import java.util.Date;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import modelo.Oferta;

public class OfertaValidator implements Validator {

	@Override
	public boolean supports(Class<?> cls) {
		return Oferta.class.equals(cls);
	}

	@Override
	public void validate(Object obj, Errors errors) {
		Oferta oferta = (Oferta)obj;
		
		 
		 //fechaIni y fechaFin
		 if(((oferta.getFechaIni()) == null) || (oferta.getFechaFin() == null)){
			 errors.rejectValue("fechaIni",  "obligatorio", "Valor requerido");
			 errors.rejectValue("fechaFin", "obligatorio", "Valor requerido");
		 }else{
			 if(oferta.getFechaIni().before(new Date()))
				 errors.rejectValue("fechaIni", "fechaInvalida", "		Día inicio Oferta no válido");
			 
			 if(oferta.getFechaFin().before(oferta.getFechaIni()))
				 errors.rejectValue("fechaFin", "fechaInvalida", "		Fecha fin es menor que fecha inicio");
			 
			 if(oferta.getFechaFin().equals(oferta.getFechaIni()))
				 errors.rejectValue("fechaIni", "fechaInvalida", "		Fecha inicio igual que fecha fin");
			 
			 if(oferta.getFechaIni().equals(oferta.getFechaFin()))
				 errors.rejectValue("fechaFin", "fechaInvalida", "		Fecha fin igual que fecha inicio");
		 }
		
		 //Descripcion
		 if(oferta.getDescripcion().trim().equals(""))
			 errors.rejectValue("descripcion", "obligatorio", "		Valor requerido");
		 
		 if(oferta.getDescripcion().length() > 300)
			 errors.rejectValue("descripcion",  "obligatorio", "	La descripcion debe ser menor de 300 caracteres");
		 
		 //idHabilidad
		 String p = ""+oferta.getIdHabilidad();

		 if(p.trim().equals(""))
			 errors.rejectValue("idHabilidad", "obligatorio", "		Valor requerido");

		
	}

}
