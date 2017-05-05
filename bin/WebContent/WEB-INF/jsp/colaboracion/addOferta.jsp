<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<meta charset=UTF-8>
<title>Crear una nueva colaboración</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>

<script>
  $(function() {
    $( "#fechaIni" ).datepicker({ dateFormat: 'dd-mm-yy' });
    $( "#fechaFin" ).datepicker({ dateFormat: 'dd-mm-yy' });

  });

</script>
</head>
<body>
	<h2>Nueva colaboración</h2>
	<form:form method="post" modelAttribute="colaboracion"  onsubmit="validate()">
		   <div class="form-group">
				<form:label path="fechaIni">Fecha Inicio</form:label>
				<form:input class="form-control" path="fechaIni" id="fechaIni"/>
			</div>
			<div class="form-group">
				<form:label path="fechaFin">Fecha Fin</form:label>
				<form:input class="form-control" path="fechaFin" id="fechaFin"/>
			</div>
			<c:if test='${usuario.rol=="ADMIN"}'>
				<div class="form-group">
					<form:label path="horasTotales">Horas totales</form:label>
					<form:input class="form-control" path="horasTotales" id="horasTotales" placeholder="Horas Totales"/>
				</div>
				<div class="form-group">
					<form:label path="valoracion">Valoracion</form:label>
					<form:input  class="form-control" path="valoracion" id="valoracion" placeholder="Valoracion"/>
				</div>
			</c:if>
			<div class="form-group">
				<input class="btn btn-secundary" type="submit" value="Seleccionar peticion" />
			</div>				
	</form:form>
</body>
</html>
</jsp:body>
</t:paginabasica>