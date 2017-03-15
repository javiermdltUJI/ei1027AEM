<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Gestionar Colaboraciones</title>
</head>
<body>
	<h1>Lista de Colaboraciones</h1>
	<table>
		<tr>
			<th>id_colaboracion</th>
			<th>Fecha inicio</th>
			<th>Fecha fin</th>
			<th>Horas totales</th>
			<th>Valoracion</th>
			<th>id_oferta</th>
			<th>id_peticion</th>
		</tr>
		<c:forEach items="${colaboraciones}" var="colaboracion">
			<tr>
				<td>${colaboracion.idColaboracion}</td>
				<td>${colaboracion.fechaIni}</td>
				<td>${colaboracion.fechaFin}</td>
				<td>${colaboracion.horasTotales}</td>
				<td>${colaboracion.valoracion}</td>
				<td>${colaboracion.idOferta}</td>
				<td>${colaboracion.idPeticion}</td>
				<td><a href="update/${colaboracion.idColaboracion}.html">Edita</a>
				<td><a href="delete/${colaboracion.idColaboracion}.html">Elimina</a>		
			</tr>
		</c:forEach>
	</table>
	<a href="add.html">Agregar colaboración</a>
</body>
</html>