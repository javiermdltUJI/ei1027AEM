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

	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.css">

<!-- Latest compiled and minified JavaScript -->
	<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.js"></script>
	

	<h2 class="titulo">Lista de Colaboraciones</h2>	
	
	<h4 class="subtitulo">Colaboraciones creadas a partir de mis ofertas: </h4>
	<script type='text/javascript' src='${pageContext.request.contextPath}/js/bootstrap-table-es-SP.js'></script>
	
	<table class="table" id="table" data-toggle="table" data-query-params="queryParams"
       data-locale="es-SP"
       data-pagination="true"
       data-search="true"
       data-page-list="[6, 14, 50]"
       data-page-size ="6">
		  <thead class="cabecera">
	
		<tr>
		<c:if test='${usuario.rol=="ADMIN"}'>
			<th>id_colaboracion</th>
		</c:if>
			<th>Fecha inicio</th>
			<th>Fecha fin</th>
			<th>Horas totales</th>
			<th>Valoración</th>
			<th>Habilidad</th>
			<th>Usuario</th>
			<th></th>
		</tr>
		</thead>
		<c:forEach items="${colaboracionesOferta}" varStatus="i" var="colaboracionesOferta">
			<tr>
			<c:if test='${usuario.rol=="ADMIN"}'>
				<td>${colaboracionesOferta.idColaboracion}</td>
			</c:if>
				<td>${colaboracionesOferta.fechaIniString}</td>
				<td>${colaboracionesOferta.fechaFinString}</td>
				<td>${colaboracionesOferta.horasTotales}</td>
				
				<td class="espacio">
					<c:forEach begin="1" end="5" var="loop">
						<c:choose>
						    <c:when test='${loop<=colaboracionesOferta.valoracion}'>
						       <i class="fa fa-star" aria-hidden="true" style="color:rgba(232, 105, 28, 0.63)"></i>
						    </c:when>    
						    <c:otherwise>
						        <i class="fa fa-star-o" aria-hidden="true" style="color:rgba(232, 105, 28, 0.63)"></i>
						    </c:otherwise>
						</c:choose>
					</c:forEach></td>
				
				<td>${habilidadesOferta[i.index].nombre}</td>
<%-- 				<td>${colaboracionesOferta.descripcion}</td>
 --%>			<td>${colaboracionesOferta.usuario}</td>
				<td><a type="button" class="btn btn-default"  disabled>* No puedes cancelar la colaboración.</a></td>		
			</tr>
		</c:forEach>
		</table>
		<script>
		
		$(function () {
		    $('#table').bootstrapTable({
		    });
		});	
	
	
	</script>
		<p style="color:gray">* Una colaboración solo puede ser cancelada por aquel que ha hecho la petición.</p>
		
		<h4 class="subtitulo">Colaboraciones creadas a partir de mis peticiones: </h4>
		<table class="table" id="table2" data-toggle="table" data-query-params="queryParams"
       data-pagination="true"
       data-search="true"
       data-page-list="[8, 14, 50]"
       data-page-size ="8">
			  <thead class="cabecera">
		
		<tr>

		<c:if test='${usuario.rol=="ADMIN"}'>
			<th>id_colaboracion</th>
		</c:if>
			<th>Fecha inicio</th>
			<th>Fecha fin</th>
			<th>Horas totales</th>
			<th>Valoración</th>
			<th>Habilidad</th>
			<th>Usuario</th>
			<th></th>
		</tr>
		</thead>
		<c:forEach items="${colaboracionesPeticion}" varStatus="j" var="colaboracionesPeticion">
			<tr>
			<c:if test='${usuario.rol=="ADMIN"}'>
				<td>${colaboracionesPeticion.idColaboracion}</td>
			</c:if>
				<td>${colaboracionesPeticion.fechaIniString}</td>
				<td>${colaboracionesPeticion.fechaFinString}</td>	
				<td>${colaboracionesPeticion.horasTotales}</td>
				
				<td class="espacio">
					<c:forEach begin="1" end="5" var="loop">
						<c:choose>
						    <c:when test='${loop<=colaboracionesPeticion.valoracion}'>
						       <i class="fa fa-star" aria-hidden="true" style="color:rgba(232, 105, 28, 0.63)"></i>
						    </c:when>    
						    <c:otherwise>
						        <i class="fa fa-star-o" aria-hidden="true" style="color:rgba(232, 105, 28, 0.63)"></i>
						    </c:otherwise>
						</c:choose>
					</c:forEach></td>
				
				<td>${habilidadesPeticion[j.index].nombre}</td>
				
<%-- 				<td>${colaboracionesPeticion.descripcion}</td>
 --%>				<td>${colaboracionesPeticion.usuario}</td>
				<jsp:useBean id="now" class="java.util.Date"/>
				<c:choose>
					<c:when test='${(colaboracionesPeticion.valoracion==0 and colaboracionesPeticion.horasTotales==0) and now.time >= colaboracionesPeticion.fechaFin.time}'>
						<td><a type="button" class="btn btn-success"  href="../update/${usuario.usuario}/${colaboracionesPeticion.idColaboracion}.html">Valorar</a></td>
					</c:when>
					<c:when test='${now.time < colaboracionesPeticion.fechaFin.time}'>
						<td><a type="button" class="btn btn-danger"  href="../cancelar/${usuario.usuario}/${colaboracionesPeticion.idColaboracion}.html">Cancelar</a></td>	
					</c:when>
					<c:otherwise>					
						<td><button type="button" class="btn btn-default disabled" disabled="disabled">Terminada</button></td>	
					</c:otherwise>
				</c:choose>
				
			</tr>
		</c:forEach>		
	</table>
	<script>
		
		$(function () {
		    $('#table2').bootstrapTable({
		    });
		});	
	
	
	</script>
	<c:remove var="mis" scope="session"/>
</body>
</html>
</jsp:body>
</t:paginabasica>