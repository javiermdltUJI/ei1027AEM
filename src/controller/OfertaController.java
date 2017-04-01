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

import dao.HabilidadDao;
import dao.OfertaDao;
import modelo.Oferta;


//El formato de las fechas es dd-mm-yyyy. En caso contrario APOCALIPSIS!!!!

@Controller
@RequestMapping("/oferta")
public class OfertaController {
	
	private OfertaDao ofertaDao;
	
	private HabilidadDao habilidadDao;

	
	@Autowired
	public void setOfertaDao(OfertaDao ofertaDao){
		this.ofertaDao = ofertaDao;
	}
	
	@Autowired
	public void setHabilidadDao(HabilidadDao habilidadDao){
		this.habilidadDao=habilidadDao;
	}
	
	
	@RequestMapping("/listar")
	public String listaOferta(Model model){
		model.addAttribute("ofertas", ofertaDao.getOfertas());
		return "oferta/listar";
	}

	@RequestMapping(value="/add")
	public String addOferta(Model model){
		model.addAttribute("oferta", new Oferta());
		model.addAttribute("habilidades", habilidadDao.getHabilidades());
		return "oferta/add";
	}

	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String processAddSubmit(@ModelAttribute("oferta") Oferta oferta, BindingResult bindingResult){
		//if(bindingResult.hasErrors())
		//	return "habilidad/add";
		ofertaDao.addOferta(oferta);
		return "redirect:listar.html";
	}
	
	@RequestMapping(value="/update/{id_oferta}", method = RequestMethod.GET)
	public String editOferta(Model model, @PathVariable int id_oferta){
			model.addAttribute("oferta", ofertaDao.getOferta(id_oferta));
			model.addAttribute("habilidades", habilidadDao.getHabilidades());
			return "oferta/update";	
	}
	
	@RequestMapping(value="/update/{id_oferta}", method = RequestMethod.POST)
	public String processUpdateSubmit(@PathVariable int id_oferta, @ModelAttribute("oferta") Oferta oferta, BindingResult bindingResult){
	//	if(bindingResult.hasErrors())
		//	return "habilidad/update";
		//habilidad.setIdHabilidad(id_habilidad);
		//System.out.println(oferta.toString());
		ofertaDao.updateOferta(oferta);
		return "redirect:../listar.html";
	}
	
	@RequestMapping(value="/delete/{id_oferta}")
	public String processDelete(@PathVariable int id_oferta){
		ofertaDao.deleteOferta(id_oferta);
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
