<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<meta charset=UTF-8>
<title>Crear una nueva petición</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/js/notifIt.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/js/notifIt.min.js'></script>

<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/css/notifIt.css'>
	
	
	<script>
		$(document).ready(function(){
			$('#usuar').submit(function(e){
				notif({
					'type': 'success',
					'msg': '¡Colaboracion creada!',
					'position': 'center',
				});
				
			});		
	
	});
	</script>
</head>
<body>

	<h2 class="titulo">Selecciona el usuario</h2>
	
	<form:form method="post" modelAttribute="usuario" id="usuar">
			<div class="form-group">
				<form:label path="usuario">Usuario</form:label>
					<select name="usuario" class="form-control">
						<c:forEach items="${usuarios}" var="u">
							<option value="${u.usuario}"> ${u.usuario}</option>		
						</c:forEach>
					</select>
				</div>
			<div class="form-group">
				<input class="seleccionar btn btn-primary"  type="submit" value="Seleccionar" />
			</div>				
	</form:form>
</body>
</html>
</jsp:body>
</t:paginabasica>