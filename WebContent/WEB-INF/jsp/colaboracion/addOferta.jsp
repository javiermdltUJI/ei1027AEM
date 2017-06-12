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
	<h2 class="titulo">Nueva colaboración</h2>
	
	
	<p>Las fechas de la colaboración deben ajustarse a la oferta, por lo que debe estar entre <strong>${oferta.fechaIniString}</strong> y <strong>${oferta.fechaFinString}</strong> y la fecha de inicio debe ser mayor que el día actual.</p>
	<form:form method="post" modelAttribute="colaboracion"  onsubmit="validate()">
		   <div class="form-group">
				<form:label path="fechaIni">Fecha Inicio</form:label>
				<form:input class="form-control" path="fechaIni" id="fechaIni" required="required"/>
				<form:errors path="fechaIni" cssClass="error fa fa-exclamation-circle"/>	
			</div>
			<div class="form-group">
				<form:label path="fechaFin">Fecha Fin</form:label>
				<form:input class="form-control" path="fechaFin" id="fechaFin" required="required"/>
				<form:errors path="fechaFin" cssClass="error fa fa-exclamation-circle"/>	
			</div>
			<c:if test='${usuario.rol=="ADMIN"}'>
				<div class="form-group">
					<form:label path="horasTotales">Horas totales</form:label>
					<form:input class="form-control" path="horasTotales" id="horasTotales" type="number" placeholder="Horas Totales" required="required"/>
					<form:errors path="horasTotales" cssClass="error fa fa-exclamation-circle"/>	
				</div>
				<div class="form-group">
					<form:label path="valoracion">Valoración</form:label>
					<form:input  class="form-control" path="valoracion" id="valoracion" type="number" placeholder="Valoracion" required="required"/>
					<form:errors path="valoracion" cssClass="error fa fa-exclamation-circle"/>	
				</div>
			</c:if>
			<c:if test='${feedbackFechas=="error"}'>
				<p style="color:red">Las fechas no se ajustan a los parámetros explicados anteriormente.</p>
			</c:if>
			<div class="form-group">
				<input class="btn btn-primary" type="submit" value="Seleccionar peticion" />
			</div>				
	</form:form>
</body>
</html>
</jsp:body>
</t:paginabasica>