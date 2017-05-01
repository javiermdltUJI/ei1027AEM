package modelo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Oferta {
	
	private int id_oferta;
	private Date fechaIni;
	private Date fechaFin;
	private String fechaIniString;
	private String fechaFinString;
	private String descripcion;
	private String usuario;
	private int id_habilidad;
	
	public int getIdOferta(){ return id_oferta; }
	public void setIdOferta(int idOferta){ this.id_oferta = idOferta;}
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
	
	public String getDescripcion(){ return descripcion; }
	public void setDescripcion(String descripcion){ this.descripcion = descripcion; }
	public String getUsuario(){ return usuario; }
	public void setUsuario(String usuario){ this.usuario = usuario; }
	public int getIdHabilidad(){ return id_habilidad; }
	public void setIdHabilidad(int idHab){ this.id_habilidad = idHab; }
	
	public String toString() {
		return "Oferta [id_oferta=" + id_oferta + ", fechaIni=" + fechaIni + ", fechaFin="
				+ fechaFin + ", descripcion=" + descripcion + ", usuario=" + usuario + ", id_habilidad"
				+ id_habilidad + "]";
	}
}