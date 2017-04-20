package dao;

import java.sql.SQLException;
import java.sql.ResultSet;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import modelo.Estado;
import modelo.Habilidad;
import modelo.Nivel;



//He creado un id estatatico que se va incrementando cada vez que se hace una llamada al add
//Ahora mismo el id es 6 porque tengo 5 componentes en la bbdd, pero hay que cambiarlo a 0 cuando la bbdd se cree nueva

@Repository
public class HabilidadDao {
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public void setDataSource(DataSource dataSource){
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	private static final class HabilidadMapper implements RowMapper<Habilidad>{
		public Habilidad mapRow(ResultSet rs, int rowNum) throws SQLException{
			Habilidad habilidad = new Habilidad();
			habilidad.setIdHabilidad(rs.getInt("id_habilidad"));
			habilidad.setNombre(rs.getString("nombre"));
			habilidad.setTipo(rs.getString("tipo"));
			habilidad.setDescripcion(rs.getString("descripcion"));
			habilidad.setNivel(Nivel.valueOf(rs.getString("nivel")));
			habilidad.setEstado(Estado.valueOf(rs.getString("estado")));
			return habilidad;
		}
	}
	
	public List<Habilidad> getHabilidades(){
		return this.jdbcTemplate.query("select * from habilidad", new HabilidadMapper());
	}
	
	public List<Habilidad> getHabilidadesActivas(){
		return this.jdbcTemplate.query("select * from habilidad where estado='ACTIVO'", new HabilidadMapper());
	}
	
	public Habilidad getHabilidad(int id_habilidad) {
		return this.jdbcTemplate.queryForObject("select * from habilidad where id_habilidad=?",  new Object[] {id_habilidad}, new HabilidadMapper());
	}
		
	public void addHabilidad(Habilidad habilidad){
		this.jdbcTemplate.update("insert into Habilidad( nombre, tipo, descripcion, nivel, estado) values( ?, ?, ?, CAST(? AS nivel), CAST(? AS estado))", 
				habilidad.getNombre(), habilidad.getTipo(), habilidad.getDescripcion(), habilidad.getNivel().name(), habilidad.getEstado().name());
	}
	
	public void updateHabilidad(Habilidad habilidad){
		this.jdbcTemplate.update("update Habilidad set nombre = ?, tipo = ?,  descripcion = ?, nivel = CAST(? AS nivel), estado = CAST(? AS estado) where id_habilidad = ?", 
				habilidad.getNombre(), habilidad.getTipo(), habilidad.getDescripcion(), habilidad.getNivel().name(), habilidad.getEstado().name(), habilidad.getIdHabilidad());
	}
	
	public void deleteHabilidad(int habilidad){
		this.jdbcTemplate.update("delete from habilidad where id_habilidad = ?", habilidad);
	}

}
