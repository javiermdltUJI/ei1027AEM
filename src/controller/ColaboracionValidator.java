package controller;

import java.util.Date;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import modelo.Colaboracion;

public class ColaboracionValidator implements Validator{
	
	@Override
	public boolean supports(Class<?> cls) {
		return Colaboracion.class.equals(cls);
	}
	@Override
	public void validate(Object obj, Errors errors) {
		Colaboracion colaboracion = (Colaboracion)obj;
		
		//fechaIni y fechaFin
		if(colaboracion.getFechaIni().before(new Date()))
			 errors.rejectValue("fechaIni", "fechaInvalida", "		Día inicio petición no válido");
		 
		 if(colaboracion.getFechaFin().before(colaboracion.getFechaIni()))
			 errors.rejectValue("fechaFin", "fechaInvalida", "		Fecha fin es menor que fecha inicio");
		 
		 if(colaboracion.getFechaFin().equals(colaboracion.getFechaIni()))
			 errors.rejectValue("fechaIni", "fechaInvalida", "		Fecha inicio igual que fecha fin");
		 
		 if(colaboracion.getFechaIni().equals(colaboracion.getFechaFin()))
			 errors.rejectValue("fechaFin", "fechaInvalida", "		Fecha fin igual que fecha inicio");
		 
	}
}