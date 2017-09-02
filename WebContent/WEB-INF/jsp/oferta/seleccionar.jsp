<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="usuario" scope="request" value='${session.getAttribute("usuarioLogin")}'/>


<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<title>Gestionar Ofertas</title>
</head>
<body>
	<h2 class="titulo">Lista de Ofertas</h2>
	<p> Seleccionar una colaboración con fechas entre: 
	<strong>${colaboracion.fechaIniString}</strong> y 
	<strong>${colaboracion.fechaFinString}</strong>, si no existe niguna petición puedes crearla.
	</p>
	<script type='text/javascript' src='${pageContext.request.contextPath}/js/notifIt.js'></script>
	<script type='text/javascript' src='${pageContext.request.contextPath}/js/notifIt.min.js'></script>
	
	<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/css/notifIt.css'>
	
	
	
	<script>
	
	$(document).ready(function(){

		$('.selecciona').click(function(e){
			notif({
				'type': 'success',
				'msg': '¡Colaboracion creada!',
				'position': 'center'
			});
			
		});
		
		$('.addOferta').click(function(e){

			notif({
				'type': 'success',
				'msg': '¡Colaboracion creada!',
				'position': 'center'
			});
		});
		
	
	});
	</script>
	
	
	<c:if test='${fn:length(collection)==0}'>
		<c:choose>
			<c:when test='${usuario.rol=="ESTUDIANTE"}'>
				<p><strong><i>No existen ofertas que se ajusten a la colaboración que se quiere crear. Para generar automáticamente una oferta conforme a la colaboración selecciona 'Agregar oferta'</i></strong> </p>
			</c:when>
			<c:otherwise>
				<p><strong><i>No existen ofertas que se ajusten a la colaboración que se quiere crear. Para generar automáticamente una oferta conforme a la colaboración selecciona 'Seleccionar usuario' para poder crear una oferta para ese usuario.</i></strong> </p>
			</c:otherwise>
		</c:choose>
	</c:if>
	<c:if test='${fn:length(collection)!=0}'>
	<table class="table">
		<thead class="cabecera">
	
		<tr>
		<c:if test='${usuario.rol=="ADMIN"}'>
			<th>id_peticion</th>
		</c:if>
			<th>Fecha inicio</th>
			<th>Fecha fin</th>
			<th>Más info.</th>
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
					<td><a type="button" class="selecciona btn btn-default" href="../colaboracion/creada/${oferta.idOferta}.html">Seleccionar</a></td>
				</c:if>
				<c:if test='${accesible == false}'>
					<td><a type="button" class="selecciona btn btn-primary" href="../colaboracion/creadaOferta/${oferta.idOferta}.html"><i class="fa fa-check" aria-hidden="true"></i>
					 Seleccionar</a></td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
	</c:if>
	
	<c:if test='${accesible == true}'>
		<a type="button" class="addOferta btn btn-primary" href="../addConHabilidad.html">Agregar oferta</a>
	</c:if>
	<c:if test='${accesible == false}'>
		<a type="button" class="addOferta2 btn btn-primary" href="addConHabilidadUsuario.html">Agregar oferta</a>
	</c:if>
</body>
</html>
</jsp:body>
</t:paginabasica>