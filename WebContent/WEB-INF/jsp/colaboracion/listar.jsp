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
		  <thead class="cabecera">
	
		<tr>
		<c:if test='${usuario.rol=="ADMIN"}'>
			<th>id_colaboracion</th>
		</c:if>
			<th>Fecha inicio</th>
			<th>Fecha fin</th>
			<th>Horas totales</th>
			<th>Valoracion</th>
		<c:if test='${usuario.rol=="ADMIN"}'>
			<th>id_oferta</th>
			<th>id_peticion</th>
			<th></th>
			<th></th>
		</c:if>
		</tr>
		</thead>
		<c:forEach items="${colaboraciones}" var="colaboracion">
			<tr>
			<c:if test='${usuario.rol=="ADMIN"}'>
				<td>${colaboracion.idColaboracion}</td>
			</c:if>
				<td>${colaboracion.fechaIniString}</td>
				<td>${colaboracion.fechaFinString}</td>
				<td>${colaboracion.horasTotales}</td>
				<td>${colaboracion.valoracion}</td>
			<c:if test='${usuario.rol=="ADMIN"}'>
				<td>${colaboracion.idOferta}</td>
				<td>${colaboracion.idPeticion}</td>
			</c:if>
				<td><a type="button" class="btn btn-success"  href="update/${colaboracion.idColaboracion}.html"><i class="fa fa-pencil" aria-hidden="true"></i> Editar</a>
				<td><a type="button" class="btn btn-danger"  href="delete/${colaboracion.idColaboracion}.html"><i class="fa fa-trash" aria-hidden="true"></i> Eliminar
				</a>		
			</tr>
		</c:forEach>
	</table>
	<a type="button" class="btn btn-primary" href="add.html"><i class="fa fa-plus" aria-hidden="true"></i> Agregar colaboración</a>
</body>
</html>
</jsp:body>
</t:paginabasica>