<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<meta charset=UTF-8>
<title>Login</title>
</head>
<body>
	<h2 class="titulo">Login usuario</h2>
	<form:form method="post" modelAttribute="usuarioLogin" action="${pageContext.request.contextPath}/login.html">
			<div class="form-group">
				<form:label path="usuario">Usuario</form:label>
				<form:input class="form-control" path="usuario" id="usuario" placeholder="Usuario"/>
			    <form:errors path="usuario" cssClass="error" />
			
			</div>
			
			<div class="form-group">
				<form:label path="contrasenya">Contrasenya</form:label>
				<form:password class="form-control" path="contrasenya" id="contrasenya" placeholder="Contrasenya"/>
			    <form:errors path="contrasenya" cssClass="error" />
			
			</div>
			
			 <button type="submit" name="go" class="btn btn-lg btn-primary btn-block">Acceder</button>
	          <div style="    margin-top: 2%;">
	            Si no tienes cuenta puedes registrarte desde aquí: <a href="${pageContext.request.contextPath}/usuario/add.html">Crear cuenta</a>
	          </div>
	         
	</form:form>
</body>
</html>
</jsp:body>
</t:paginabasica>