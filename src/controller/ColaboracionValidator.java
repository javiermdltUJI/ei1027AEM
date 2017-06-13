package controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import dao.ColaboracionDao;
import modelo.Colaboracion;

@Component 
public class ColaboracionValidator implements Validator{
	
	private ColaboracionDao colaboracionDao;
	public void setColaboracionValidator(ColaboracionDao colaboracionDao){
		this.colaboracionDao=colaboracionDao;
	}
	
	
	@Override
	public boolean supports(Class<?> cls) {
		return Colaboracion.class.equals(cls);
	}
	@Override
	public void validate(Object obj, Errors errors) {
		Colaboracion colaboracion = (Colaboracion)obj;
		//no existe oferta o peticion
		if(colaboracion.getIdOferta() !=0 || colaboracion.getIdPeticion()!=0){
		if(!colaboracionDao.existeOferta(colaboracion.getIdOferta()))
			 errors.rejectValue("idOferta", "idOfertaInvalido", "		No existe una oferta con ese id");
		else if(!colaboracionDao.existePeticion(colaboracion.getIdPeticion()))
			 errors.rejectValue("idPeticion", "idPeticionInvalido", "		No existe una petición con ese id");
		else if(!colaboracionDao.coincideHabilidad(colaboracion.getIdOferta(),colaboracion.getIdPeticion()))
			 errors.rejectValue("idOferta", "habilidadInvalida", "		No coinciden las habilidades de la oferta y la petición");
		}
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