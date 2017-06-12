<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<c:set var="usuario" scope="request" value='${session.getAttribute("usuarioLogin")}'/>
<t:paginabasica title="EI1027">
<jsp:body>
<html> 
<head>
<title>Gestionar Habilidades</title>
</head>
<body>
	<h2 class="titulo">Lista de Habilidades</h2>
	<script type='text/javascript' src='${pageContext.request.contextPath}/js/notifIt.js'></script>
	<script type='text/javascript' src='${pageContext.request.contextPath}/js/notifIt.min.js'></script>
	
	<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/css/notifIt.css'>
	
	
 	<script type="text/javascript">
	
	
	url="";
	$(document).ready(function(){

		$('.activa').click(function(e){
			url = this.href;
			e.preventDefault();
			notif_confirm({
			'message': '¿Activar esta habilidad?',
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
				'msg': '¡Habilidad activada!',
				'position': 'center'
			})
			setInterval(function(){ window.location.href = url; },2000);
			
		}else{
			notif({
				'type': 'error',
				'msg': '¡Habilidad no activada',
				'position': 'center'
			})
		}
	}	
	
	$(document).ready(function(){

		$('.cancela').click(function(e){
			url = this.href;
			e.preventDefault();
			notif_confirm({
			'message': '¿Cancelar esta habilidad?',
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
				'msg': '¡Habilidad cancelada!',
				'position': 'center'
			})
			setInterval(function(){ window.location.href = url; },2000);

		}else{
			notif({
				'type': 'error',
				'msg': '¡Habilidad no cancelada!',
				'position': 'center'
			})
		}
	}	
	
	
	</script> 
	
	
	<table class="table">
		  <thead class="cabecera">
	
		<tr>
			<th>Nombre</th>
			<th>Tipo</th>
			<th>Descripción</th>
			<th>Nivel</th>
			<c:choose>	
				<c:when test='${usuario.rol=="ADMIN"}'>
					<th>Estado</th>
				</c:when>
				
		</c:choose>
		<th></th>
			<th></th>
		</tr>
		</thead>
		<c:forEach items="${habilidades}" var="habilidad">
			<tr>
				<td>${habilidad.nombre}</td>
				<td>${habilidad.tipo}</td>
				<td>${habilidad.descripcion}</td>
				<td>${habilidad.nivel}</td>
				<c:choose>	
					<c:when test='${usuario.rol=="ADMIN"}'>
					<td>${habilidad.estado}</td>
						<td><a type="button" class="btn btn-success" href="update/${habilidad.idHabilidad}.html"><i class="fa fa-pencil" aria-hidden="true"></i> Editar</a>
						</td>
						<c:if test='${habilidad.estado=="ACTIVO"}'>
						<td><a type="button" class="cancela btn btn-danger" href="cancelar/${habilidad.idHabilidad}.html"><i class="fa fa-trash" aria-hidden="true"></i> Cancelar habilidad</a>		
						</td>
						</c:if>
						<c:if test='${habilidad.estado=="CANCELADO"}'>
						<td><a type="button" class="activa btn btn-info" href="activar/${habilidad.idHabilidad}.html"><i class="fa fa-trash" aria-hidden="true"></i> Activar habilidad</a>		
						</td>
						</c:if>
					</c:when>
				</c:choose>
			</tr>
		</c:forEach>
	</table>
	<c:choose>	
		<c:when test='${usuario.rol=="ADMIN"}'>
			<a type="button" class="btn btn-primary" href="add.html"><i class="fa fa-plus" aria-hidden="true"></i> Agregar habilidad</a>
		</c:when>
	</c:choose>
</body>
</html>
</jsp:body>
</t:paginabasica>