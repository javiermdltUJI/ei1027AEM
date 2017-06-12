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
		<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/css/style.css'>
	
	
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
	
	usuario="";
	
	url="";
	$(document).ready(function(){

		$('.elimina').click(function(e){
			url = this.href;
			e.preventDefault();
			notif_confirm({
			'message': '¿Borrar este usuario?',
			'textaccept': 'Si!',
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
				'msg': '¡Usuario borrado!',
				'position': 'center'
			})
			setInterval(function(){ window.location.href = url; },2000);

		}else{
			notif({
				'type': 'error',
				'msg': '¡Usuario no borrado!',
				'position': 'center'
			})
		}
	}	
	
	/* $(document).ready(function(){

		$('.bloquea').click(function(e){
			url = this.href;
			e.preventDefault();
			notif_confirm({
			'message': '¿Bloquear este usuario?',
			'textaccept': 'Yes!',
			'textcancel': 'No',
			'fullscreen': true,
			'callback': myCallback2
			})
		});
	}); */
	

	$(document).ready(function(){
		
		$('#okBloquear').click(function(e){
			
			user = document.getElementById('userBlock').value;
			alert(user);
			
			blockday = document.getElementById('blockDay').value;
			alert(blockday);

			e.preventDefault();
			notif({
				'type': 'success',
				'msg': '¡Usuario bloqueado!',
				'position': 'center'
			})
			setInterval(function(){ window.location.href = url; },2000);
			document.getElementById('userBlock').value = user;
			document.getElementById('blockDay').value = blockday; 

	         $('#seleccionarFecha').submit();

		});

		$('#cancelar').click(function(e){
			notif({
				'type': 'error',
				'msg': '¡Usuario no bloqueado!',
				'position': 'center'
			})
		});
		
		$('.desbloquea').click(function(e){
			url = this.href;
			e.preventDefault();
			notif_confirm({
			'message': '¿Desbloquear este usuario?',
			'textaccept': 'Si!',
			'textcancel': 'No',
			'fullscreen': true,
			'callback': myCallback2
			})
		});
	});
	
	var myCallback2 = function(choice){
		if(choice){
			notif({
				'type': 'success',
				'msg': '¡Usuario desbloqueado!',
				'position': 'center'
			})
			setInterval(function(){ window.location.href = url; },2000);
		}else{
			notif({
				'type': 'error',
				'msg': '¡Usuario no bloqueado!',
				'position': 'center'
			})
		}
	}	
	
	$(function() {
    	$( "#blockDay" ).datepicker({ dateFormat: 'dd-mm-yy' });

	});

	
	</script>
		

<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div style="margin-top:40%" class="modal-content">
      <div style="background-color: rgba(232, 105, 28, 0.85); color: white;" class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">¿Hasta qué fecha debe estar bloqueado el usuario?</h4>
      </div>
      <div class="modal-body">
      
      <form:form id="seleccionarFecha" method="POST" action="blockUser.html">
      
       	<label>Fecha de fin de bloqueo</label>
  		<input  id="blockDay" class="form-control" type="date" name="blockDay" required>
  		<input id="userBlock" name="userBlock" type="text" style="display:none">
  		<br>
        <button type="submit" id="okBloquear" class="btn btn-success" >Bloquear usuario con esta fecha</button>
     
        <button id="cancelar" type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
       </form:form>
      
  		
      </div>
      <!-- <div class="modal-footer">
      </div> -->
    </div>

  </div>
</div>
	
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
				<c:if test='${usuario.eliminado==0}'>
					<td>No</td>
				</c:if>
				<c:if test='${usuario.eliminado==1}'>
					<td>Sí</td>
				</c:if>
				<c:if test='${usuario.bloqueado==0}'>
					<td>No</td>
				</c:if>
				<c:if test='${usuario.bloqueado==1}'>
					<td>Sí</td>
				</c:if>
				<c:if test='${usuario.bloqueado==1}'>
					<td>${usuario.fechaFinString}</td>
				</c:if>
				<c:if test='${usuario.bloqueado==0}'>
					<td></td>
				</c:if>
				<td>${usuario.rol}</td>
				<td><a type="button" class="btn btn-success" href="update/${usuario.usuario}.html"><i class="fa fa-pencil" aria-hidden="true"></i> Editar</a>
				<td><a style="background=transparent" type="button" class="elimina btn btn-danger" href="delete/${usuario.usuario}.html"><i class="fa fa-trash" aria-hidden="true"></i> Eliminar</a>
				
				<c:if test='${usuario.bloqueado==0}'>
				
					<%--
					 este a tiene que tener 
					 
					<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>
					
					href="lock/${usuario.usuario}.html"
					
					poner un onclick en los botones que guarden en una varible el usuario que es o generar un evento.
					
					document.getElementById('okBloquear').data-href='update/${usuario.usuario}.html';
					
					
					https://stackoverflow.com/questions/33281031/get-date-from-jsp-to-controller-in-spring-mvc
					
					https://stackoverflow.com/questions/5590036/passing-parameters-from-jsp-to-controller-in-spring-mvc
					
					document.getElementById('okBloquear').href='lock/${usuario.usuario}.html';
					 --%>
					 
 					 <td><a onclick="document.getElementById('userBlock').value='${usuario.usuario}'" type="button" class="bloquea btn btn-warning"  data-toggle="modal" data-target="#myModal" ><i class="fa fa-lock" aria-hidden="true"></i> Bloquear</a></td>	
					 
					 
				</c:if>
				<c:if test='${usuario.bloqueado==1}'>
					<td><a type="button" class="desbloquea btn btn-info" href="unlock/${usuario.usuario}.html"><i class="fa fa-unlock" aria-hidden="true"></i> Desbloquear</a></td>	
				</c:if>	
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<a type="button" class="btn btn-primary" href="add.html"><i class="fa fa-plus" aria-hidden="true"></i> Agregar usuario</a>
	
	
	


</jsp:body>
</t:paginabasica>