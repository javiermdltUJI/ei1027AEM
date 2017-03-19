<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Gestionar Usuarios</title>
</head>
<body>
	<h1>Lista de Usuarios</h1>
	<table>
		<tr>
			<th>Nombre usuario</th>
			<th>Contrasenya</th>
			<th>Correo</th>
			<th>Nombre</th>
			<th>Dni</th>
			<th>Contador de bloqueo</th>
			<th>Bloqueado</th>
			<th>Rol</th>
		</tr>
		<c:forEach items="${usuarios}" var="usuario">
			<tr>
				<td>${usuario.usuario}</td>
				<td>${usuario.contrasenya}</td>
				<td>${usuario.correo}</td>
				<td>${usuario.nombre}</td>
				<td>${usuario.dni}</td>
				<td>${usuario.contadorBloqueo}</td>
				<td>${usuario.bloqueado}</td>
				<td>${usuario.rol}</td>
				<td><a href="update/${usuario.usuario}.html">Edita</a>
				<td><a href="delete/${usuario.usuario}.html">Elimina</a>		
			</tr>
		</c:forEach>
	</table>
	<a href="add.html">Agregar usuario</a>
</body>
</html>