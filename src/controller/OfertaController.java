package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dao.OfertaDao;
import modelo.Habilidad;
import modelo.Oferta;

@Controller
@RequestMapping("/oferta")
public class OfertaController {
	
	private OfertaDao ofertaDao;
	
	@Autowired
	public void setHabilidadDao(OfertaDao ofertaDao){
		this.ofertaDao = ofertaDao;
	}
	
	@RequestMapping("/listar")
	public String listaOferta(Model model){
		model.addAttribute("ofertas", ofertaDao.getOfertas());
		return "oferta/listar";
	}

	@RequestMapping(value="/add")
	public String addOferta(Model model){
		model.addAttribute("oferta", new Oferta());
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
	public String editHabilidad(Model model, @PathVariable int id_oferta){
			model.addAttribute("oferta", ofertaDao.getOferta(id_oferta));
			return "oferta/update";	
	}
	
	@RequestMapping(value="/update/{id_oferta}", method = RequestMethod.POST)
	public String processUpdateSubmit(@PathVariable int id_oferta, @ModelAttribute("oferta") Oferta oferta, BindingResult bindingResult){
	//	if(bindingResult.hasErrors())
		//	return "habilidad/update";
		//habilidad.setIdHabilidad(id_habilidad);
		ofertaDao.updateOferta(oferta);
		return "redirect:../listar.html";
	}
	
	@RequestMapping(value="/delete/{id_oferta}")
	public String processDelete(@PathVariable int id_oferta){
		ofertaDao.deleteOferta(id_oferta);
		return "redirect:../listar.html";
	}
}
