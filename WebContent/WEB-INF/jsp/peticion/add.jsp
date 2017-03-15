<%@ page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>Crear una nueva petici�n</title>
</head>
<body>
	<h2>Nueva petici�n</h2>
	<form:form method="post" modelAttribute="peticion">
		<table>
			<tr>
				<td><form:label path="fechaIni">Fecha Inicio</form:label></td>
	            <td><form:input path="fechaIni" id="fechaIni" placeholder="Fecha Inicio" /></td>
			</tr>
			<tr>
				<td><form:label path="fechaFin">Fecha Fin</form:label></td>
	            <td><form:input path="fechaFin" id="fechaFin" placeholder="Fecha Fin" /></td>
			</tr>
			<tr>
				<td><form:label path="descripcion">Descripci�n</form:label></td>
				<td><form:input path="descripcion" id="descripcion" placeholder="Descripci�n"/></td>
			</tr>
			<tr>
				<td><form:label path="usuario">Usuario</form:label></td>
				<td><form:input path="usuario" id="usuario" placeholder="Usuario"/></td>
			</tr>
			<tr>
				<td><form:label path="idHabilidad">id_habilidad</form:label></td>
				<td><form:input path="idHabilidad" id="idHabilidad" placeholder="1"/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Agregar petici�n" /></td>
			</tr>				
		</table>
	</form:form>
</body>
</html>