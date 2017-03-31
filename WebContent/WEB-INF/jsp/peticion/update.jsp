<%@ page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>Modificar datos de una petición</title>
</head>
<body>
	<h2>Petición</h2>
	<form:form method="post" modelAttribute="peticion">
		<table>
			<tr>
				<td><form:input type="hidden" name="idPeticion" path="idPeticion"/></td>
			</tr>
			<tr>
				<td><form:label path="fechaIni">Fecha Inicio</form:label></td>
	            <td><form:input path="fechaIni" id="fechaInicio" placeholder="Fecha Inicio" /></td>
			</tr>
			<tr>
				<td><form:label path="fechaFin">Fecha Fin</form:label></td>
	            <td><form:input path="fechaFin" id="fechaInicio" placeholder="Fecha Fin" /></td>
			</tr>
			<tr>
				<td><form:label path="descripcion">Descripción</form:label></td>
				<td><form:input path="descripcion" id="descripcion" placeholder="Descripción"/></td>
			</tr>
			<tr>
				<td><form:label path="usuario">Usuario</form:label></td>
				<td><form:input path="usuario" id="usuario" placeholder="Usuario"/></td>
			</tr>
			<tr>			
				<td><form:label path="idHabilidad">Habilidad</form:label></td>
				<td><select name="idHabilidad">
					<c:forEach items="${habilidades}" var="habilidad">
						<option value="${habilidad.idHabilidad}" 
						<c:if test="${peticion.idHabilidad == habilidad.idHabilidad}"> selected </c:if>
						> ${habilidad.descripcion}  Nivel: ${habilidad.nivel}</option>		
					</c:forEach>
				</select>
				</td>
				<!--   <td><form:label path="idHabilidad">id_habilidad</form:label></td>
				<td><form:input path="idHabilidad" id="idHabilidad" placeholder="1"/></td> -->
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Modifica petición" /></td>
			</tr>				
		</table>
	</form:form>
</body>
</html>