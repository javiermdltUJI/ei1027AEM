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
	<script type='text/javascript' src='${pageContext.request.contextPath}/js/moment.js'></script>
	<script type='text/javascript' src='${pageContext.request.contextPath}/js/moment-with-locales.js'></script>

<script>
  $(function() {
    $( "#fechaIni" ).datepicker({ dateFormat: 'dd-mm-yy' });
    $( "#fechaFin" ).datepicker({ dateFormat: 'dd-mm-yy' });

  });

</script>
</head>
<body>
	<h2 class="titulo">Nueva colaboración</h2>
		
	<script>
	function submitform() {
		
		  if(moment(document.getElementById('fechaIni').value, 'DD-MM-YYYY',true).isValid() && moment(document.getElementById('fechaFin').value, 'DD-MM-YYYY',true).isValid() ) {
		    ini = document.getElementById('fechaIni').value;
			
			fin = document.getElementById('fechaFin').value;

			setInterval(function(){  $('#addOfertaForm').submit(); },2000);
			document.getElementById('fechaFin').value = fin;
			document.getElementById('fechaIni').value = ini;
		  } else {
			  if(!moment(document.getElementById('fechaIni').value, 'DD-MM-YYYY',true).isValid()){
			  	$('#fechaIni').get(0).setCustomValidity('Introduce la fecha en formato dd-mm-yyyy');
			  }
			  if(!moment(document.getElementById('fechaFin').value, 'DD-MM-YYYY',true).isValid()){
				  	$('#fechaFin').get(0).setCustomValidity('Introduce la fecha en formato dd-mm-yyyy');
				  
			  }
/* 		    	document.getElementById('blockDay').setCustomValidity('');
*/		  }
		}
	
	
	</script>
	
	
	<p>Las fechas de la colaboración deben ajustarse a la petición, por lo que debe estar entre <strong>${peticion.fechaIniString}</strong> y <strong>${peticion.fechaFinString}</strong> y la fecha de inicio debe ser mayor que el día actual.</p>
	<form:form id="addOfertaForm" method="post" modelAttribute="colaboracion">
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
			<c:if test='${usuario.rol=="ADMIN"}'>
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
			</c:if>
			<c:if test='${feedbackFechas=="error"}'>
				<p style="color:red">Las fechas no se ajustan a los parámetros explicados anteriormente.</p>
			</c:if>
			<div class="form-group">
				<button class="btn btn-primary"  onclick="submitform()" value="Seleccionar peticion" >Seleccionar oferta</button>
				
			</div>				
	</form:form>
</body>
</html>
</jsp:body>
</t:paginabasica>