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
	
	<script type="text/javascript">
	
	
	url="";
	$(document).ready(function(){

		$('.elimina').click(function(e){
			url = this.href;
			e.preventDefault();
			notif_confirm({
			'message': '�Borrar esta petici�n?',
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
				'msg': 'Petici�n borrado!',
				'position': 'center'
			})
		}else{
			notif({
				'type': 'error',
				'msg': 'Petici�n no borrado!',
				'position': 'center'
			})
		}
	}	
	</script>
	<h1>Lista de Peticiones</h1>
	<table class="table">
		<thead class="cabecera">
		<tr>
		<c:if test='${usuario.rol=="ADMIN"}'>
			<th>id_peticion</th>
		</c:if>
			<th>Fecha inicio</th>
			<th>Fecha fin</th>
			<th>Descripci�n</th>
			<th>Usuario</th>
		<c:if test='${usuario.rol=="ADMIN"}'>
			<th>id_habilidad</th>
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
					<td>${peticion.descripcion}</td>
					<td>${peticion.usuario}</td>
				<c:if test='${usuario.rol=="ADMIN"}'>
					<td>${peticion.idHabilidad}</td>
				</c:if>
				<!-- 	<c:if test='${accesible == true}'>
						<td><a type="button" class="btn btn-default" href="../update/${peticion.usuario}/${peticion.idPeticion}.html">Edita</a>
						<td><a type="button" class="elimina btn btn-default" href="../delete/${peticion.usuario}/${peticion.idPeticion}.html">Elimina</a>		
					</c:if> -->
					<c:if test='${usuario.rol=="ADMIN"}'>
						<td><a type="button" class="btn btn-success" href="./update/${peticion.usuario}/${peticion.idPeticion}.html"><i class="fa fa-pencil" aria-hidden="true"></i> Editar</a>
						<td><a type="button" class="elimina btn btn-danger" href="./delete/${peticion.usuario}/${peticion.idPeticion}.html"><i class="fa fa-trash" aria-hidden="true"></i> Eliminar</a>		
						<td><a type="button" class="btn btn-primary" href="../colaboracion/add.html"><i class="fa fa-plus" aria-hidden="true"></i> Crear colaboracion</a></td>
					</c:if>
					<c:if test='${accesible == false}'>
						<td><a type="button" class="btn btn-primary" href="../colaboracion/addPeticion/${peticion.idPeticion}.html"><i class="fa fa-plus" aria-hidden="true"></i> Crear colaboracion</a></td>
					</c:if>
				</tr>
			</c:if>
		</c:forEach>
	</table>
	<c:if test='${accesible == true}'>
		<a type="button" class="btn btn-primary" href="add.html"><i class="fa fa-plus" aria-hidden="true"></i> Agregar petici�n</a>
	</c:if>
	<!--  
	<c:if test='${accesible == false}'>
		<a type="button" class="btn btn-default" href="../add.html">Agregar petici�n</a>
	</c:if>  -->

</jsp:body>
</t:paginabasica>