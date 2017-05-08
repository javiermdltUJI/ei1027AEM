<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<meta charset=UTF-8>
<title>Crear una nueva petición</title>
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

	<h2>Nueva petición</h2>
	<form:form method="post" modelAttribute="peticion"  onsubmit="validate()">
			<div class="form-group">
				<form:label path="fechaIni">Fecha Inicio</form:label>
				<form:input class="form-control" path="fechaIni" id="fechaIni"/>
				<form:errors path="fechaIni" cssClash="error"/>	
			</div>
			<div class="form-group">
				<form:label path="fechaFin">Fecha Fin</form:label>
				<form:input class="form-control" path="fechaFin" id="fechaFin"/>
				<form:errors path="fechaFin" cssClash="error"/>	
			</div>
			<div class="form-group">
				<form:label path="descripcion">Descripción</form:label>
				<form:input class="form-control" path="descripcion" id="descripcion" placeholder="Descripción"/>
				<form:errors path="descripcion" cssClash="error"/>	
			</div>
			<c:if test='${usuario.rol=="ADMIN"}'>
				<div class="form-group">
					<form:label path="usuario">Usuario</form:label>
					<form:input class="form-control" path="usuario" id="usuario" placeholder="Usuario"/>
					<form:errors path="usuario" cssClash="error"/>	
				</div>
			</c:if>
			<div class="form-group">
				<form:label path="idHabilidad">Habilidad</form:label>
				<select name="idHabilidad">
					<c:forEach items="${habilidades}" var="habilidad">
						<option value="${habilidad.idHabilidad}"> ${habilidad.descripcion}  Nivel: ${habilidad.nivel}</option>		
					<form:errors path="idHabilidad" cssClash="error"/>	
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