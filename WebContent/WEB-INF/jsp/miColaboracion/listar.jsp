<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html> 
<head>
<title>Gestionar Colaboraciones</title>
</head>
<body>
	<h1>Lista de Colaboraciones</h1>
	
	<h4>Ofertas</h4>
	<table class="table">
		  <thead class="cabecera">
	
		<tr>
		<c:if test='${usuario.rol=="ADMIN"}'>
			<th>id_colaboracion</th>
		</c:if>
			<th>Fecha inicio</th>
			<th>Fecha fin</th>
			<th>Horas totales</th>
			<th>Valoracion</th>
			<th>Descripción</th>
			<th>Usuario</th>
		</tr>
		</thead>
		<c:forEach items="${colaboracionesOferta}" var="colaboracionesOferta">
			<tr>
			<c:if test='${usuario.rol=="ADMIN"}'>
				<td>${colaboracionesOferta.idColaboracion}</td>
			</c:if>
				<td>${colaboracionesOferta.fechaIniString}</td>
				<td>${colaboracionesOferta.fechaFinString}</td>
				<td>${colaboracionesOferta.horasTotales}</td>
				<td>${colaboracionesOferta.valoracion}</td>
				<td>${colaboracionesOferta.descripcion}</td>
				<td>${colaboracionesOferta.usuario}</td>
				<td><a type="button" class="btn btn-danger"  href="../colaboracion/cancelar/${colaboracionesOferta.usuario}/${colaboracionesOferta.idColaboracion}.html">Cancelar</a></td>		
			</tr>
		</c:forEach>
		</table>
		
		
		<h4>Peticiones</h4>
		<table class="table">
			  <thead class="cabecera">
		
		<tr>

		<c:if test='${usuario.rol=="ADMIN"}'>
			<th>id_colaboracion</th>
		</c:if>
			<th>Fecha inicio</th>
			<th>Fecha fin</th>
			<th>Horas totales</th>
			<th>Valoracion</th>
			<th>Descripción</th>
			<th>Usuario</th>
			<th></th>
			<th></th>
		</tr>
		</thead>
		<c:forEach items="${colaboracionesPeticion}" var="colaboracionesPeticion">
			<tr>
			<c:if test='${usuario.rol=="ADMIN"}'>
				<td>${colaboracionesPeticion.idColaboracion}</td>
			</c:if>
				<td>${colaboracionesPeticion.fechaIniString}</td>
				<td>${colaboracionesPeticion.fechaFinString}</td>	
				<td>${colaboracionesPeticion.horasTotales}</td>
				<td>${colaboracionesPeticion.valoracion}</td>
				<td>${colaboracionesPeticion.descripcion}</td>
				<td>${colaboracionesPeticion.usuario}</td>
				<jsp:useBean id="now" class="java.util.Date"/>
				<c:choose>
					<c:when test='${(colaboracionesPeticion.valoracion==0 or colaboracionesPeticion.horasTotales==0) and now.time >= colaboracionesPeticion.fechaFin.time}'>
						<td><a type="button" class="btn btn-success"  href="../update/${usuario.usuario}/${colaboracionesPeticion.idColaboracion}.html">Valorar</a></td>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
				<c:if test='${now.time < colaboracionesPeticion.fechaFin.time}'>
					<td><a type="button" class="btn btn-danger"  href="../cancelar/${usuario.usuario}/${colaboracionesPeticion.idColaboracion}.html">Cancelar</a></td>	
				</c:if>
			</tr>
		</c:forEach>		
	</table>
	<c:remove var="mis" scope="session"/>
</body>
</html>
</jsp:body>
</t:paginabasica>