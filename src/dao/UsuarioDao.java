package dao;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.sql.ResultSet;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.jasypt.util.password.BasicPasswordEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import modelo.Rol;
import modelo.Usuario;

@Repository
public class UsuarioDao implements UserDao {
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public void setDataSource(DataSource dataSource){
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	private static final class UsuarioMapper implements RowMapper<Usuario>{
		public Usuario mapRow(ResultSet rs, int rowNum) throws SQLException{
			Usuario usuario = new Usuario();
			usuario.setUsuario(rs.getString("nom_usuario"));
			usuario.setContrasenya(rs.getString("contrasenya"));
			usuario.setCorreo(rs.getString("correo"));
			usuario.setNombre(rs.getString("nombre"));
			usuario.setDni(rs.getString("dni"));
			usuario.setEliminado(rs.getInt("eliminado"));
			usuario.setBloqueado(rs.getInt("bloqueado"));
			usuario.setFechaFin(toDate(rs.getTimestamp("fecha_fin")));
			usuario.setRol(Rol.valueOf(rs.getString("rol")));
			return usuario;
		}		
	}
	
	public List<Usuario> getUsuarios(){
		return this.jdbcTemplate.query("select * from usuario", new UsuarioMapper());
	}
	
	public Usuario getUsuario(String usuario) {
		return this.jdbcTemplate.queryForObject("select * from usuario where nom_usuario=?",  new Object[] {usuario}, new UsuarioMapper());
	}
	
	public void addUsuario(Usuario usuario){
		BasicPasswordEncryptor passwordEncryptor = new BasicPasswordEncryptor();
		String cifrada = passwordEncryptor.encryptPassword(usuario.getContrasenya());
		this.jdbcTemplate.update("insert into Usuario(nom_usuario, contrasenya, correo, nombre, dni, eliminado, bloqueado, fecha_fin, rol) values(?, ?, ?, ?, ?, ?, ?, ?, CAST(? AS rol))", 
				usuario.getUsuario(), cifrada, usuario.getCorreo(), usuario.getNombre(), usuario.getDni(), usuario.getEliminado(),
				usuario.getBloqueado(), usuario.getFechaFin(), usuario.getRol().name());
	}
	
	public void updateUsuario(Usuario usuario){
		this.jdbcTemplate.update("update Usuario set contrasenya = ?, correo = ?,  nombre = ?, dni = ?, eliminado = ?, bloqueado = ?, fecha_fin = ?, rol = CAST(? AS rol) where nom_usuario = ?", 
				usuario.getContrasenya(), usuario.getCorreo(), usuario.getNombre(), usuario.getDni(), usuario.getEliminado(), usuario.getBloqueado(), usuario.getFechaFin(),
				usuario.getRol().name(), usuario.getUsuario());
	}
	
	public void deleteUsuario(String usuario){
		this.jdbcTemplate.update("update usuario set eliminado = 1 where nom_usuario = ?", usuario);
	}
	
	public void lockUsuario(String usuario, Date fecha_fin){
		this.jdbcTemplate.update("update usuario set bloqueado = 1, fecha fin = ? where nom_usuario = ?", fecha_fin, usuario);
	}
	public void unlockUsuario(String usuario){
		this.jdbcTemplate.update("update usuario set bloqueado = 0, fecha_fin = '0001-01-01' where nom_usuario = ?", usuario);
	}
	
	//Para comprobar si un usuario existe en la base de datos
	public boolean existeUsuario(String nombreUsuario){
		try{
		this.jdbcTemplate.queryForObject("select * from Usuario where nom_usuario = ?",  
				new Object[] {nombreUsuario}, 
				new UsuarioMapper());
		}catch(EmptyResultDataAccessException e){
			return false;
		}
		return true;
	}
	
		
	
	@Override
	public Usuario loadUserByUsername(String nombreUsuario, String contrasenya) {
		Usuario usuario = this.jdbcTemplate.queryForObject("select * from Usuario where nom_usuario = ?",  
					new Object[] {nombreUsuario}, 
					new UsuarioMapper());
	      if (usuario == null)
	          return null; // Usuari no trobat
	      // Contrasenya
	     BasicPasswordEncryptor passwordEncryptor = new BasicPasswordEncryptor(); 
	     if (passwordEncryptor.checkPassword(contrasenya, usuario.getContrasenya())) {
	     // Es deuria esborrar de manera segura el camp password abans de tornar-lo
	         return usuario; 
	        } 
	     else {
	         return null; // bad login!
	     }
	 }
	
	//Para comprobar si un usuario está bloqueado
	public boolean estaBloqueado(String nombreUsuario){
		Usuario usuario;
		if (existeUsuario(nombreUsuario)) {
			usuario = this.jdbcTemplate.queryForObject("select * from Usuario where nom_usuario = ?",  
				new Object[] {nombreUsuario}, new UsuarioMapper());
			if (usuario.getEliminado()==1) 
				return true;
			if (usuario.getBloqueado()==0)
				return false;
			if (usuario.getFechaFin().before(new Date())){
				usuario.setBloqueado(0);
				usuario.setFechaFin(null);
				updateUsuario(usuario);
				return false;
			}
			return true;
		}
		return false;
	}
	
	//Para extraer correctamente las fechas
		private static Date toDate(Timestamp t){
			return new Date(t.getTime());
		}	
}
