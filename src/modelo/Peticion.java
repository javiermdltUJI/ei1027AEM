package modelo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Peticion {
	
	private int id_peticion;
	private Date fechaIni;
	private Date fechaFin;
	private String fechaIniString;
	private String fechaFinString;
	private String descripcion;
	private String usuario;
	private int id_habilidad;
	
	//Para mostrar los datos de la habilidad
	private String descripcionHabilidad;
	private Nivel nivelHabilidad;
	
	public int getIdPeticion(){ return id_peticion; }
	public void setIdPeticion(int idPeticion){ this.id_peticion = idPeticion;}
	public Date getFechaIni(){ return fechaIni; }
	public String getFechaIniString(){ 
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		return dateFormat.format(fechaIni); 
	}
	public void setFechaIni(Date fIni){ 
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		this.fechaIniString = dateFormat.format(fIni); 
		this.fechaIni = fIni;
	}
	public Date getFechaFin(){ return fechaFin; }
	public void setFechaFin(Date fFin){ 
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		this.fechaFinString = dateFormat.format(fFin); 
		this.fechaFin = fFin; 
	}
	public String getDescripcion(){ return descripcion; }
	public void setDescripcion(String descripcion){ this.descripcion = descripcion; }
	public String getUsuario(){ return usuario; }
	public void setUsuario(String usuario){ this.usuario = usuario; }
	public int getIdHabilidad(){ return id_habilidad; }
	public void setIdHabilidad(int idHab){ this.id_habilidad = idHab; }
	
	public String toString() {
		return "Petición [id_peticion=" + id_peticion + ", fechaIni=" + fechaIni + ", fechaFin="
				+ fechaFin + ", descripcion=" + descripcion + ", usuario=" + usuario + ", id_habilidad"
				+ id_habilidad + "]";
	}
	
	public String getFechaFinString() {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		return dateFormat.format(fechaFin); 
	}
	public String getDescripcionHabilidad() {
		return descripcionHabilidad;
	}
	public void setDescripcionHabilidad(String descripcionHabilidad) {
		this.descripcionHabilidad = descripcionHabilidad;
	}
	public Nivel getNivelHabilidad() {
		return nivelHabilidad;
	}
	public void setNivelHabilidad(Nivel nivelHabilidad) {
		this.nivelHabilidad = nivelHabilidad;
	}
}
