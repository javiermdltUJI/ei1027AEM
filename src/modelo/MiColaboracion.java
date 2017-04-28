package modelo;

import java.util.Date;

public class MiColaboracion {

	private int id_colaboracion;
	private Date fechaIni;
	private Date fechaFin;
	private int horasTotales;
	private int valoracion;
	private int id_oferta;
	private int id_peticion;
	private String descripcion;
	private String usuario;
	
	public int getIdColaboracion(){ return id_colaboracion; }
	public void setIdColaboracion(int id_colaboracion){ this.id_colaboracion = id_colaboracion;}
	public Date getFechaIni(){ return fechaIni; }
	public void setFechaIni(Date fIni){ this.fechaIni = fIni;}
	public Date getFechaFin(){ return fechaFin; }
	public void setFechaFin(Date fFin){ this.fechaFin = fFin; }
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
				+ fechaFin + ", horasTotales=" + horasTotales + ", valoracion=" + valoracion + ", id_oferta"
				+ id_oferta + ", id_peticion" + id_peticion + "]";
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
}
