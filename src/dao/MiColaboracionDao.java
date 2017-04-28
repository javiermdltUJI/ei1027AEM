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

import modelo.MiColaboracion;



@Repository
public class MiColaboracionDao {

	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public void setDataSource(DataSource dataSource){
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	private static final class MiColaboracionMapper implements RowMapper<MiColaboracion>{
		public MiColaboracion mapRow(ResultSet rs, int rowNum) throws SQLException{
			MiColaboracion miColaboracion = new MiColaboracion();
			miColaboracion.setIdColaboracion(rs.getInt("id_colaboracion"));
			miColaboracion.setFechaIni(toDate(rs.getTimestamp("fecha_ini")));
			miColaboracion.setFechaFin(toDate(rs.getTimestamp("fecha_fin")));
			miColaboracion.setHorasTotales(rs.getInt("horas_totales"));
			miColaboracion.setValoracion(rs.getInt("valoracion"));
			miColaboracion.setIdOferta(rs.getInt("id_oferta"));
			miColaboracion.setIdPeticion(rs.getInt("id_peticion"));
			miColaboracion.setDescripcion(rs.getString("descripcion"));
			miColaboracion.setUsuario(rs.getString("usuario"));
			return miColaboracion;
		}
	}
	
	public List<MiColaboracion> getMiColaboraciones(){
		return this.jdbcTemplate.query("select * from colaboracion", new MiColaboracionMapper());
	}
	
	public List<MiColaboracion> getMisColaboracionesOferta(String usuario){
		return this.jdbcTemplate.query("select C.id_colaboracion, C.fecha_ini, C.fecha_fin, C.horas_totales, C.valoracion, P.descripcion, P.usuario, C.id_oferta, C.id_peticion"
				+ " from colaboracion AS C JOIN peticion AS P USING(id_peticion) JOIN oferta AS O USING(id_oferta)"
				+ " where O.usuario=?", new Object[] {usuario},new MiColaboracionMapper());
	}
	
	public List<MiColaboracion> getMisColaboracionesPeticion(String usuario){
		return this.jdbcTemplate.query("select C.id_colaboracion, C.fecha_ini, C.fecha_fin, C.horas_totales, C.valoracion, O.descripcion, O.usuario,  C.id_oferta, C.id_peticion"
				+ " from colaboracion AS C JOIN peticion AS P USING(id_peticion) JOIN oferta AS O USING(id_oferta)"
				+ " where P.usuario=? ", new Object[] {usuario},new MiColaboracionMapper());
	}
	
	public MiColaboracion getMiColaboracion(int id_colaboracion) {
		return this.jdbcTemplate.queryForObject("select * from colaboracion where id_colaboracion=?",  new Object[] {id_colaboracion}, new MiColaboracionMapper());
	}
		
	public void addMiColaboracion(MiColaboracion miColaboracion){
		this.jdbcTemplate.update("insert into colaboracion( fecha_ini, fecha_fin, horas_totales, valoracion, id_oferta, id_peticion) values(?, ?, ?, ?, ?, ?)", 
				miColaboracion.getFechaIni(), miColaboracion.getFechaFin(), miColaboracion.getHorasTotales(), miColaboracion.getValoracion(), miColaboracion.getIdOferta(), miColaboracion.getIdPeticion());
	}
	
	public void updateMiColaboracion(MiColaboracion miColaboracion){
		this.jdbcTemplate.update("update colaboracion set fecha_ini = ?, fecha_fin = ?,  horas_totales = ?, valoracion = ?, id_oferta = ?, id_peticion = ? where id_colaboracion = ?", 
				miColaboracion.getFechaIni(), miColaboracion.getFechaFin(), miColaboracion.getHorasTotales(), miColaboracion.getValoracion(), miColaboracion.getIdOferta(), miColaboracion.getIdPeticion(), miColaboracion.getIdColaboracion());
	}
	
	public void deleteMiColaboracion(int miColaboracion){
		this.jdbcTemplate.update("delete from colaboracion where id_colaboracion = ?", miColaboracion);
	}

	//Para extraer correctamente las fechas
	private static Date toDate(Timestamp t){
		return new Date(t.getTime());
	}

}