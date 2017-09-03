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
	<p> Seleccionar una petición con fechas entre: 
	<strong>${colaboracion.fechaIniString}</strong> y 
	<strong>${colaboracion.fechaFinString}</strong>, si no existe niguna petición puedes crearla.
	</p>
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.css">

<!-- Latest compiled and minified JavaScript -->
	<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.js"></script>
	<script type='text/javascript' src='${pageContext.request.contextPath}/js/notifIt.js'></script>
	<script type='text/javascript' src='${pageContext.request.contextPath}/js/notifIt.min.js'></script>
	
	<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/css/notifIt.css'>
	
	
	<script type="text/javascript">
	
	
	url="";
	$(document).ready(function(){

		$('.elimina').click(function(e){
			url = this.href;
			e.preventDefault();
			notif_confirm({
			'message': '¿Borrar esta oferta?',
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
				'msg': '¡Oferta borrada!',
				'position': 'center'
			})
			setInterval(function(){ window.location.href = url; },2000);

		}else{
			notif({
				'type': 'error',
				'msg': '¡Oferta no borrada!',
				'position': 'center'
			})
		}
	}

	
	
		
	
	</script>
	
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
	
	
	<c:if test='${fn:length(ofertas)==0}'>
		<c:choose>
			<c:when test='${usuario.rol=="ESTUDIANTE"}'>
				<p><strong><i>No existen ofertas que se ajusten a la colaboración que se quiere crear. Para generar automáticamente una oferta conforme a la colaboración selecciona 'Agregar oferta'</i></strong> </p>
			</c:when>
			<c:otherwise>
				<p><strong><i>No existen ofertas que se ajusten a la colaboración que se quiere crear. Para generar automáticamente una oferta conforme a la colaboración selecciona 'Seleccionar usuario' para poder crear una oferta para ese usuario.</i></strong> </p>
			</c:otherwise>
		</c:choose>
	</c:if>
	<c:if test='${fn:length(ofertas)!=0}'>
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
			<th>id_peticion</th>
		</c:if>
			<th>Fecha inicio</th>
			<th>Fecha fin</th>
			<th>Más info.</th>
			<th>Usuario</th>
			<th></th>
			<!--<th></th>
			<th></th>-->
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
				<c:if test='${accesible == true}'>
					<td><a type="button" class="btn btn-success" href="../update/${oferta.usuario}/${oferta.idOferta}.html"><i class="fa fa-pencil" aria-hidden="true"></i> Edita</a>
					<!--<td><a type="button"  class="elimina btn btn-danger" href="../delete/${oferta.usuario}/${oferta.idOferta}.html"><i class="fa fa-trash" aria-hidden="true"></i> Elimina</a>-->	
					<td><a type="button" class="selecciona btn btn-primary" href="../colaboracion/creadaOferta/${oferta.idOferta}.html"><i class="fa fa-check" aria-hidden="true"></i>	
					 Seleccionar</a></td>
				</c:if>
				<c:if test='${usuario.rol=="ADMIN"}'>
					<!--<td><a type="button" class="btn btn-success" href="./update/${oferta.usuario}/${oferta.idOferta}.html"><i class="fa fa-pencil" aria-hidden="true"></i> Edita</a>
					<td><a type="button"  class="elimina btn btn-danger" href="./delete/${oferta.usuario}/${oferta.idOferta}.html"><i class="fa fa-trash" aria-hidden="true"></i> Elimina</a>-->		
				</c:if>
				<c:if test='${accesible == false}'>
					<td><a type="button" class="selecciona btn btn-primary" href="../colaboracion/creadaOferta/${oferta.idOferta}.html"><i class="fa fa-check" aria-hidden="true"></i>
					 Seleccionar</a></td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
	<script>

		$(function () {
		    $('#table').bootstrapTable({
		    });
		});	


	</script>
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