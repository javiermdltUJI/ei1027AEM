<%@ page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>Modificar datos de un usuarios</title>
</head>
<body>
	<h2>Usuario</h2>
	<form:form method="post" modelAttribute="usuario">
		<table>
			<tr>
				<td><form:label path="usuario">Usuario</form:label></td>
				<td><form:input path="usuario" id="usuario" placeholder="Usuario"/></td>
			</tr>
			<tr>
				<td><form:label path="contrasenya">Contrasenya</form:label></td>
				<td><form:input path="contrasenya" id="contrasenya" placeholder="Contrasenya"/></td>
			</tr>
			<tr>
				<td><form:label path="correo">Correo</form:label></td>
				<td><form:input path="correo" id="correo" placeholder="Correo"/></td>
			</tr>
			<tr>
				<td><form:label path="nombre">Nombre</form:label></td>
				<td><form:input path="nombre" id="nombre" placeholder="Nombre"/></td>
			</tr>
			<tr>
				<td><form:label path="dni">DNI</form:label></td>
				<td><form:input path="dni" id="dni" placeholder="DNI"/></td>
			</tr>
			<tr>
				<td><form:label path="contadorBloqueo">Contador de bloqueo</form:label></td>
				<td><form:input path="contadorBloqueo" id="contadorBloqueo" placeholder="0"/></td>
			</tr>
			<tr>
				<td><form:label path="bloqueado">Bloqueado</form:label></td>
				<td><form:input path="bloqueado" id="bloqueado" placeholder="0"/></td>
			</tr>
			<tr>
				<td>
				<form:label path="rol">Rol</form:label>
				    		<form:select path="rol" class="form-control" id="tipoRol">
								<form:option value="ESTUDIANTE"> ---- </form:option>
								<form:option value="ESTUDIANTE"> Estudiante </form:option>
								<form:option value="ADMIN">Admin</form:option>
							</form:select>
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Modifica usuario" /></td>
			</tr>				
		</table>
	</form:form>
</body>
</html>