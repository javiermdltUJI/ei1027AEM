<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="usuario" scope="request" value='${session.getAttribute("usuarioLogin")}'/>


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
		<c:if test='${usuario.rol=="ADMIN"}'>
			<th>id_peticion</th>
		</c:if>
			<th>Fecha inicio</th>
			<th>Fecha fin</th>
			<th>Descripción</th>
			<th>Usuario</th>
		<c:if test='${usuario.rol=="ADMIN"}'>
			<th>id_habilidad</th>
		</c:if>
		</tr>
		<c:forEach items="${peticiones}" var="peticion">
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
				<c:if test='${accesible == true}'>
					<td><a type="button" class="btn btn-default" href="../update/${peticion.usuario}/${peticion.idPeticion}.html">Edita</a>
					<td><a type="button" class="btn btn-default" href="../delete/${peticion.usuario}/${peticion.idPeticion}.html">Elimina</a>		
				</c:if>
				<c:if test='${usuario.rol=="ADMIN"}'>
					<td><a type="button" class="btn btn-default" href="./update/${peticion.usuario}/${peticion.idPeticion}.html">Edita</a>
					<td><a type="button" class="btn btn-default" href="./delete/${peticion.usuario}/${peticion.idPeticion}.html">Elimina</a>		
					<td><a type="button" class="btn btn-default" href="../colaboracion/creada/${peticion.idPeticion}.html">Seleccionar</a></td>
				</c:if>
				<c:if test='${accesible == false}'>
					<td><a type="button" class="btn btn-default" href="../colaboracion/creada/${peticion.idPeticion}.html">Seleccionar</a></td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
	<c:if test='${accesible == true}'>
		<a type="button" class="btn btn-default" href="../addConHabilidad.html">Agregar petición</a>
	</c:if>
	<c:if test='${accesible == false}'>
		<a type="button" class="btn btn-default" href="addConHabilidad.html">Agregar petición</a>
	</c:if>
</body>
</html>
</jsp:body>
</t:paginabasica>