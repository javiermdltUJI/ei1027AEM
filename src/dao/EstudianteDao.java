package dao;

import java.sql.SQLException;
import java.sql.ResultSet;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import modelo.Estudiante;

@Repository
public class EstudianteDao {
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public void setDataSource(DataSource dataSource){
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	private static final class EstudianteMapper implements RowMapper<Estudiante>{
		public Estudiante mapRow(ResultSet rs, int rowNum) throws SQLException{
			Estudiante estudiante = new Estudiante();
			estudiante.setUsuario(rs.getString("usuario"));
			estudiante.setContrasenya(rs.getString("contrasenya"));
			estudiante.setCorreo(rs.getString("correo"));
			estudiante.setNombre(rs.getString("nombre"));
			estudiante.setDni(rs.getString("dni"));
			estudiante.setContadorBloqueo(rs.getInt("contadorBloqueo"));
			estudiante.setBloqueado(rs.getInt("bloqueado"));
			return estudiante;
		}
	}
	
	public List<Estudiante> getEstudiantes(){
		return this.jdbcTemplate.query("select * from estudiante", new EstudianteMapper());
	}
	
	public Estudiante getEstudiante(String usuario) {
		return this.jdbcTemplate.queryForObject("select * from estudiante where usuario=?",  new Object[] {usuario}, new EstudianteMapper());
	}
	
	public void addEstudiante(Estudiante estudiante){
		this.jdbcTemplate.update("insert into Estudiante(usuario, contrasenya, correo, nombre, dni, contadorBloqueo, bloqueado) values(?, ?, ?, ?, ?, ?, ?)", 
				estudiante.getUsuario(), estudiante.getContrasenya(), estudiante.getCorreo(), estudiante.getNombre(), estudiante.getDni(), estudiante.getContadorBloqueo(), estudiante.getBloqueado());
	}
	
	public void updateEstudiante(Estudiante estudiante){
		this.jdbcTemplate.update("update Estudiante set contrasenya = ?, correo = ?,  nombre = ?, dni = ?, contadorBloqueo = ?, bloqueado = ? where usuario = ?", 
				estudiante.getContrasenya(), estudiante.getCorreo(), estudiante.getNombre(), estudiante.getDni(), estudiante.getContadorBloqueo(), estudiante.getBloqueado(), estudiante.getUsuario());
	}
	
	public void deleteEstudiante(String estudiante){
		this.jdbcTemplate.update("delete from estudiante where usuario = ?", estudiante);
	}
}
