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
	<h2 class="titulo">Lista de Colaboraciones</h2>
	
	<script type='text/javascript' src='${pageContext.request.contextPath}/js/notifIt.js'></script>
	<script type='text/javascript' src='${pageContext.request.contextPath}/js/notifIt.min.js'></script>
	
	<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/css/notifIt.css'>
	
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.css">

<!-- Latest compiled and minified JavaScript -->
	<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.js"></script>
	
	
	
	<script type="text/javascript">
	
	
	url="";
	$(document).ready(function(){

		$('.elimina').click(function(e){
			url = this.href;
			e.preventDefault();
			notif_confirm({
			'message': '¿Borrar esta colaboración?',
			'textaccept': '¡Sí!',
			'textcancel': 'No',
			'fullscreen': true,
			'callback': myCallback
			})
		});
	});
	
	var myCallback = function(choice){
		if(choice){
			notif({
				'type': 'success',
				'msg': '¡Colaboración borrada!',
				'position': 'center'
			})
			setInterval(function(){ window.location.href = url; },2000);

		}else{
			notif({
				'type': 'error',
				'msg': '¡Colaboración no borrada!',
				'position': 'center'
			})
		}
	}	
	
	</script>
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
			<th> Valoración </th>
		<c:if test='${usuario.rol=="ADMIN"}'>
			<th>Ofertante</th>
			<th>Demandante</th>
			<th>Descripción</th>
			<th>Nivel</th>
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
				<td class="espacio">
					<c:forEach begin="1" end="5" var="loop">
						<c:choose>
						    <c:when test='${loop<=colaboracion.valoracion}'>
						       <i class="fa fa-star" aria-hidden="true" style="color:rgba(232, 105, 28, 0.63)"></i>
						    </c:when>    
						    <c:otherwise>
						        <i class="fa fa-star-o" aria-hidden="true" style="color:rgba(232, 105, 28, 0.63)"></i>
						    </c:otherwise>
						</c:choose>
					</c:forEach></td>
			<c:if test='${usuario.rol=="ADMIN"}'>
				<td>${colaboracion.ofertante}</td>
				<td>${colaboracion.demandante}</td>
				<td>${colaboracion.descripcion}</td>
				<td>${colaboracion.nivel}</td>
			</c:if>
				<td><a type="button" class="btn btn-success"  href="update/${colaboracion.idColaboracion}.html"><i class="fa fa-pencil" aria-hidden="true"></i> Editar</a>
				<td><a type="button" class="elimina btn btn-danger"  href="delete/${colaboracion.idColaboracion}.html"><i class="fa fa-trash" aria-hidden="true"></i> Eliminar
				</a>		
			</tr>
		</c:forEach>
	</table>
	<script>
		
		$(function () {
		    $('#table').bootstrapTable({
		    });
		});	
	
	
	</script>
	<a type="button" class="btn btn-primary" href="addColaboracion.html"><i class="fa fa-plus" aria-hidden="true"></i> Agregar colaboración</a>
</body>
</html>
</jsp:body>
</t:paginabasica>