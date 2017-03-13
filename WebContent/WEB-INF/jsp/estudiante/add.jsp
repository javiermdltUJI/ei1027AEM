<%@ page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Crear un nuevo estudiante</title>
</head>
<body>
	<h2>Nuevo estudiante</h2>
	<form:form method="post" modelAttribute="estudiante">
		<table>
			<tr>
				<td><form:label path="usuario">Usuario</form:label></td>
				<td><form:input path="usuario" /></td>
			</tr>
			<tr>
				<td><form:label path="contrasenya">Contrasenya</form:label></td>
				<td><form:input path="contrasenya"/></td>
			</tr>
			<tr>
				<td><form:label path="correo">Correo</form:label></td>
				<td><form:input path="correo"/></td>
			</tr>
			<tr>
				<td><form:label path="nombre">Nombre</form:label></td>
				<td><form:input path="nombre"/></td>
			</tr>
			<tr>
				<td><form:label path="dni">DNI</form:label></td>
				<td><form:input path="dni"/></td>
			</tr>
			<tr>
				<td><form:label path="contadorBloqueo">Contador de bloqueo</form:label></td>
				<td><form:input path="contadorBloqueo"/></td>
			</tr>
			<tr>
				<td><form:label path="bloqueado">Bloqueado</form:label></td>
				<td><form:input path="bloqueado"/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Agregar estudiante" /></td>
			</tr>				
		</table>
	</form:form>
</body>
</html>