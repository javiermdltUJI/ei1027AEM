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

import modelo.Colaboracion;

//He creado un id estatatico que se va incrementando cada vez que se hace una llamada al add
//Ahora mismo el id es 6 porque tengo 5 componentes en la bbdd, pero hay que cambiarlo a 0 cuando la bbdd se cree nueva


@Repository
public class ColaboracionDao {

	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public void setDataSource(DataSource dataSource){
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	private static final class ColaboracionMapper implements RowMapper<Colaboracion>{
		public Colaboracion mapRow(ResultSet rs, int rowNum) throws SQLException{
			Colaboracion colaboracion = new Colaboracion();
			colaboracion.setIdColaboracion(rs.getInt("id_colaboracion"));
			colaboracion.setFechaIni(toDate(rs.getTimestamp("fecha_ini")));
			colaboracion.setFechaFin(toDate(rs.getTimestamp("fecha_fin")));
			colaboracion.setHorasTotales(rs.getInt("horas_totales"));
			colaboracion.setValoracion(rs.getInt("valoracion"));
			colaboracion.setIdOferta(rs.getInt("id_oferta"));
			colaboracion.setIdPeticion(rs.getInt("id_peticion"));	
			return colaboracion;
		}
	}
	
	public List<Colaboracion> getColaboraciones(){
		return this.jdbcTemplate.query("select * from colaboracion", new ColaboracionMapper());
	}
	
	public Colaboracion getColaboracion(int id_colaboracion) {
		return this.jdbcTemplate.queryForObject("select * from colaboracion where id_colaboracion=?",  new Object[] {id_colaboracion}, new ColaboracionMapper());
	}
		
	public void addColaboracion(Colaboracion colaboracion){
		this.jdbcTemplate.update("insert into Colaboracion( fecha_ini, fecha_fin, horas_totales, valoracion, id_oferta, id_peticion) values(?, ?, ?, ?, ?, ?)", 
				colaboracion.getFechaIni(), colaboracion.getFechaFin(), colaboracion.getHorasTotales(), colaboracion.getValoracion(), colaboracion.getIdOferta(), colaboracion.getIdPeticion());
	}
	
	public void updateColaboracion(Colaboracion colaboracion){
		this.jdbcTemplate.update("update Colaboracion set fecha_ini = ?, fecha_fin = ?,  horas_totales = ?, valoracion = ?, id_oferta = ?, id_peticion = ? where id_colaboracion = ?", 
				colaboracion.getFechaIni(), colaboracion.getFechaFin(), colaboracion.getHorasTotales(), colaboracion.getValoracion(), colaboracion.getIdOferta(), colaboracion.getIdPeticion(), colaboracion.getIdColaboracion());
	}
	
	public void deleteColaboracion(int colaboracion){
		this.jdbcTemplate.update("delete from colaboracion where id_colaboracion = ?", colaboracion);
	}

	//Para extraer correctamente las fechas
	private static Date toDate(Timestamp t){
		return new Date(t.getTime());
	}

}
