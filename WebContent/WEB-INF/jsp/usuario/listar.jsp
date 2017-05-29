<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>

<title>Gestionar Usuarios</title>

	<h2 class="titulo">Lista de Usuarios</h2>
	
	<script type='text/javascript' src='${pageContext.request.contextPath}/js/notifIt.js'></script>
	<script type='text/javascript' src='${pageContext.request.contextPath}/js/notifIt.min.js'></script>
	
	<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/css/notifIt.css'>
	
	
	<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet">
	
	<!-- 	<script>
	$('#table').bootstrapTable({
	    columns: [{
	        field: 'username',
	        title: 'nombre usuario'
	    }, {
	        field: 'Correo',
	        title: 'correo'
	    }, {
	        field: 'nombre',
	        title: 'nombre'
	    }, {
	        field: 'dni',
	        title: 'dni'
	    }, {
	        field: 'contador de bloqueo',
	        title: 'contador de bloqueo'
	    }, {
	        field: 'bloqueo',
	        title: 'bloqueo'
	    }, {
	        field: 'rol',
	        title: 'rol'
	    }],data: [{}]
	    
	});
	
/* 	$('#table').bootstrapTable('removeByUniqueId',0);
 */	</script> -->
 
 	<script type="text/javascript">
	
	
	url="";
	$(document).ready(function(){

		$('.elimina').click(function(e){
			url = this.href;
			e.preventDefault();
			notif_confirm({
			'message': '¿Borrar este usuario?',
			'textaccept': 'Yes!',
			'textcancel': 'No',
			'fullscreen': true,
			'callback': myCallback
			})
		});
	});
	
	var myCallback = function(choice){
		if(choice){
			window.location.href = url;
			notif({
				'type': 'success',
				'msg': 'Usuario borrado!',
				'position': 'center'
			})
		}else{
			notif({
				'type': 'error',
				'msg': 'Usuario no borrado!',
				'position': 'center'
			})
		}
	}	
	
	</script> 
	<table id="table" class="table table-hover  table-sm">
	  <thead class="cabecera">
	  
		<tr >
			<th>Nombre usuario</th>
			<th>Correo</th>
			<th>Nombre</th>
			<th>Dni</th>
			<th>Eliminado</th>
			<th>Bloqueado</th>
			<th>Fecha fin bloqueo</th>
			<th>Rol</th>
			<th></th>
			<th></th>
			<th></th>
			
		</tr>
		</thead>
		<tbody >
		
		<c:forEach items="${usuarios}" var="usuario">
			<tr>
				<td >${usuario.usuario}</td>
<%-- 				<td>${usuario.contrasenya}</td>
 --%>				<td>${usuario.correo}</td>
				<td>${usuario.nombre}</td>
				<td>${usuario.dni}</td>
				<td>${usuario.eliminado}</td>
				<td>${usuario.bloqueado}</td>
				<td>${usuario.fechaFinString}</td>
				<td>${usuario.rol}</td>
				<td><a type="button" class="btn btn-success" href="update/${usuario.usuario}.html"><i class="fa fa-pencil" aria-hidden="true"></i> Editar</a>
				<td><a style="background=transparent" type="button" class="elimina btn btn-danger" href="delete/${usuario.usuario}.html"><i class="fa fa-trash" aria-hidden="true"></i> Eliminar</a>
				
				<c:if test='${usuario.bloqueado==0}'>
					<td><a style="background=transparent" type="button" class="elimina btn btn-warning" href="lock/${usuario.usuario}.html"><i class="fa fa-lock" aria-hidden="true"></i> Bloquear</a></td>	
				</c:if>
				<c:if test='${usuario.bloqueado==1}'>
					<td><a style="background=transparent" type="button" class="elimina btn btn-info" href="unlock/${usuario.usuario}.html"><i class="fa fa-unlock" aria-hidden="true"></i> Desbloquear</a></td>	
				</c:if>	
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<a type="button" class="btn btn-primary" href="add.html"><i class="fa fa-plus" aria-hidden="true"></i> Agregar usuario</a>
	
	
	


</jsp:body>
</t:paginabasica>