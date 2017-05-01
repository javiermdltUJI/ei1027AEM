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
			<th>Descripción</th>
			<th>Usuario</th>
		</tr>
		<tr>
			<td>Ofertas</td>
		</tr>
		<c:forEach items="${colaboracionesOferta}" var="colaboracionesOferta">
			<tr>
				<td>${colaboracionesOferta.idColaboracion}</td>
				<td>${colaboracionesOferta.fechaIniString}</td>
				<td>${colaboracionesOferta.fechaFinString}</td>
				<td>${colaboracionesOferta.horasTotales}</td>
				<td>${colaboracionesOferta.valoracion}</td>
				<td>${colaboracionesOferta.descripcion}</td>
				<td>${colaboracionesOferta.usuario}</td>
				<td><a type="button" class="btn btn-default"  href="../colaboracion/cancelar/${colaboracionesOferta.usuario}/${colaboracionesOferta.idColaboracion}.html">Cancelar</a>		
			</tr>
		</c:forEach>
		
		<tr>
			<td>Peticiones</td>
		</tr>
		<c:forEach items="${colaboracionesPeticion}" var="colaboracionesPeticion">
			<tr>
				<td>${colaboracionesPeticion.idColaboracion}</td>
				<td>${colaboracionesPeticion.fechaIni}</td>
				<td>${colaboracionesPeticion.fechaFin}</td>
				<td>${colaboracionesPeticion.horasTotales}</td>
				<td>${colaboracionesPeticion.valoracion}</td>
				<td>${colaboracionesPeticion.descripcion}</td>
				<td>${colaboracionesPeticion.usuario}</td>
				<td><a type="button" class="btn btn-default"  href="../colaboracion/update/${colaboracionesPeticion.usuario}/${colaboracionesPeticion.idColaboracion}.html">Valorar</a>
				<td><a type="button" class="btn btn-default"  href="../colaboracion/cancelar/${colaboracionesPeticion.usuario}/${colaboracionesPeticion.idColaboracion}.html">Cancelar</a>		
			</tr>
		</c:forEach>
		
	</table>
	<a type="button" class="btn btn-default" href="add.html">Agregar colaboración</a>
</body>
</html>
</jsp:body>
</t:paginabasica>