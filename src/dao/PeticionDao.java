package dao;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.sql.ResultSet;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import modelo.Nivel;
import modelo.Peticion;


@Repository
public class PeticionDao {
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public void setDataSource(DataSource dataSource){
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	private static final class PeticionMapper implements RowMapper<Peticion>{
		public Peticion mapRow(ResultSet rs, int rowNum) throws SQLException{
			Peticion peticion = new Peticion();
			peticion.setIdPeticion(rs.getInt("id_peticion"));
			peticion.setFechaIni(toDate(rs.getTimestamp("fecha_ini")));
			peticion.setFechaFin(toDate(rs.getTimestamp("fecha_fin")));
			peticion.setDescripcion(rs.getString("descripcion"));
			peticion.setUsuario(rs.getString("usuario"));
			peticion.setIdHabilidad(rs.getInt("id_habilidad"));
			return peticion;
		}
	}
	
	private static final class PeticionConHabilidadMapper implements RowMapper<Peticion>{
		public Peticion mapRow(ResultSet rs, int rowNum) throws SQLException{
			Peticion peticion = new Peticion();
			peticion.setIdPeticion(rs.getInt("id_peticion"));
			peticion.setFechaIni(toDate(rs.getTimestamp("fecha_ini")));
			peticion.setFechaFin(toDate(rs.getTimestamp("fecha_fin")));
			peticion.setDescripcion(rs.getString("descripcion"));
			peticion.setUsuario(rs.getString("usuario"));
			peticion.setIdHabilidad(rs.getInt("id_habilidad"));
			peticion.setDescripcionHabilidad(rs.getString("nombre"));
			peticion.setNivelHabilidad(Nivel.valueOf(rs.getString("nivel")));
			return peticion;
		}
	}
	
	
	public List<Peticion> getPeticiones(){
		return this.jdbcTemplate.query("select peticion.id_habilidad, id_peticion, fecha_ini, fecha_fin, peticion.descripcion, usuario, habilidad.descripcion AS nombre, nivel from peticion JOIN habilidad USING (id_habilidad) ORDER BY fecha_ini, fecha_fin asc", new PeticionConHabilidadMapper());
	}
	
	//Devuelve las peticiones no hechas por mi
	public List<Peticion> getPeticiones(String usuario){
		return this.jdbcTemplate.query("select peticion.id_habilidad, id_peticion, fecha_ini, fecha_fin, peticion.descripcion, usuario, habilidad.descripcion AS nombre, nivel from peticion JOIN habilidad USING (id_habilidad) where usuario!=? ORDER BY fecha_ini, fecha_fin asc", new Object[] {usuario}, new PeticionConHabilidadMapper());
	}
	
	//Devuelve mis peticiones
	public List<Peticion> getMisPeticiones(String usuario){
		return this.jdbcTemplate.query("select peticion.id_habilidad, id_peticion, fecha_ini, fecha_fin, peticion.descripcion, usuario, habilidad.descripcion AS nombre, nivel from peticion JOIN habilidad USING (id_habilidad)  where usuario=? ORDER BY fecha_ini, fecha_fin asc", new Object[] {usuario}, new PeticionConHabilidadMapper());
	}
	
	
	public Peticion getPeticion(int id_peticion) {
		return this.jdbcTemplate.queryForObject("select * from peticion where id_peticion=?",  new Object[] {id_peticion}, new PeticionMapper());
	}
	
	
	public void addPeticion(Peticion peticion){
		this.jdbcTemplate.update("insert into Peticion(fecha_ini, fecha_fin, descripcion, usuario, id_habilidad) values( ?, ?, ?, ?, ?)", 
				peticion.getFechaIni(), peticion.getFechaFin(), peticion.getDescripcion(), peticion.getUsuario(), peticion.getIdHabilidad());
	}
	
	public int addPeticionInt(Peticion peticion){
		return this.jdbcTemplate.queryForObject("insert into Peticion(fecha_ini, fecha_fin, descripcion, usuario, id_habilidad) values( ?, ?, ?, ?, ?) returning id_peticion",
				new Object[] {peticion.getFechaIni(), peticion.getFechaFin(), peticion.getDescripcion(), peticion.getUsuario(), peticion.getIdHabilidad()},Integer.class);
	}
	
	public void updatePeticion(Peticion peticion){
		this.jdbcTemplate.update("update Peticion set fecha_ini = ?, fecha_fin = ?,  descripcion = ?, usuario = ?, id_habilidad = ? where id_peticion = ?", 
				peticion.getFechaIni(), peticion.getFechaFin(), peticion.getDescripcion(), peticion.getUsuario(), peticion.getIdHabilidad(), peticion.getIdPeticion());
	}
	
	public void deletePeticion(int peticion){
		this.jdbcTemplate.update("delete from peticion where id_peticion = ?", peticion);
	}

	//Para extraer correctamente las fechas
	private static Date toDate(Timestamp t){
		return new Date(t.getTime());
	}
	
	@InitBinder
	private void initBinder(WebDataBinder webDataBinder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		dateFormat.setLenient(false);
		webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	public List<Peticion> getMisPeticionesHabilidad(String usuario, int idHabilidad) {
		return this.jdbcTemplate.query("select * from peticion where usuario=? and id_habilidad = ? ORDER BY fecha_ini, fecha_fin asc", new Object[] {usuario, idHabilidad}, new PeticionMapper());
	}
	
	public List<Peticion> getNoMisPeticionesHabilidad (String usuario, int idHabilidad){
		return this.jdbcTemplate.query("select * from peticion where usuario!=? and id_habilidad = ? ORDER BY fecha_ini, fecha_fin asc", new Object[] {usuario, idHabilidad}, new PeticionMapper());
	}
	
	
	//ESTADISTICAS
	
	//Num. totales peticiones en el sistema
	public int getPeticionesTotales() {
		return this.jdbcTemplate.queryForObject("select count(*) from peticion", Integer.class);
	}
}