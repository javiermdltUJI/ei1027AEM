package modelo;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class Usuario {
	
	private String usuario;
	private String contrasenya;
	private String correo;
	private String nombre;
	private String dni;
	private int eliminado = 0;
	private int bloqueado = 0;
	
	 @DateTimeFormat(pattern = "dd-MM-yyyy")
	private Date fechaFin;
	private String fechaFinString;
	private Rol rol;
	
	public String getUsuario(){ return usuario; }
	public void setUsuario(String usuario){ this.usuario = usuario; }
	public String getContrasenya(){ return contrasenya; }
	public void setContrasenya(String contrasenya){ this.contrasenya = contrasenya; }
	public String getCorreo(){ return correo; }
	public void setCorreo(String correo){ this.correo = correo; }
	public String getNombre(){ return nombre; }
	public void setNombre(String nombre){ this.nombre = nombre; }
	public String getDni(){ return dni; }
	public void setDni(String dni){ this.dni = dni; }
	public int getEliminado() { return eliminado; }
	public void setEliminado(int eliminado) { this.eliminado = eliminado; }
	public int getBloqueado(){ return bloqueado; }
	public void setBloqueado(int bloq){
		if(bloq <= 1){
			this.bloqueado = bloq;
		}
	}
	public Date getFechaFin() { return fechaFin; }
	
	public void setFechaFin(String fFin) throws ParseException{
		this.fechaFinString = fFin;
		DateFormat format = new SimpleDateFormat("dd-MM-yyyy");
		this.fechaFin=format.parse(fFin);
	}
	public void setFechaFin(Date fFin){
		if(fFin!=null){
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			this.fechaFinString = dateFormat.format(fFin); 
			this.fechaFin = fFin;
		}
	}
	public String getFechaFinString() {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		return dateFormat.format(fechaFin); 
	}
	public Rol getRol() {
		return rol;
	}
	public void setRol(Rol rol) {
		this.rol = rol;
	}
	
	@Override
	public String toString() {
		return "Usuario [usuario=" + usuario + ", contrasenya=" + contrasenya + ", correo=" + correo + ", nombre="
				+ nombre + ", dni=" + dni + ", eliminado=" + eliminado + ", bloqueado=" + bloqueado + ", fechaFin="
				+ fechaFin + ", fechaFinString=" + fechaFinString + ", rol=" + rol + "]";
	}
	
}
