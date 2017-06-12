Scripting elements ( %!, jsp:declaration, %=, jsp:expression, %, jsp:scriptlet ) are disallowed here.
<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<meta charset=UTF-8>
<title>Error</title>
</head>
<body>
	<img class="center-block" alt="" src="${pageContext.request.contextPath}/img/error.png" style="width:15%;">

	<h1 class="text-center">Error. Has excedido las horas de tus ofertas.</h1> 
	<p class="text-justify">Para poder continuar, has de crear una colaboración a partir de peticiones de otros usuarios de al menos ${sessionScope.horas}</p>
	
	<div style="text-align:center;"><a type="button" class="btn btn-default" href="${pageContext.request.contextPath}/${sessionScope.prevURL}">Volver</a></div>
	
</body>
</html>
</jsp:body>
</t:paginabasica>