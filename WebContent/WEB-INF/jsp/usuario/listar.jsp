<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<title>Gestionar Usuarios</title>
</head>
<body>
	<h1>Lista de Usuarios</h1>
	<table  class="table">
		<tr>
			<th>Nombre usuario</th>
			<th>Contrasenya</th>
			<th>Correo</th>
			<th>Nombre</th>
			<th>Dni</th>
			<th>Contador de bloqueo</th>
			<th>Bloqueado</th>
			<th>Rol</th>
		</tr>
		<c:forEach items="${usuarios}" var="usuario">
			<tr>
				<td>${usuario.usuario}</td>
				<td>${usuario.contrasenya}</td>
				<td>${usuario.correo}</td>
				<td>${usuario.nombre}</td>
				<td>${usuario.dni}</td>
				<td>${usuario.contadorBloqueo}</td>
				<td>${usuario.bloqueado}</td>
				<td>${usuario.rol}</td>
				<td><a type="button" class="btn btn-default" href="update/${usuario.usuario}.html">Edita</a>
				<td><a type="button" class="btn btn-default" href="delete/${usuario.usuario}.html">Elimina</a>		
			</tr>
		</c:forEach>
	</table>
	<a type="button" class="btn btn-default" href="add.html">Agregar usuario</a>
</body>
</html>
</jsp:body>
</t:paginabasica>