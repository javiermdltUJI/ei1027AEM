package dao;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.ResultSet;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

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
	
	public Peticion getPeticion(int id_peticion) {
		return this.jdbcTemplate.queryForObject("select * from peticion where id_peticion=?",  new Object[] {id_peticion}, new PeticionMapper());
	}
	
	static int id = 6;
	
	public void addPeticion(Peticion peticion){
		this.jdbcTemplate.update("insert into Peticion(id_peticion, fecha_ini, fecha_fin, descripcion, usuario, id_habilidad) values(?, ?, ?, ?, ?, ?)", 
				id, peticion.getFechaIni(), peticion.getFechaFin(), peticion.getDescripcion(), peticion.getUsuario(), peticion.getIdHabilidad());
		id++;
	}
	
	public void updatePeticion(Peticion peticion){
		System.out.println(peticion.toString());
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


}
