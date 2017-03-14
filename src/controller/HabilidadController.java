package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dao.HabilidadDao;
import modelo.Habilidad;

@Controller
@RequestMapping("/habilidad")
public class HabilidadController {
	
	private HabilidadDao habilidadDao;
	
	@Autowired
	public void setHabilidadDao(HabilidadDao habilidadDao){
		this.habilidadDao = habilidadDao;
	}
	
	@RequestMapping("/listar")
	public String listaHabilidad(Model model){
		model.addAttribute("habilidades", habilidadDao.getHabilidades());
		return "habilidad/listar";
	}


	@RequestMapping(value="/add")
	public String addHabilidad(Model model){
		model.addAttribute("habilidad", new Habilidad());
		return "habilidad/add";
	}

	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String processAddSubmit(@ModelAttribute("habilidad") Habilidad habilidad, BindingResult bindingResult){
		//if(bindingResult.hasErrors())
		//	return "habilidad/add";
		habilidadDao.addHabilidad(habilidad);
		return "redirect:listar.html";
	}
	
	@RequestMapping(value="/update/{id_habilidad}", method = RequestMethod.GET)
	public String editHabilidad(Model model, @PathVariable int id_habilidad){
			model.addAttribute("habilidad", habilidadDao.getHabilidad(id_habilidad));
			return "habilidad/update";	
	}
	
	@RequestMapping(value="/update/{id_habilidad}", method = RequestMethod.POST)
	public String processUpdateSubmit(@PathVariable int id_habilidad, @ModelAttribute("habilidad") Habilidad habilidad, BindingResult bindingResult){
	//	if(bindingResult.hasErrors())
		//	return "habilidad/update";
		//habilidad.setIdHabilidad(id_habilidad);
		habilidadDao.updateHabilidad(habilidad);
		return "redirect:../listar.html";
	}
	
	@RequestMapping(value="/delete/{id_habilidad}")
	public String processDelete(@PathVariable int id_habilidad){
		habilidadDao.deleteHabilidad(id_habilidad);
		return "redirect:../listar.html";
	}
}