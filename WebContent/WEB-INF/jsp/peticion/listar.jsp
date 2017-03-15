<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Gestionar Peticiones</title>
</head>
<body>
	<h1>Lista de Peticiones</h1>
	<table>
		<tr>
			<th>id_peticion</th>
			<th>Fecha inicio</th>
			<th>Fecha fin</th>
			<th>Descripción</th>
			<th>Usuario</th>
			<th>id_habilidad</th>
		</tr>
		<c:forEach items="${peticiones}" var="peticion">
			<tr>
				<td>${peticion.idPeticion}</td>
				<td>${peticion.fechaIni}</td>
				<td>${peticion.fechaFin}</td>
				<td>${peticion.descripcion}</td>
				<td>${peticion.usuario}</td>
				<td>${peticion.idHabilidad}</td>
				<td><a href="update/${peticion.idPeticion}.html">Edita</a>
				<td><a href="delete/${peticion.idPeticion}.html">Elimina</a>		
			</tr>
		</c:forEach>
	</table>
	<a href="add.html">Agregar petición</a>
</body>
</html>