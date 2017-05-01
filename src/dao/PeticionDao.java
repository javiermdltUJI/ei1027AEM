package dao;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
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

import modelo.Peticion;

//He creado un id estatatico que se va incrementando cada vez que se hace una llamada al add
//Ahora mismo el id es 6 porque tengo 5 componentes en la bbdd, pero hay que cambiarlo a 0 cuando la bbdd se cree nueva


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
	
	public List<Peticion> getPeticiones(){
		return this.jdbcTemplate.query("select * from peticion", new PeticionMapper());
	}
	
	//Devuelve las peticiones no hechas por mi
	public List<Peticion> getPeticiones(String usuario){
		return this.jdbcTemplate.query("select * from peticion where usuario!=?", new Object[] {usuario}, new PeticionMapper());
	}
	
	//Devuelve mis peticiones
	public List<Peticion> getMisPeticiones(String usuario){
		return this.jdbcTemplate.query("select * from peticion where usuario=?", new Object[] {usuario}, new PeticionMapper());
	}
	
	
	public Peticion getPeticion(int id_peticion) {
		return this.jdbcTemplate.queryForObject("select * from peticion where id_peticion=?",  new Object[] {id_peticion}, new PeticionMapper());
	}
	
	
	public void addPeticion(Peticion peticion){
		this.jdbcTemplate.update("insert into Peticion(fecha_ini, fecha_fin, descripcion, usuario, id_habilidad) values( ?, ?, ?, ?, ?)", 
				peticion.getFechaIni(), peticion.getFechaFin(), peticion.getDescripcion(), peticion.getUsuario(), peticion.getIdHabilidad());
	}
	
	public int addPeticionInt(Peticion peticion){
		return this.jdbcTemplate.queryForObject("insert into Peticion(fecha_ini, fecha_fin, descripcion, usuario, id_habilidad) values( ?, ?, ?, ?, ?)",
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
}