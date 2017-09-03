<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<meta charset=UTF-8>
<title>Crear una nueva colaboración</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/css/notifIt.css'>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/js/notifIt.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/js/notifIt.min.js'></script>

<script>
  $(function() {
    $( "#fechaIni" ).datepicker({ dateFormat: 'dd-mm-yy' });
    $( "#fechaFin" ).datepicker({ dateFormat: 'dd-mm-yy' });

  });
  

</script>
	
	
	<script>
		$(document).ready(function(){
			$('#colaboracion').submit(function(e){
					 if(${error}){
						notif({
							'type': 'success',
							'msg': '¡Colaboracion creada!',
							'position': 'center',
						});
			}
				
			});		
	
	});
	</script>
</head>
<body>
	<h2 class="titulo">Nueva colaboración</h2>
	<form:form method="post" modelAttribute="colaboracion" >
				<div class="form-group">
				<form:label path="idHabilidad">Habilidad</form:label>
					<select name="idHabilidad" class="form-control">
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
			</div>
		   <div class="form-group">
				<form:label path="fechaIni">Fecha Inicio</form:label>
				<form:input class="form-control" path="fechaIni" id="fechaIni" placeholder="dd-mm-aaaa" required="required"/>
				<form:errors path="fechaIni" cssClass="error fa fa-exclamation-circle"/>	
			</div>
			<div class="form-group">
				<form:label path="fechaFin">Fecha Fin</form:label>
				<form:input class="form-control" path="fechaFin" id="fechaFin" placeholder="dd-mm-aaaa" required="required"/>
				<form:errors path="fechaFin" cssClass="error fa fa-exclamation-circle"/>	
			</div>
			<div class="form-group">
				<form:label path="ofertante">Usuario ofertante</form:label>
				<select name="ofertante" class="form-control">
					<c:forEach items="${usuarios}" var="u">
						<c:choose>
							<c:when test="${ofertanteElegido==u.usuario}">
								<option value="${u.usuario}" selected> ${u.usuario}</option>
							</c:when>
							<c:otherwise>
								<option value="${u.usuario}"> ${u.usuario}</option>
							</c:otherwise>	
						</c:choose>
					</c:forEach>
				</select>
				<form:errors path="ofertante" cssClass="error fa fa-exclamation-circle"/>
			</div>
			<div class="form-group">
				<form:label path="demandante">Usuario demandante</form:label>
				<select name="demandante" class="form-control">
					<c:forEach items="${usuarios}" var="u">
						<c:choose>
							<c:when test="${demandanteElegido==u.usuario}">
								<option value="${u.usuario}" selected> ${u.usuario}</option>
							</c:when>
							<c:otherwise>
								<option value="${u.usuario}"> ${u.usuario}</option>
							</c:otherwise>	
						</c:choose>
					</c:forEach>
				</select>
				<form:errors path="ofertante" cssClass="error fa fa-exclamation-circle"/>
			</div>
			<div class="form-group">
				<form:label path="horasTotales">Horas totales</form:label>
				<form:input class="form-control" path="horasTotales" id="horasTotales" type="number" placeholder="Horas Totales" required="required"/>
				<form:errors path="horasTotales" cssClass="error fa fa-exclamation-circle"/>	
			</div>
			<div class="form-group">						
				<form:label path="valoracion">Valoración</form:label>
				<form:select path="valoracion" class="form-control" id="tipoValoracion">
					<form:option value="0"> --- </form:option>
					<form:option value="1"> 1 </form:option>
					<form:option value="2"> 2 </form:option>
					<form:option value="3"> 3 </form:option>
					<form:option value="4"> 4 </form:option>
					<form:option value="5"> 5 </form:option>
				</form:select>	
			</div>
			
			<div class="form-group">
				<input class="btn btn-primary" type="submit" value="Añadir colaboración" />
			</div>				
	</form:form>

	
</body>
</html>
</jsp:body>
</t:paginabasica>