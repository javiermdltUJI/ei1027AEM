<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html> 
<head>
<title>Gestionar Colaboraciones</title>
</head>
<body>
	<h1>Lista de Colaboraciones</h1>
	<table class="table">
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
				<td>${colaboracion.fechaIniString}</td>
				<td>${colaboracion.fechaFinString}</td>
				<td>${colaboracion.horasTotales}</td>
				<td>${colaboracion.valoracion}</td>
				<td>${colaboracion.idOferta}</td>
				<td>${colaboracion.idPeticion}</td>
				<td><a type="button" class="btn btn-default"  href="update/${colaboracion.idColaboracion}.html">Edita</a>
				<td><a type="button" class="btn btn-default"  href="delete/${colaboracion.idColaboracion}.html">Elimina</a>		
			</tr>
		</c:forEach>
	</table>
	<a type="button" class="btn btn-default" href="add.html">Agregar colaboración</a>
</body>
</html>
</jsp:body>
</t:paginabasica>