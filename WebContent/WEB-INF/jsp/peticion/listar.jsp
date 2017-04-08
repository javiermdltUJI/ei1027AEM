<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<title>Gestionar Peticiones</title>
</head>
<body>
	<h1>Lista de Peticiones</h1>
	<table class="table">
		<tr>
			<th>id_peticion</th>
			<th>Fecha inicio</th>
			<th>Fecha fin</th>
			<th>Descripci�n</th>
			<th>Usuario</th>
			<th>id_habilidad</th>
		</tr>
		<c:forEach items="${peticiones}" var="peticion">
			<tr>
				<td>${peticion.idPeticion}</td>
				<td>${peticion.fechaIni}</td>
				<td>${peticion.fechaFin}</td>
				<td>${peticion.descripcion}</td>
				<td>${peticion.usuario}</td>
				<td>${peticion.idHabilidad}</td>
				<td><a type="button" class="btn btn-default" href="update/${peticion.idPeticion}.html">Edita</a>
				<td><a type="button" class="btn btn-default" href="delete/${peticion.idPeticion}.html">Elimina</a>		
			</tr>
		</c:forEach>
	</table>
	<a type="button" class="btn btn-default" href="add.html">Agregar petici�n</a>
</body>
</html>
</jsp:body>
</t:paginabasica>