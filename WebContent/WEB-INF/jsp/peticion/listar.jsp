<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="usuario" scope="request" value='${session.getAttribute("usuarioLogin")}'/>
<t:paginabasica title="EI1027">
<jsp:body>

<title>Gestionar Peticiones</title>


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
			'message': '�Borrar esta petici�n?',
			'textaccept': '�S�!',
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
				'msg': '�Petici�n borrado!',
				'position': 'center'
			})
			setInterval(function(){ window.location.href = url; },2000);

		}else{
			notif({
				'type': 'error',
				'msg': '�Petici�n no borrado!',
				'position': 'center'
			})
		}
	}	
	
	</script>
	<h2 class="titulo">Lista de Peticiones</h2>
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
			<th style="vertical-align: middle">id_peticion</th>
		</c:if>
			<th>Fecha inicio</th>
			<th>Fecha fin</th>
			<th style="vertical-align: middle">Habilidad</th>
			<th style="vertical-align: middle">Nivel</th>
			
			<th style="vertical-align: middle">M�s info.</th>
		<c:if test='${usuario.usuario != sessionScope.mis && usuario.rol!="ADMIN"}'>
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
		<c:forEach items="${peticiones}" var="peticion">
			<jsp:useBean id="now" class="java.util.Date"/>	
			<c:if test='${now.time < peticion.fechaFin.time}'>
				<tr>
				<c:if test='${usuario.rol=="ADMIN"}'>
					<td>${peticion.idPeticion}</td>
				</c:if>
					<td>${peticion.fechaIniString}</td>
					<td>${peticion.fechaFinString}</td>
					<td>${peticion.descripcionHabilidad}</td>
					<td>${peticion.nivelHabilidad}</td>
					
					<td>${peticion.descripcion}</td>
				<c:if test='${usuario.usuario!=sessionScope.mis}'>
					<td>${peticion.usuario}</td>
				</c:if>
				<c:if test='${usuario.usuario == sessionScope.mis && usuario.usuario != null}'>
						<td><a type="button" class="btn btn-success" href="../update/${peticion.usuario}/${peticion.idPeticion}.html"><i class="fa fa-pencil" aria-hidden="true"></i> Edita</a>
						<td><a type="button" class="elimina btn btn-danger" href="../delete/${peticion.usuario}/${peticion.idPeticion}.html"><i class="fa fa-trash" aria-hidden="true"></i> Elimina</a>		
					</c:if>
					<c:if test='${usuario.rol=="ADMIN"}'>
						<td><a type="button" class="btn btn-success" href="./update/${peticion.usuario}/${peticion.idPeticion}.html"><i class="fa fa-pencil" aria-hidden="true"></i> Editar</a>
						<td><a type="button" class="elimina btn btn-danger" href="./delete/${peticion.usuario}/${peticion.idPeticion}.html"><i class="fa fa-trash" aria-hidden="true"></i> Eliminar</a>		
						<td><a type="button" class="btn btn-primary" href="../colaboracion/addPeticion/${peticion.idPeticion}.html"><i class="fa fa-plus" aria-hidden="true"></i> Crear colaboraci�n</a></td>
					</c:if>
					<c:if test='${accesible == false}'>
						<td><a type="button" class="btn btn-primary" href="../colaboracion/addPeticion/${peticion.idPeticion}.html"><i class="fa fa-plus" aria-hidden="true"></i> Crear colaboraci�n</a></td>
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
		<a type="button" class="btn btn-primary" href="add.html"><i class="fa fa-plus" aria-hidden="true"></i> Agregar petici�n</a>
	</c:if>
	  
	<c:if test='${usuario.usuario == sessionScope.mis && usuario.usuario != null}'>
		<a type="button" class="btn btn-primary" href="../add.html">Agregar petici�n</a>
	</c:if>  

</jsp:body>
</t:paginabasica>