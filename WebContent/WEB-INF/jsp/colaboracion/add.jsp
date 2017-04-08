<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<meta charset=UTF-8>
<title>Crear una nueva colaboración</title>
</head>
<body>
	<h2>Nueva colaboración</h2>
	<form:form method="post" modelAttribute="colaboracion">
		   <div class="form-group">
				<form:label path="fechaIni">Fecha Inicio</form:label>
	            <form:input class="form-control" path="fechaIni" id="fechaIni" placeholder="Fecha Inicio" />
			</div>
			<div class="form-group">
				<form:label path="fechaFin">Fecha Fin</form:label>
	            <form:input class="form-control" path="fechaFin" id="fechaFin" placeholder="Fecha Fin" />
			</div>
			<div class="form-group">
				<form:label path="horasTotales">Horas totales</form:label>
				<form:input class="form-control" path="horasTotales" id="horasTotales" placeholder="Horas Totales"/>
			</div>
			<div class="form-group">
				<form:label path="valoracion">Valoracion</form:label>
				<form:input  class="form-control" path="valoracion" id="valoracion" placeholder="Valoracion"/>
			</div>
			<div class="form-group">
				<form:label path="idOferta">id_oferta</form:label>
				<form:input  class="form-control" path="idOferta" id="idOferta" placeholder="1"/>
			</div>
			<div class="form-group">
				<form:label path="idPeticion">id_peticion</form:label>
				<form:input class="form-control" path="idPeticion" id="idPeticion" placeholder="1"/>
			</div>
			<div class="form-group">
				<input class="btn btn-secundary" type="submit" value="Agregar colaboración" />
			</div>				
	</form:form>
</body>
</html>
</jsp:body>
</t:paginabasica>