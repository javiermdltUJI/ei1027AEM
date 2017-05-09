<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>

<title>Gestionar Usuarios</title>

	<h1>Lista de Usuarios</h1>
	
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.js"></script>

<!-- Latest compiled and minified Locales -->
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/locale/bootstrap-table-zh-CN.min.js"></script>
	
	
	<table id="table" class="table table-bordered table-sm m-0">
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
<%-- 		<table id="table" class="table table-hover  table-sm">
 --%>	
	  <%-- <thead >
		<tr >
				<th>Nombre usuario</th>
			<th>Contrasenya</th>
			<th>Correo</th>
			<th>Nombre</th>
			<th>Dni</th>
			<th>Contador de bloqueo</th>
			<th>Bloqueado</th>
			<th>Rol</th>
		</tr>
		</thead> --%>
		<tbody >
		
		<c:forEach items="${usuarios}" var="usuario">
			<tr>
				<td >${usuario.usuario}</td>
<%-- 				<td>${usuario.contrasenya}</td>
 --%>				<td>${usuario.correo}</td>
				<td>${usuario.nombre}</td>
				<td>${usuario.dni}</td>
				<td>${usuario.contadorBloqueo}</td>
				<td>${usuario.bloqueado}</td>
				<td>${usuario.rol}</td>
				<td><a type="button" class="btn btn-default" href="update/${usuario.usuario}.html">Edita</a>
				<td><a style="background=transparent" type="button" class="btn btn-danger" href="delete/${usuario.usuario}.html">Elimina</a>		
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<a type="button" class="btn btn-default" href="add.html">Agregar usuario</a>
	
	
	


</jsp:body>
</t:paginabasica>