<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="usuario" scope="request" value='${session.getAttribute("usuarioLogin")}'/>


<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<title>Gestionar Peticiones</title>
</head>
<body>
	<h2 class="titulo">Lista de Peticiones</h2>
	<p> Seleccionar una colaboración con fechas entre: 
	<strong>${colaboracion.fechaIniString}</strong> y 
	<strong>${colaboracion.fechaFinString}</strong>, si no existe niguna petición puedes crearla.
	</p>
	<c:if test='${fn:length(collection)==0}'>
		<p><strong><i>No existen peticiones que se ajusten a la colaboración que se quiere crear. Para generar automaticamente una petición conforme a la colaboración selecciona 'Agregar petición'</i></strong> </p>
	</c:if>
	<c:if test='${fn:length(collection)!=0}'>
		<table class="table">
				<thead class="cabecera">
		
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
			<c:if test='${usuario.rol!="ADMIN"}'>
				<th></th>
			</c:if>
			</tr>
			</thead>
			
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
						<td><a type="button" class="btn btn-primary" href="../colaboracion/creada/${peticion.idPeticion}.html"><i class="fa fa-check" aria-hidden="true"></i>
						 Seleccionar</a></td>
					</c:if>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<c:if test='${accesible == true}'>
		<a type="button" class="btn btn-primary" href="../addConHabilidad.html">Agregar petición</a>
	</c:if>
	<c:if test='${accesible == false}'>
		<a type="button" class="btn btn-primary" href="addConHabilidad.html">Agregar petición</a>
	</c:if>
</body>
</html>
</jsp:body>
</t:paginabasica>