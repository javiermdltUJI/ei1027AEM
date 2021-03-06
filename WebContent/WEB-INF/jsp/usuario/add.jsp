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
</head>
<body>
	<h2>Nuevo usuario</h2>
	<form:form method="post" modelAttribute="usuario">
			<div class="form-group">
				<form:label path="usuario">Usuario</form:label>
				<form:input class="form-control" path="usuario" id="usuario" placeholder="Usuario"/>
			</div>
			<div class="form-group">
				<form:label path="contrasenya">Contrasenya</form:label>
				<form:input class="form-control" path="contrasenya" id="contrasenya" placeholder="Contrasenya"/>
			</div>
			<div class="form-group">
				<form:label path="correo">Correo</form:label>
				<form:input class="form-control" path="correo" id="correo" placeholder="Correo"/>
			</div>
			<div class="form-group">
				<form:label path="nombre">Nombre</form:label>
				<form:input class="form-control" path="nombre" id="nombre" placeholder="Nombre"/>
			</div>
			<div class="form-group">
				<form:label path="dni">DNI</form:label>
				<form:input class="form-control" path="dni" id="dni" placeholder="DNI"/>
			</div>
			<div class="form-group">
				<form:label path="contadorBloqueo">Contador de bloqueo</form:label>
				<form:input class="form-control" path="contadorBloqueo" id="contadorBloqueo" placeholder="0"/>
			</div>
			<div class="form-group">
				<form:label path="bloqueado">Bloqueado</form:label>
				<form:input class="form-control" path="bloqueado" id="bloqueado" placeholder="0"/>
			</div>
			<div class="form-group">
				<form:label path="rol">Rol</form:label>
				    	<form:select path="rol" class="form-control" id="tipoRol">
								<form:option value="ESTUDIANTE"> ---- </form:option>
								<form:option value="ESTUDIANTE"> Estudiante </form:option>
								<form:option value="ADMIN">Admin</form:option>
						</form:select>
			</div>
			<div class="form-group">
				<input class="btn btn-secundary" type="submit" value="Agregar usuario" />
			</div>
	</form:form>
</body>
</html>
</jsp:body>
</t:paginabasica>