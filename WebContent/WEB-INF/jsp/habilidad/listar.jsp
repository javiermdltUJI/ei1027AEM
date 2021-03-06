<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<c:set var="usuario" scope="request" value='${session.getAttribute("usuarioLogin")}'/>

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
		<c:if test='${usuario.rol=="ADMIN"}'>
			<th>id_habilidad</th>
		</c:if>
			<th>Nombre</th>
			<th>Tipo</th>
			<th>Descripción</th>
			<th>Nivel</th>
			<c:choose>	
				<c:when test='${usuario.rol=="ADMIN"}'>
					<th>Estado</th>
				</c:when>
		</c:choose>
		</tr>
		<c:forEach items="${habilidades}" var="habilidad">
			<tr>
			<c:if test='${usuario.rol=="ADMIN"}'>
				<td>${habilidad.idHabilidad}</td>
			</c:if>
				<td>${habilidad.nombre}</td>
				<td>${habilidad.tipo}</td>
				<td>${habilidad.descripcion}</td>
				<td>${habilidad.nivel}</td>
				<c:choose>	
					<c:when test='${usuario.rol=="ADMIN"}'>
					<td>${habilidad.estado}</td>
						<td><a type="button" class="btn btn-default" href="update/${habilidad.idHabilidad}.html">Edita</a>
						<td><a type="button" class="btn btn-default" href="delete/${habilidad.idHabilidad}.html">Elimina</a>		
					</c:when>
				</c:choose>
			</tr>
		</c:forEach>
	</table>
	<c:choose>	
		<c:when test='${usuario.rol=="ADMIN"}'>
			<a type="button" class="btn btn-default" href="add.html">Agregar habilidad</a>
		</c:when>
	</c:choose>
</body>
</html>
</jsp:body>
</t:paginabasica>