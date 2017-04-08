<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<meta charset=UTF-8>
<title>Modificar datos de una petición</title>
</head>
<body>
	<h2>Petición</h2>
	<form:form method="post" modelAttribute="peticion">
			<div class="form-group">
				<form:label path="fechaIni">Fecha Inicio</form:label>
	            <form:input class="form-control" path="fechaIni" id="fechaIni" placeholder="Fecha Inicio dd-mm-yyyy" />
			</div>
			<div class="form-group">
				<form:label path="fechaFin">Fecha Fin</form:label>
	            <form:input class="form-control" path="fechaFin" id="fechaFin" placeholder="Fecha Fin dd-mm-yyyy" />
			</div>
			<div class="form-group">
				<form:label path="descripcion">Descripción</form:label>
				<form:input class="form-control" path="descripcion" id="descripcion" placeholder="Descripción"/>
			</div>
			<div class="form-group">
				<form:label path="usuario">Usuario</form:label>
				<form:input class="form-control" path="usuario" id="usuario" placeholder="Usuario"/>
			</div>
			<div class="form-group">
				<form:label path="idHabilidad">Habilidad</form:label>
				<select name="idHabilidad">
					<c:forEach items="${habilidades}" var="habilidad">
						<option value="${habilidad.idHabilidad}"> ${habilidad.descripcion}  Nivel: ${habilidad.nivel}</option>		
					</c:forEach>
				</select>
				
				<!-- <td><form:label path="idHabilidad">id_habilidad</form:label></td>
				<td><form:input path="idHabilidad" id="idHabilidad" placeholder="1"/></td>
				 -->
			</div>
			<div class="form-group">
				<input class="btn btn-secundary"  type="submit" value="Agregar petición" />
			</div>				
	</form:form>
</body>
</html>
</jsp:body>
</t:paginabasica>