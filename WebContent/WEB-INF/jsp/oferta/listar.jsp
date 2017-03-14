<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Gestionar Ofertas</title>
</head>
<body>
	<h1>Lista de Ofertas</h1>
	<table>
		<tr>
			<th>id_oferta</th>
			<th>Fecha inicio</th>
			<th>Fecha fin</th>
			<th>Descripción</th>
			<th>Usuario</th>
			<th>id_habilidad</th>
		</tr>
		<c:forEach items="${ofertas}" var="oferta">
			<tr>
				<td>${oferta.idOferta}</td>
				<td>${oferta.fechaIni}</td>
				<td>${oferta.fechaFin}</td>
				<td>${oferta.descripcion}</td>
				<td>${oferta.usuario}</td>
				<td>${oferta.idHabilidad}</td>
				<td><a href="update/${oferta.idOferta}.html">Edita</a>
				<td><a href="delete/${oferta.idOferta}.html">Elimina</a>		
			</tr>
		</c:forEach>
	</table>
	<a href="add.html">Agregar oferta</a>
</body>
</html>