package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dao.EstudianteDao;

@Controller
@RequestMapping("/estudiante")
public class EstudianteController {
	
	private EstudianteDao estudianteDao;
	
	@Autowired
	public void setEstudianteDao(EstudianteDao estudianteDao){
		this.estudianteDao = estudianteDao;
	}
	
	@RequestMapping("/listar")
	public String listaEstudiantes(Model model){
		model.addAttribute("estudiantes", estudianteDao.getEstudiantes());
		return "estudiante/listar";
	}
	

}
