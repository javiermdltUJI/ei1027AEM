<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<meta charset=UTF-8>
<title>Crear un nuevo usuario</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>

<script>
  $(function() {
    $( "#fechaFin" ).datepicker({ dateFormat: 'dd-mm-yy' });

  });

</script>

</head>
<body>
	<h2 class="titulo">Nuevo usuario</h2>
	<form:form method="post" modelAttribute="usuario">
			<div class="form-group">
				<form:label path="usuario">Usuario</form:label>
				<form:input class="form-control" path="usuario" id="usuario" placeholder="Usuario" required="required"/>
				<form:errors path="usuario" cssClass="error fa fa-exclamation-circle"></form:errors>		
			</div>
			<div class="form-group">
				<form:label path="contrasenya">Contrasenya</form:label>
				<form:input class="form-control" type = "password" path="contrasenya" id="contrasenya" placeholder="Contrasenya" required="required"/>
				<form:errors path="contrasenya" cssClass="error fa fa-exclamation-circle"></form:errors>		
			</div>
			<div class="form-group">
				<form:label path="correo">Correo</form:label>
				<form:input class="form-control" path="correo" id="correo" placeholder="Correo" required="required"/>
				<form:errors path="correo" cssClass="error fa fa-exclamation-circle"/>
			</div>
			<div class="form-group">
				<form:label path="nombre">Nombre</form:label>
				<form:input class="form-control" path="nombre" id="nombre" placeholder="Nombre" required="required"/>
				<form:errors path="nombre" cssClass="error fa fa-exclamation-circle"/>
			</div>
			<div class="form-group">
				<form:label path="dni">DNI</form:label>
				<form:input class="form-control" path="dni" id="dni" placeholder="DNI" required="required"/>
				<form:errors path="dni" cssClass="error fa fa-exclamation-circle"/>
			</div>
			<c:if test='${usuario.rol=="ADMIN"}'>
				<div class="form-group">
					<form:label path="eliminado">Eliminado</form:label>
					<form:input class="form-control" type="number" path="eliminado" id="contadorBloqueo" placeholder="0" required="required"/>
					<form:errors path="eliminado" cssClass="error fa fa-exclamation-circle"/>
				</div>
				<div class="form-group">
					<form:label path="bloqueado">Bloqueado</form:label>
					<form:input class="form-control" type="number" path="bloqueado" id="bloqueado" placeholder="0" required="required"/>
					<form:errors path="bloqueado" cssClass="error fa fa-exclamation-circle"/>
				</div>
				<div class="form-group">
					<form:label path="fechaFin">Fecha de fin de bloqueo</form:label>
					<form:input class="form-control" path="fechaFin" id="fechaFin"/>
					<form:errors path="fechaFin" cssClass="error fa fa-exclamation-circle"/>	
				</div>
				<div class="form-group">
					<form:label path="rol">Rol</form:label>
					    	<form:select path="rol" class="form-control" id="tipoRol">
									<form:option value="ESTUDIANTE"> ---- </form:option>
									<form:option value="ESTUDIANTE"> Estudiante </form:option>
									<form:option value="ADMIN">Admin</form:option>
							</form:select>
				</div>
			</c:if>
			<div class="form-group">
				<input class="btn btn-primary" type="submit" value="Añadir usuario" />
				
				
			</div>
	</form:form>
</body>
</html>
</jsp:body>
</t:paginabasica>