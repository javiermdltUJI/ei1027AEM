package modelo;

public class Habilidad {
	
	private int id_habilidad;
	private String nombre;
	private String tipo;
	private String descripcion;
	private Nivel nivel;
	private Estado estado;
	
	public int getIdHabilidad(){ return id_habilidad; }
	public void setIdHabilidad(int id_habilidad){ this.id_habilidad = id_habilidad; }
	public String getNombre(){ return nombre; }
	public void setNombre(String nombre){ this.nombre = nombre; }
	public String getTipo(){ return tipo; }
	public void setTipo(String tipo){ this.tipo = tipo; }
	public String getDescripcion(){ return descripcion; }
	public void setDescripcion(String descripcion){ this.descripcion = descripcion; }
	public Nivel getNivel(){ return nivel; }
	public void setNivel(Nivel nivel){ this.nivel = nivel; }
	public Estado getEstado(){ return estado; }
	public void setEstado(Estado estado){this.estado = estado; }

	@Override
	public String toString() {
		return "Habilidad [id_habilidad=" + id_habilidad + ", nombre=" + nombre + ", tipo="
				+ tipo + ", descripcion=" + descripcion + ", nivel=" + nivel + ", estado"
				+ estado + "]";
	}
}