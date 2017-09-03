package modelo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Colaboracion {

	private int id_colaboracion;
	private Date fechaIni;
	private Date fechaFin;
	private String fechaIniString;
	private String fechaFinString;	
	private int horasTotales;
	private int valoracion;
	private int id_oferta;
	private int id_peticion;
	private String ofertante;
	private String demandante;
	private Nivel nivel;
	private String descripcion;
	private int idHabilidad;
	
	public int getIdColaboracion(){ return id_colaboracion; }
	public void setIdColaboracion(int id_colaboracion){ this.id_colaboracion = id_colaboracion;}
	public Date getFechaIni(){ return fechaIni; }
	public void setFechaIni(Date fIni){ 
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		this.fechaIniString = dateFormat.format(fIni); 
		this.fechaIni = fIni;
	}
	public String getFechaIniString(){ 
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		return dateFormat.format(fechaIni); 
	}
	
	public Date getFechaFin(){ return fechaFin; }
	public void setFechaFin(Date fFin){ 
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		this.fechaFinString = dateFormat.format(fFin); 
		this.fechaFin = fFin;
	}
	public String getFechaFinString() {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		return dateFormat.format(fechaFin); 
	}
	
	public int getHorasTotales(){ return horasTotales; }
	public void setHorasTotales(int horasTotales){ this.horasTotales = horasTotales; }
	public int getValoracion(){ return valoracion; }
	public void setValoracion(int valoracion){ this.valoracion = valoracion; }
	public int getIdOferta(){ return id_oferta; }
	public void setIdOferta(int id_oferta){ this.id_oferta = id_oferta; }
	public int getIdPeticion(){ return id_peticion; }
	public void setIdPeticion(int id_peticion){ this.id_peticion = id_peticion; }
	
	
	
	public String toString() {
		return "Colaboracion [id_colaboracion=" + id_colaboracion + ", fechaIni=" + fechaIni + ", fechaFin="
				+ fechaFin + ", horasTotales=" + horasTotales + ", valoracion=" + valoracion + ", id_oferta="
				+ id_oferta + ", id_peticion = " + id_peticion + "]";
	}
	public String getOfertante() { return ofertante; }
	public void setOfertante(String ofertante) { this.ofertante = ofertante; }

	public String getDemandante() { return demandante; }
	public void setDemandante(String demandante) { this.demandante = demandante; }
	
	public String getDescripcion() { return descripcion; }
	public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
		
	public Nivel getNivel() { return nivel; }
	public void setNivel(Nivel nivel) { this.nivel = nivel; }
	public int getIdHabilidad() { return idHabilidad; }
	public void setIdHabilidad(int idHabilidad) { this.idHabilidad = idHabilidad; }

}
