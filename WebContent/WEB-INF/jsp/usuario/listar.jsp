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
	<script type='text/javascript' src='${pageContext.request.contextPath}/js/moment.js'></script>
	<script type='text/javascript' src='${pageContext.request.contextPath}/js/moment-with-locales.js'></script>
	<script type='text/javascript' src='${pageContext.request.contextPath}/js/bootstrap-table-es-SP.js'></script>
	
	<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/css/notifIt.css'>
		<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/css/style.css'>
	
	
	<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet">
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>

<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.js"></script>
	

 
 	<script type="text/javascript">
	
	usuario="";
	
	url="";
	$(document).ready(function(){

		$('.elimina').click(function(e){
			url = this.href;
			e.preventDefault();
			notif_confirm({
			'message': '�Borrar este usuario?',
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
				'msg': '�Usuario borrado!',
				'position': 'center'
			})
			setInterval(function(){ window.location.href = url; },2000);

		}else{
			notif({
				'type': 'error',
				'msg': '�Usuario no borrado!',
				'position': 'center'
			})
		}
	}	
	

	$(document).ready(function(){
		
		
		$('#cancelar').click(function(e){
			notif({
				'type': 'error',
				'msg': '�Usuario no bloqueado!',
				'position': 'center'
			})
		});
		
		$('.desbloquea').click(function(e){
			url = this.href;
			e.preventDefault();
			notif_confirm({
			'message': '�Desbloquear este usuario?',
			'textaccept': '�S�!',
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
				'msg': '�Usuario desbloqueado!',
				'position': 'center'
			})
			setInterval(function(){ window.location.href = url; },2000);
		}else{
			notif({
				'type': 'error',
				'msg': '�Usuario no bloqueado!',
				'position': 'center'
			})
		}
	}	
	
	$(function() {
    	$( "#blockDay" ).datepicker({ dateFormat: 'dd-mm-yy' });

	});

	
	</script>
	<script>
	function submitform() {
		
		  if(moment(document.getElementById('blockDay').value, 'DD-MM-YYYY',true).isValid() ) {
		    user = document.getElementById('userBlock').value;
			
			blockday = document.getElementById('blockDay').value;

			notif({
				'type': 'success',
				'msg': '�Usuario bloqueado!',
				'position': 'center'
			});
			
			setInterval(function(){  $('#seleccionarFecha').submit(); },2000);
			document.getElementById('userBlock').value = user;
			document.getElementById('blockDay').value = blockday;
		  } else {
			  $('#blockDay').get(0).setCustomValidity('Introduce una fecha');

/* 		    	document.getElementById('blockDay').setCustomValidity('');
*/		  }
		}
	
	
	</script>

<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div style="margin-top:40%" class="modal-content">
      <div style="background-color: rgba(232, 105, 28, 0.85); color: white;" class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">�Hasta qu� fecha debe estar bloqueado el usuario?</h4>
      </div>
      <div class="modal-body">
      
      <form:form id="seleccionarFecha" method="POST" action="blockUser.html">
      
       	<label>Fecha de fin de bloqueo</label>
  		<input  id="blockDay" class="form-control" placeholder="dd-mm-yyyy" name="blockDay" required>
  		<input id="userBlock" name="userBlock" type="text" style="display:none">
  		<br>
        <button onclick="submitform()" class="btn btn-success" >Bloquear usuario con esta fecha</button>
     
        <button id="cancelar" type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
       </form:form>
      
  		
      </div>
      <!-- <div class="modal-footer">
      </div> -->
    </div>

  </div>
</div>
		<a type="button" class="btn btn-primary" href="add.html"><i class="fa fa-plus" aria-hidden="true"></i> Agregar usuario</a>
	
	<table id="table" class="table table-hover  table-sm" data-toggle="table" data-query-params="queryParams"
       data-pagination="true"
       data-search="true"
       data-page-list="[7, 14, 50]"
       data-page-size ="7"
              >
	  <thead class="cabecera">
	  
		<tr >
			<th data-field="username" style="vertical-align: middle">Nombre usuario</th>
			<th data-field="correo" style="vertical-align: middle">Correo</th>
			<th data-field="name" style="vertical-align: middle">Nombre</th>
			<th data-field="dni" style="vertical-align: middle">Dni</th>
			<th data-field="deleted" style="vertical-align: middle">Eliminado</th>
			<th data-field="block" style="vertical-align: middle">Bloqueado</th>
			<th data-field="dataend">Fecha fin bloqueo</th>
			<th></th>
			<th></th>
			<th></th>
			
		</tr>
		</thead>
		<tbody >
		
		<c:forEach items="${usuarios}" var="usuario">
		<c:if test='${usuario.rol!="ADMIN"}'>
			<tr>
				<td >${usuario.usuario}</td>
<%-- 				<td>${usuario.contrasenya}</td>
 --%>			
 				<td>${usuario.correo}</td>
				<td>${usuario.nombre}</td>
				<td>${usuario.dni}</td>
				<c:if test='${usuario.eliminado==0}'>
					<td>No</td>
				</c:if>
				<c:if test='${usuario.eliminado==1}'>
					<td>S�</td>
				</c:if>
				<c:if test='${usuario.bloqueado==0}'>
					<td>No</td>
				</c:if>
				<c:if test='${usuario.bloqueado==1}'>
					<td>S�</td>
				</c:if>
				<c:if test='${usuario.bloqueado==1}'>
					<td>${usuario.fechaFinString}</td>
				</c:if>
				<c:if test='${usuario.bloqueado==0}'>
					<td></td>
				</c:if>
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
			</c:if>
		</c:forEach>
		</tbody>
	</table>
	
	
	<script>
		
		$(function () {
		    $('#table').bootstrapTable({
		    });
		});	
	
	
	</script>


</jsp:body>
</t:paginabasica>