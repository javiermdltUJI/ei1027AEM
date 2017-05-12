<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<meta charset=UTF-8>
<title>Modificar datos de una petici�n</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>

</head>
<body>
<script>
  $(function() {
    $( "#fechaInicio" ).datepicker({ dateFormat: 'dd-mm-yy' });
    $( "#fechaFin" ).datepicker({ dateFormat: 'dd-mm-yy' });

  });

</script>
	<h2 class="titulo">Petici�n</h2>
		<form:form method="post" modelAttribute="peticion" >
			<div class="form-group">
				<form:input type="hidden" name="idPeticion" path="idPeticion"/>
											
			</div>
			<div class="form-group">
				<form:label path="fechaIni">Fecha Inicio</form:label>
				<form:input class="form-control" path="fechaIni" id="fechaInicio" required="required"/>
				<form:errors path="fechaIni" cssClass="error fa fa-exclamation-circle" />			
			</div>
			<div class="form-group">				
				<form:label path="fechaFin">Fecha Fin</form:label>
				<form:input class="form-control" path="fechaFin" id="fechaFin" required="required"/>
				<form:errors path="fechaFin" cssClass="error fa fa-exclamation-circle" "/>	
			</div>
			<div class="form-group">
				<form:label path="descripcion">Descripci�n</form:label>
				<form:input class="form-control" path="descripcion" id="descripcion" placeholder="Descripci�n" required="required"/>
				<form:errors path="descripcion" cssClass="error fa fa-exclamation-circle"/>	
			</div>
			<c:if test='${usuario.rol=="ADMIN"}'>
				<div class="form-group">
					<form:label path="usuario">Usuario</form:label>
					<form:input class="form-control" path="usuario" id="usuario" placeholder="Usuario" required="required"/>
					<form:errors path="usuario" cssClass="error fa fa-exclamation-circle"/>	
				</div>
			</c:if>
			<div class="form-group">
				<form:label path="idHabilidad">Habilidad</form:label>
				<select name="idHabilidad">
					<c:forEach items="${habilidades}" var="habilidad">
						<c:choose>
							<c:when test="${elegida==habilidad.idHabilidad}">
								<option value="${habilidad.idHabilidad}" selected> ${habilidad.descripcion}  Nivel: ${habilidad.nivel}</option>
							</c:when>
							<c:otherwise>
								<option value="${habilidad.idHabilidad}"> ${habilidad.descripcion}  Nivel: ${habilidad.nivel}</option>
							</c:otherwise>
						</c:choose>				
					</c:forEach>
				</select>
				
				<!-- <td><form:label path="idHabilidad">id_habilidad</form:label></td>
				<td><form:input path="idHabilidad" id="idHabilidad" placeholder="1"/></td>
				 -->
			</div>
			<div class="form-group">
				<input class="btn btn-primary"  type="submit" value="Modificar petici�n" />
			</div>				
	</form:form>
</body>
</html>
</jsp:body>
</t:paginabasica>