package modelo;

public class Estudiante {
	
	private String usuario;
	private String contrasenya;
	private String correo;
	private String nombre;
	private String dni;
	private int contadorBloqueo = 0;
	private int bloqueado = 0;
	
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
	public int getContadorBloqueo(){ return contadorBloqueo; }
	public void setContadorBloqueo(int cont){
		if(contadorBloqueo < 3){
			this.contadorBloqueo = cont;
		}else{
			this.bloqueado = 1;
		}
	}
	public int getBloqueado(){ return bloqueado; }
	public void setBloqueado(int bloq){
		if(bloq <= 1){
			this.bloqueado = bloq;
		}
	}
	
	@Override
	public String toString() {
		return "Estudiante [usuario=" + usuario + ", contrasenya=" + contrasenya + ", correo="
				+ correo + ", nombre=" + nombre + ", dni=" + dni + ", contadorBloqueo"
				+ contadorBloqueo + ", bloqueado=" + bloqueado + "]";
	}
}
