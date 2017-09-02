<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>
<title>Gestionar Ofertas</title>

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
	<h2 class="titulo">Lista de Ofertas</h2>
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
			<th style="vertical-align: middle">id_oferta</th>
		</c:if>
			<th>Fecha inicio</th>
			<th>Fecha fin</th>
			<th style="vertical-align: middle">Habilidad</th>
			<th style="vertical-align: middle">Nivel</th>
		
			<th style="vertical-align: middle">Más info.</th>
		<c:if test='${usuario.usuario!=sessionScope.mis && usuario.rol!="ADMIN"}'>
			<th style="vertical-align: middle">Usuario</th>
			<th></th>
		</c:if>
		<c:if test='${usuario!=null}'>
			<c:if test='${usuario.usuario==sessionScope.mis}'>
				<th></th>
				<th></th>
			</c:if>
		</c:if>
		<c:if test='${usuario.rol=="ADMIN"}'>
			<th style="vertical-align: middle">Usuario</th>
			<th></th>
			<th></th>
			<th></th>
		</c:if>
		</tr>
		</thead>
		<c:forEach items="${ofertas}" var="oferta">
			<jsp:useBean id="now" class="java.util.Date"/>	
			<c:if test='${now.time < oferta.fechaFin.time}'>
				<tr>
				<c:if test='${usuario.rol=="ADMIN"}'>
					<td>${oferta.idOferta}</td>
				</c:if>
					<td>${oferta.fechaIniString}</td>
					<td>${oferta.fechaFinString}</td>
					<td>${oferta.descripcionHabilidad}</td>
					<td>${oferta.nivelHabilidad}</td>
					
					<td>${oferta.descripcion}</td>
				<c:if test='${usuario.usuario != sessionScope.mis}'>
					<td>${oferta.usuario}</td>
				</c:if>
				
					<c:if test='${usuario.usuario == sessionScope.mis && usuario.usuario != null}'>
						<td><a type="button" class="btn btn-success" href="../update/${oferta.usuario}/${oferta.idOferta}.html"><i class="fa fa-pencil" aria-hidden="true"></i> Edita</a></td>
						<td><a type="button" class="elimina btn btn-danger" href="../delete/${oferta.usuario}/${oferta.idOferta}.html"><i class="fa fa-trash" aria-hidden="true"></i> Elimina</a></td>		
					</c:if>  
					<c:if test='${usuario.rol=="ADMIN"}'>
						<td><a type="button" class="btn btn-success" href="./update/${oferta.usuario}/${oferta.idOferta}.html"><i class="fa fa-pencil" aria-hidden="true"></i> Editar</a></td>
						<td><a type="button" class="elimina btn btn-danger" href="./delete/${oferta.usuario}/${oferta.idOferta}.html"><i class="fa fa-trash" aria-hidden="true"></i> Eliminar</a></td>
						<td><a type="button" class="btn btn-primary" href="../colaboracion/addOferta/${oferta.idOferta}.html"><i class="fa fa-plus" aria-hidden="true"></i> Crear colaboración</a></td>
					</c:if>
					<c:if test='${accesible == false}'>
						<td><a type="button" class="btn btn-primary" href="../colaboracion/addOferta/${oferta.idOferta}.html"><i class="fa fa-plus" aria-hidden="true"></i> Crear colaboración</a></td>
					</c:if>
				</tr>
			</c:if>
		</c:forEach>
	</table>
	<script>
		
		$(function () {
		    $('#table').bootstrapTable({
		    });
		});	
	
	
	</script>
	<c:if test='${usuario.rol=="ADMIN"}'>
	
		<a type="button" class="btn btn-primary" href="add.html"><i class="fa fa-plus" aria-hidden="true"></i> Agregar oferta</a>
	</c:if>
	 
	<c:if test='${usuario.usuario == sessionScope.mis && usuario.usuario != null}'>
		<a type="button" class="btn btn-primary" href="../add.html">Agregar oferta</a>			
	</c:if>
					

</jsp:body>
</t:paginabasica>