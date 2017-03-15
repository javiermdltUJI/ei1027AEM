package modelo;

import java.util.Date;

public class Peticion {
	
	int id_peticion;
	Date fechaIni;
	Date fechaFin;
	String descripcion;
	String usuario;
	int id_habilidad;
	
	public int getIdPeticion(){ return id_peticion; }
	public void setIdPeticion(int idPeticion){ this.id_peticion = idPeticion;}
	public Date getFechaIni(){ return fechaIni; }
	public void setFechaIni(Date fIni){ this.fechaIni = fIni;}
	public Date getFechaFin(){ return fechaFin; }
	public void setFechaFin(Date fFin){ this.fechaFin = fFin; }
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

}
