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
import modelo.Estudiante;

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
	
	@RequestMapping(value="/add")
	public String addEstudiante(Model model){
		model.addAttribute("estudiante", new Estudiante());
		return "estudiante/add";
	}

	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String processAddSubmit(@ModelAttribute("estudiante") Estudiante estudiante, BindingResult bindingResult){
		if(bindingResult.hasErrors())
			return "estudiante/add";
		estudianteDao.addEstudiante(estudiante);
		return "redirect:listar.html";
	}
	
	@RequestMapping(value="/update/{usuario}", method = RequestMethod.GET)
	public String editEstudiante(Model model, @PathVariable String usuario){
			model.addAttribute("estudiante", estudianteDao.getEstudiante(usuario));
			return "estudiante/update";	
	}
	
	@RequestMapping(value="/update/{usuario}", method = RequestMethod.POST)
	public String processUpdateSubmit(@PathVariable String usuario, @ModelAttribute("estudiante") Estudiante estudiante, BindingResult bindingResult){
		if(bindingResult.hasErrors())
			return "estudiante/update";
		estudianteDao.updateEstudiante(estudiante);
		return "redirect:../listar.html";
	}
	
	@RequestMapping(value="/delete/{usuario}")
	public String processDelete(@PathVariable String usuario){
		estudianteDao.deleteEstudiante(usuario);
		return "redirect:../listar.html";
	}

}
