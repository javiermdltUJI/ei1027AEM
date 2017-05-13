<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="usuario" scope="request" value='${session.getAttribute("usuarioLogin")}'/>


<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<title>Gestionar Ofertas</title>
</head>
<body>
	<h2 class="titulo">Lista de Ofertas</h2>
	<table class="table">
		<thead class="cabecera">
	
		<tr>
		<c:if test='${usuario.rol=="ADMIN"}'>
			<th>id_peticion</th>
		</c:if>
			<th>Fecha inicio</th>
			<th>Fecha fin</th>
			<th>Descripción</th>
			<th>Usuario</th>
		<c:if test='${usuario.rol=="ADMIN"}'>
			<th>id_habilidad</th>
		</c:if>
		<c:if test='${usuario.rol!="ADMIN"}'>
			<th></th>
		</c:if>
		</tr>
		</thead>
		<c:forEach items="${ofertas}" var="oferta">
			<tr>
			<c:if test='${usuario.rol=="ADMIN"}'>
				<td>${oferta.idOferta}</td>
			</c:if>
				<td>${oferta.fechaIniString}</td>
				<td>${oferta.fechaFinString}</td>
				<td>${oferta.descripcion}</td>
				<td>${oferta.usuario}</td>
			<c:if test='${usuario.rol=="ADMIN"}'>
				<td>${oferta.idHabilidad}</td>
			</c:if>
				<c:if test='${accesible == true}'>
					<td><a type="button" class="btn btn-default" href="../update/${oferta.usuario}/${oferta.idOferta}.html">Edita</a>
					<td><a type="button" class="btn btn-default" href="../delete/${oferta.usuario}/${oferta.idOferta}.html">Elimina</a>		
				</c:if>
				<c:if test='${usuario.rol=="ADMIN"}'>
					<td><a type="button" class="btn btn-default" href="./update/${oferta.usuario}/${oferta.idOferta}.html">Edita</a>
					<td><a type="button" class="btn btn-default" href="./delete/${oferta.usuario}/${oferta.idOferta}.html">Elimina</a>		
					<td><a type="button" class="btn btn-default" href="../colaboracion/creadaOferta/${oferta.idOferta}.html">Seleccionar</a></td>
				</c:if>
				<c:if test='${accesible == false}'>
					<td><a type="button" class="btn btn-primary" href="../colaboracion/creadaOferta/${oferta.idOferta}.html"><i class="fa fa-check" aria-hidden="true"></i>
					 Seleccionar</a></td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
	<c:if test='${accesible == true}'>
		<a type="button" class="btn btn-primary" href="../addConHabilidad.html">Agregar petición</a>
	</c:if>
	<c:if test='${accesible == false}'>
		<a type="button" class="btn btn-primary" href="addConHabilidad.html">Agregar petición</a>
	</c:if>
</body>
</html>
</jsp:body>
</t:paginabasica>