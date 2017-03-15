<%@ page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>Mofificar una nueva colaboración</title>
</head>
<body>
	<h2>Colaboración</h2>
	<form:form method="post" modelAttribute="colaboracion">
		<table>
			<tr>
				<td><form:input type="hidden" name="idColaboracion" path="idColaboracion"/></td>
			</tr>
			<tr>
				<td><form:label path="fechaIni">Fecha Inicio</form:label></td>
	            <td><form:input path="fechaIni" id="fechaIni" placeholder="Fecha Inicio" /></td>
			</tr>
			<tr>
				<td><form:label path="fechaFin">Fecha Fin</form:label></td>
	            <td><form:input path="fechaFin" id="fechaFin" placeholder="Fecha Fin" /></td>
			</tr>
			<tr>
				<td><form:label path="horasTotales">Horas totales</form:label></td>
				<td><form:input path="horasTotales" id="horasTotales" placeholder="Horas Totales"/></td>
			</tr>
			<tr>
				<td><form:label path="valoracion">Valoracion</form:label></td>
				<td><form:input path="valoracion" id="valoracion" placeholder="Valoracion"/></td>
			</tr>
			<tr>
				<td><form:label path="idOferta">id_oferta</form:label></td>
				<td><form:input path="idOferta" id="idOferta" placeholder="1"/></td>
			</tr>
			<tr>
				<td><form:label path="idPeticion">id_peticion</form:label></td>
				<td><form:input path="idPeticion" id="idPeticion" placeholder="1"/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Modificar colaboración" /></td>
			</tr>				
		</table>
	</form:form>
</body>
</html>