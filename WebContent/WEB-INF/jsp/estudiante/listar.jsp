<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Gestionar Estudiantes</title>
</head>
<body>
	<h1>Lista de Estudiantes</h1>
	<table>
		<tr>
			<th>Usuario</th>
			<th>Contrasenya</th>
			<th>Correo</th>
			<th>Nombre</th>
			<th>Dni</th>
			<th>Contador de bloqueo</th>
			<th>Bloqueado</th>
		</tr>
		<c:forEach items="${estudiantes}" var="estudiante">
			<tr>
				<td>${estudiante.usuario}</td>
				<td>${estudiante.contrasenya}</td>
				<td>${estudiante.correo}</td>
				<td>${estudiante.nombre}</td>
				<td>${estudiante.dni}</td>
				<td>${estudiante.contadorBloqueo}</td>
				<td>${estudiante.bloqueado}</td>
				<td><a href="update/${estudiante.usuario}.html">Edita</a>
				<td><a href="delete/${estudiante.usuario}.html">Elimina</a>		
			</tr>
		</c:forEach>
	</table>
	<a href="add.html">Agregar estudiante</a>
</body>
</html>