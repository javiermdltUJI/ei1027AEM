package dao;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.security.InvalidParameterException;
import java.sql.ResultSet;
import java.util.Date;
import java.util.EmptyStackException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import modelo.Colaboracion;
import modelo.Nivel;



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
	
	private static final class AColaboracionMapper implements RowMapper<Colaboracion>{
		public Colaboracion mapRow(ResultSet rs, int rowNum) throws SQLException{
			Colaboracion colaboracion = new Colaboracion();
			colaboracion.setIdColaboracion(rs.getInt("id_colaboracion"));
			colaboracion.setFechaIni(toDate(rs.getTimestamp("fecha_ini")));
			colaboracion.setFechaFin(toDate(rs.getTimestamp("fecha_fin")));
			colaboracion.setHorasTotales(rs.getInt("horas_totales"));
			colaboracion.setValoracion(rs.getInt("valoracion"));
			colaboracion.setOfertante(rs.getString("ofertante"));
			colaboracion.setDemandante(rs.getString("demandante"));	
			colaboracion.setNivel(Nivel.valueOf(rs.getString("nivel")));
			colaboracion.setDescripcion(rs.getString("descripcion"));
			return colaboracion;
		}
	}
	
	public List<Colaboracion> getColaboraciones(){
		return this.jdbcTemplate.query("select * from colaboracion ORDER BY fecha_ini, fecha_fin asc", new ColaboracionMapper());
	}
	
	public List<Colaboracion> getMisColaboracionesOferta(String usuario){
		return this.jdbcTemplate.query("select C.id_colaboracion, C.fecha_ini, C.fecha_fin, C.horas_totales, C.valoracion, P.descripcion, P.usuario"
				+ " from colaboracion AS C JOIN peticion AS P USING(id_peticion) JOIN oferta AS O USING(id_oferta)"
				+ " where O.usuario=? ORDER BY C.fecha_ini, C.fecha_fin asc", new Object[] {usuario},new ColaboracionMapper());
	}
	
	public List<Colaboracion> getMisColaboracionesPeticion(String usuario){
		return this.jdbcTemplate.query("select C.id_colaboracion, C.fecha_ini, C.fecha_fin, C.horas_totales, C.valoracion, O.descripcion, O.usuario"
				+ " from colaboracion AS C JOIN peticion AS P USING(id_peticion) JOIN oferta AS O USING(id_oferta)"
				+ " where P.usuario=? ORDER BY C.fecha_ini, C.fecha_fin asc", new Object[] {usuario},new ColaboracionMapper());
	}
	
	public List<Colaboracion> getAColaboraciones(){
		return this.jdbcTemplate.query("select C.id_colaboracion, C.fecha_ini, C.fecha_fin, O.usuario AS ofertante, P.usuario AS demandante,"
				+ " C.horas_totales, C.valoracion, H.descripcion, H.nivel"
				+ " from colaboracion AS C JOIN oferta AS O USING(id_oferta) JOIN peticion AS P USING(id_peticion)  JOIN habilidad AS H ON(O.id_habilidad=H.id_habilidad)"
				+ " ORDER BY C.fecha_ini, C.fecha_fin asc", new AColaboracionMapper());
	}
		
	
	public Colaboracion getColaboracion(int id_colaboracion) {
		return this.jdbcTemplate.queryForObject("select * from colaboracion where id_colaboracion=?",  new Object[] {id_colaboracion}, new ColaboracionMapper());
	}
		
	public void addColaboracion(Colaboracion colaboracion){
		this.jdbcTemplate.update("insert into Colaboracion( fecha_ini, fecha_fin, horas_totales, valoracion, id_oferta, id_peticion) values(?, ?, ?, ?, ?, ?)", 
			colaboracion.getFechaIni(), colaboracion.getFechaFin(), colaboracion.getHorasTotales(), colaboracion.getValoracion(), colaboracion.getIdOferta(), colaboracion.getIdPeticion());

	}
	
	public boolean existeOferta(int idOferta){
		System.out.println("qweqwe");
		System.out.println(this.jdbcTemplate.queryForObject("select count(*) from oferta where id_oferta = ?", new Object[] {idOferta}, Integer.class));
		if (this.jdbcTemplate.queryForObject("select count(*) from oferta where id_oferta = ?", new Object[] {idOferta}, Integer.class)==0)
			return false;
		return true;
	}
	public boolean existePeticion(int idPeticion){
		if (this.jdbcTemplate.queryForObject("select count(*) from peticion where id_peticion = ?", new Object[] {idPeticion}, Integer.class)==0)
			return false;
		return true;
	}
	public boolean coincideHabilidad(int idOferta, int idPeticion){
		int idHabilidadOferta = this.jdbcTemplate.queryForObject("select id_habilidad from oferta where id_oferta = ?", new Object[] {idOferta}, Integer.class);
		int idHabilidadPeticion = this.jdbcTemplate.queryForObject("select id_habilidad from peticion where id_peticion = ?", new Object[] {idPeticion}, Integer.class);
			
		if(idHabilidadOferta==idHabilidadPeticion)
			return true;
		return false;
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

	public void cancelarColaboracion(int id_colaboracion) {
		this.jdbcTemplate.update("update colaboracion set fecha_fin=null, fecha_ini=null where id_colaboracion = ?", id_colaboracion);
	}
	
	//Para obtener las horas de las colaboraciones realizadas por un usuario (indistintamente si son peticiones u ofertas)
	public int getHorasColaboraciones(String usuario){
		int horasOferta = this.jdbcTemplate.queryForObject("select COALESCE(SUM(horas_totales), 0) from colaboracion join oferta using (id_oferta) where usuario = ?", new Object[] {usuario}, Integer.class);
		int horasPeticion = this.jdbcTemplate.queryForObject("select COALESCE(SUM(horas_totales), 0) from colaboracion join peticion using (id_peticion) where usuario = ?", new Object[] {usuario}, Integer.class);
		return horasOferta-horasPeticion;
	}		
	
	//Para obtener el número de peticiones que existen para cualquier colaboracion
	public int getNumColaboracionesPorPeticion(int id_peticion){
		int numColaboraciones = this.jdbcTemplate.queryForObject("select count(*) from colaboracion where id_peticion = ?", new Object[]{id_peticion}, Integer.class);
		return numColaboraciones;
	}
	
	//Para obtener el número de ofertas que existen para cualquier colaboracion
	public int getNumColaboracionesPorOferta(int id_oferta){
		int numColaboraciones = this.jdbcTemplate.queryForObject("select count(*) from colaboracion where id_oferta = ?", new Object[]{id_oferta}, Integer.class); 
		return numColaboraciones;
	}
	
	
	//ESTADISTICAS
	
	//Num. colaboraciones valoradas
	public int getColaboracionesValoradas() {
		return this.jdbcTemplate.queryForObject("select count(*) from colaboracion where valoracion > 0", Integer.class);
	}
	
	//Num. colaboraciones totales
	public int getColaboracionesTotales() {
		return this.jdbcTemplate.queryForObject("select count(*) from colaboracion", Integer.class);
	}
	
	//Horas totales colaboraciones
	public int getColaboracionesHorasTotales() {
		return this.jdbcTemplate.queryForObject("select sum(horas_totales) from colaboracion", Integer.class);
	}
	
	//Media horas colaboraciones
	public double getMediaHorasColaboraciones(){
		double num = this.jdbcTemplate.queryForObject("select avg(horas_totales) from colaboracion where horas_totales!=0", Double.class).doubleValue();
		return num;
//		return Math.round(num*100)/100;
	}
	
	//Media valoraciones colaboraciones
	public double getMediaValoracionColaboraciones(){
		double num = this.jdbcTemplate.queryForObject("select avg(valoracion) from colaboracion where valoracion!=0", Double.class).doubleValue();
		return num;
	}
	
	//Colaboraciones totales por mes
		public List<Map<String, Object>> getCountColaboracionesPorMes(){
			return this.jdbcTemplate.queryForList("select EXTRACT(MONTH from fecha_ini), count(*) from colaboracion group by EXTRACT (MONTH from fecha_ini) ORDER BY date_part");
		}
	
	
	
	
}