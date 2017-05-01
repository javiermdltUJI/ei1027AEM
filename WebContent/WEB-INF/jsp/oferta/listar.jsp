<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<title>Gestionar Ofertas</title>
</head>
<body>
	<h1>Lista de Ofertas</h1>
	<table class="table">
		<tr>
			<th>id_oferta</th>
			<th>Fecha inicio</th>
			<th>Fecha fin</th>
			<th>Descripción</th>
			<th>Usuario</th>
			<th>id_habilidad</th>
		</tr>
		<c:forEach items="${ofertas}" var="oferta">
			<tr>
				<td>${oferta.idOferta}</td>
				<td>${oferta.fechaIniString}</td>
				<td>${oferta.fechaFinString}</td>
				<td>${oferta.descripcion}</td>
				<td>${oferta.usuario}</td>
				<td>${oferta.idHabilidad}</td>
				<c:if test='${accesible == true}'>
					<td><a type="button" class="btn btn-default" href="../update/${oferta.usuario}/${oferta.idOferta}.html">Edita</a>
					<td><a type="button" class="btn btn-default" href="../delete/${oferta.usuario}/${oferta.idOferta}.html">Elimina</a>		
				</c:if>
				<c:if test='${usuario.rol=="ADMIN"}'>
					<td><a type="button" class="btn btn-default" href="../update/${oferta.usuario}/${oferta.idOferta}.html">Edita</a>
					<td><a type="button" class="btn btn-default" href="../delete/${oferta.usuario}/${oferta.idOferta}.html">Elimina</a>
					<td><a type="button" class="btn btn-default" href="../colaboracion/add.html">Crear colaboracion</a></td>
				</c:if>
				<c:if test='${accesible == false}'>
					<td><a type="button" class="btn btn-default" href="../colaboracion/add.html">Crear colaboracion</a></td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
	<a type="button" class="btn btn-default" href="add.html">Agregar oferta</a>
</body>
</html>
</jsp:body>
</t:paginabasica>