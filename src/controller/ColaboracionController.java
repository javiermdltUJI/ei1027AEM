package controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dao.ColaboracionDao;
import modelo.Colaboracion;


//El formato de las fechas es dd-mm-yyyy. En caso contrario APOCALIPSIS!!!!

@Controller
@RequestMapping("/colaboracion")
public class ColaboracionController {
	
	private ColaboracionDao colaboracionDao;
	
	@Autowired
	public void setHabilidadDao(ColaboracionDao colaboracionDao){
		this.colaboracionDao = colaboracionDao;
	}
	
	@RequestMapping("/listar")
	public String listaColaboracion(Model model){
		model.addAttribute("colaboraciones", colaboracionDao.getColaboraciones());
		return "colaboracion/listar";
	}

	@RequestMapping(value="/add")
	public String addColaboracion(Model model){
		model.addAttribute("colaboracion", new Colaboracion());
		return "colaboracion/add";
	}

	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String processAddSubmit(@ModelAttribute("colaboracion") Colaboracion colaboracion, BindingResult bindingResult){
		//if(bindingResult.hasErrors())
		//	return "habilidad/add";
		colaboracionDao.addColaboracion(colaboracion);
		return "redirect:listar.html";
	}
	
	@RequestMapping(value="/update/{id_colaboracion}", method = RequestMethod.GET)
	public String editColaboracion(Model model, @PathVariable int id_colaboracion){
			model.addAttribute("colaboracion", colaboracionDao.getColaboracion(id_colaboracion));
			return "colaboracion/update";	
	}
	
	@RequestMapping(value="/update/{id_colaboracion}", method = RequestMethod.POST)
	public String processUpdateSubmit(@PathVariable int id_colaboracion, @ModelAttribute("colaboracion") Colaboracion colaboracion, BindingResult bindingResult){
	//	if(bindingResult.hasErrors())
		//	return "habilidad/update";
		//habilidad.setIdHabilidad(id_habilidad);
		colaboracionDao.updateColaboracion(colaboracion);
		return "redirect:../listar.html";
	}
	
	@RequestMapping(value="/delete/{id_colaboracion}")
	public String processDelete(@PathVariable int id_colaboracion){
		colaboracionDao.deleteColaboracion(id_colaboracion);
		return "redirect:../listar.html";
	}
	
	/*formateo de fechas	 */
	@InitBinder
	public void initBinder(WebDataBinder webDataBinder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		dateFormat.setLenient(false);
		webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

}
