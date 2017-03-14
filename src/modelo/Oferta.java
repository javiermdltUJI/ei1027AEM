package modelo;

import java.util.Date;

public class Oferta {
	
	int id_oferta;
	Date fecha_ini;
	Date fecha_fin;
	String descripcion;
	String usuario;
	int id_habilidad;
	
	public int getIdOferta(){ return id_oferta; }
	public void setIdOferta(int idOferta){ this.id_oferta = idOferta;}
	public Date getFechaIni(){ return fecha_ini; }
	public void setFechaIni(Date fIni){ this.fecha_ini = fIni;}
	public Date getFechaFin(){ return fecha_fin; }
	public void setFechaFin(Date fFin){ this.fecha_fin = fFin; }
	public String getDescripcion(){ return descripcion; }
	public void setDescripcion(String descripcion){ this.descripcion = descripcion; }
	public String getUsuario(){ return usuario; }
	public void setUsuario(String usuario){ this.usuario = usuario; }
	public int getIdHabilidad(){ return id_habilidad; }
	public void setIdHabilidad(int idHab){ this.id_habilidad = idHab; }
	
	public String toString() {
		return "Oferta [id_oferta=" + id_oferta + ", fecha_ini=" + fecha_ini + ", fecha_fin="
				+ fecha_fin + ", descripcion=" + descripcion + ", usuario=" + usuario + ", id_habilidad"
				+ id_habilidad + "]";
	}
}