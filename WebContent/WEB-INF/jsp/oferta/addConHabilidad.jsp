<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<meta charset=UTF-8>
<title>Crear una nueva oferta</title>
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

	<h2 class="titulo">Nueva oferta</h2>
	<p>Las fechas de la oferta deben ajustarse a la colaboración, por lo que la fecha de inicio debe ser menor o igual que <strong>${colaboracion.fechaIniString}</strong> y  la fecha de fin mayor o igual que <strong>${colaboracion.fechaFinString}</strong>.</p>
	
	<form:form method="post" modelAttribute="oferta"  onsubmit="validate()">
			<div class="form-group">
				<form:label path="fechaIni">Fecha Inicio</form:label>
				<form:input class="form-control" path="fechaIni" id="fechaIni"/>
			</div>
			<div class="form-group">
				<form:label path="fechaFin">Fecha Fin</form:label>
				<form:input class="form-control" path="fechaFin" id="fechaFin"/>
			</div>
			<div class="form-group">
				<form:label path="descripcion">Más info.</form:label>
				<form:input class="form-control" path="descripcion" id="descripcion" placeholder="Descripción"/>
			</div>
			<c:if test='${usuario.rol=="ADMIN"}'>
				<div class="form-group">
					<form:label path="usuario">Usuario</form:label>
					<form:input class="form-control" path="usuario" id="usuario" placeholder="Usuario"/>
				</div>
			</c:if>
			<c:if test='${feedbackFechas=="error"}'>
				<p style="color:red">Las fechas no se ajustan a los parámetros explicados anteriormente.</p>
			</c:if>
			<div class="form-group">
				<input class="btn btn-primary"  type="submit" value="Añadir petición" />
			</div>				
	</form:form>
</body>
</html>
</jsp:body>
</t:paginabasica>