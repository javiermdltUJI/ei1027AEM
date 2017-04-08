<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<meta charset=UTF-8>
<title>Crear una nueva colaboración</title>
<script>
function validar(obj, correct, fail) {
  patron = /^\d{2}\-\d{2}\-\d{4}$/
  if(patron.test(obj.value)){
	  document.querySelector(fail).setAttribute('style','display:none');
	  document.querySelector(correct).setAttribute('style','display:block');

  }else{
	  document.querySelector(fail).setAttribute('style','display:block');
	  document.querySelector(correct).setAttribute('style','display:none');
  }
}
</script>
</head>
<body>
	<h2>Nueva colaboración</h2>
	<form:form method="post" modelAttribute="colaboracion">
		   <div class="form-group">
				<form:label path="fechaIni">Fecha Inicio</form:label>
	            <form:input class="form-control" path="fechaIni" id="fechaIni" placeholder="Fecha Inicio dd-mm-yyyy" onchange="validar(this,'#fechaIniCorrect','#fechaIniError')"/>
				<div id="fechaIniError" style='display:none'><p style='color:red;'>Formato no válido</p></div>
				<div id="fechaIniCorrect" style='display:none'><p style='color:green;'>Formato válido</p></div>
				
			</div>
			<div class="form-group">
				<form:label path="fechaFin">Fecha Fin</form:label>
	            <form:input class="form-control" path="fechaFin" id="fechaFin" placeholder="Fecha Fin dd-mm-yyyy" onchange="validar(this,'#fechaFinCorrect','#fechaFinError')"/>
	            <div id="fechaFinError" style='display:none'><p style='color:red;'>Formato no válido</p></div>
				<div id="fechaFinCorrect" style='display:none'><p style='color:green;'>Formato válido</p></div>
				
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