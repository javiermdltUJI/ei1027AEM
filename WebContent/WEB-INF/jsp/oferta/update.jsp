<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<meta charset=UTF-8>
<title>Modificar datos de una oferta</title>
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
	<h2>Oferta</h2>
	<form:form method="post" modelAttribute="oferta">
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
	
				<form:label path="descripcion">Descripción</form:label>
				<form:input class="form-control" path="descripcion" id="descripcion" placeholder="Descripción"/>
			</div>
			<div class="form-group">
	
				<form:label path="usuario">Usuario</form:label>
				<form:input  class="form-control" path="usuario" id="usuario" placeholder="Usuario"/>
			</div>
			<div class="form-group">
				<form:label path="idHabilidad">Habilidad</form:label>
					<select name="idHabilidad">
					<c:forEach items="${habilidades}" var="habilidad">
						<option value="${habilidad.idHabilidad}"> ${habilidad.descripcion}  Nivel: ${habilidad.nivel}</option>		
					</c:forEach>
				</select>
				
				<!-- <td><form:label path="idHabilidad">id_habilidad</form:label></td>
				<td><form:input path="idHabilidad" id="idHabilidad" placeholder="1"/></td> -->
			</div>
			<div class="form-group">

				<input  class="btn btn-secundary" type="submit" value="Agregar oferta" />
			</div>				
		
	</form:form>
</body>
</html>
</jsp:body>
</t:paginabasica>