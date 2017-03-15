<%@ page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Modificar datos de una oferta</title>
</head>
<body>
	<h2>Oferta</h2>
	<form:form method="post" modelAttribute="oferta">
		<table>
			<tr>
				<td><form:input type="hidden" name="idOferta" path="idOferta"/></td>
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
				<td><form:label path="idHabilidad">id_habilidad</form:label></td>
				<td><form:input path="idHabilidad" id="idHabilidad" placeholder="1"/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Modifica oferta" /></td>
			</tr>				
		</table>
	</form:form>
</body>
</html>