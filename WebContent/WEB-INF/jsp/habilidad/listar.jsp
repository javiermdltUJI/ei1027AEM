<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html> 
<head>
<title>Gestionar Habilidades</title>
</head>
<body>
	<h1>Lista de Habilidades</h1>
	<table class="table">
		<tr>
			<th>id_habilidad</th>
			<th>Nombre</th>
			<th>Tipo</th>
			<th>Descripción</th>
			<th>Nivel</th>
			<th>Estado</th>
		</tr>
		<c:forEach items="${habilidades}" var="habilidad">
			<tr>
				<td>${habilidad.idHabilidad}</td>
				<td>${habilidad.nombre}</td>
				<td>${habilidad.tipo}</td>
				<td>${habilidad.descripcion}</td>
				<td>${habilidad.nivel}</td>
				<td>${habilidad.estado}</td>
				<td><a type="button" class="btn btn-default" href="update/${habilidad.idHabilidad}.html">Edita</a>
				<td><a type="button" class="btn btn-default" href="delete/${habilidad.idHabilidad}.html">Elimina</a>		
			</tr>
		</c:forEach>
	</table>
	<a type="button" class="btn btn-default" href="add.html">Agregar habilidad</a>
</body>
</html>
</jsp:body>
</t:paginabasica>