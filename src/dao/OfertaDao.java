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

import modelo.Oferta;


@Repository
public class OfertaDao {
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public void setDataSource(DataSource dataSource){
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	private static final class OfertaMapper implements RowMapper<Oferta>{
		public Oferta mapRow(ResultSet rs, int rowNum) throws SQLException{
			Oferta oferta = new Oferta();
			oferta.setIdOferta(rs.getInt("id_oferta"));
			oferta.setFechaIni(toDate(rs.getTimestamp("fecha_ini")));
			oferta.setFechaFin(toDate(rs.getTimestamp("fecha_fin")));
			oferta.setDescripcion(rs.getString("descripcion"));
			oferta.setUsuario(rs.getString("usuario"));
			oferta.setIdHabilidad(rs.getInt("id_habilidad"));
			return oferta;
		}
	}
	
	public List<Oferta> getOfertas(){
		return this.jdbcTemplate.query("select * from oferta ORDER BY fecha_ini, fecha_fin asc", new OfertaMapper());
	}
	
	//Devuelve ofertas no hechas por mi
	public Object getOfertas(String usuario) {
		return this.jdbcTemplate.query("select * from oferta where usuario!=? ORDER BY fecha_ini, fecha_fin",  new Object[] {usuario}, new OfertaMapper());
	}
	
	//Devuelve ofertas hechas por mi
	public Object getMisOfertas(String usuario) {
		return this.jdbcTemplate.query("select * from oferta where usuario=? ORDER BY fecha_ini, fecha_fin asc", new Object[] {usuario}, new OfertaMapper());
	}
		
	
	public Oferta getOferta(int id_oferta) {
		return this.jdbcTemplate.queryForObject("select * from oferta where id_oferta=?",  new Object[] {id_oferta}, new OfertaMapper());
	}

	
	public void addOferta(Oferta oferta){
		this.jdbcTemplate.update("insert into Oferta(fecha_ini, fecha_fin, descripcion, usuario, id_habilidad) values(?, ?, ?, ?, ?)", 
				oferta.getFechaIni(), oferta.getFechaFin(), oferta.getDescripcion(), oferta.getUsuario(), oferta.getIdHabilidad());
	}
	
	public int addOfertaInt(Oferta oferta){
		return this.jdbcTemplate.queryForObject("insert into Oferta(fecha_ini, fecha_fin, descripcion, usuario, id_habilidad) values(?, ?, ?, ?, ?) returning id_oferta", 
				 new Object[] {oferta.getFechaIni(), oferta.getFechaFin(), oferta.getDescripcion(), oferta.getUsuario(), oferta.getIdHabilidad()}, Integer.class);

	}
	public void updateOferta(Oferta oferta){
		this.jdbcTemplate.update("update Oferta set fecha_ini = ?, fecha_fin = ?,  descripcion = ?, usuario = ?, id_habilidad = ? where id_oferta = ?", 
				oferta.getFechaIni(), oferta.getFechaFin(), oferta.getDescripcion(), oferta.getUsuario(), oferta.getIdHabilidad(), oferta.getIdOferta());
	}
	
	public void deleteOferta(int oferta){
		this.jdbcTemplate.update("delete from oferta where id_oferta = ?", oferta);
	}

	//Para extraer correctamente las fechas
	private static Date toDate(Timestamp t){
		return new Date(t.getTime());
	}

	public List<Oferta> getMisOfertasHabilidad(String usuario, int idHabilidad) {
		return this.jdbcTemplate.query("select * from oferta where usuario=? and id_habilidad = ? ORDER BY fecha_ini, fecha_fin asc", new Object[] {usuario, idHabilidad}, new OfertaMapper());
	}
	
	@InitBinder
	private void initBinder(WebDataBinder webDataBinder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		dateFormat.setLenient(false);
		webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

}
