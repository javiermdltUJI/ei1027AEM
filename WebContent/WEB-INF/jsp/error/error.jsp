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
	<h1>Error. No se tiene permisos para realizar esta acción. </h1>
	
	<div style="text-align:center;"><a type="button" class="btn btn-default" href="${pageContext.request.contextPath}/${sessionScope.prevURL}">Volver</a></div>
	
</body>
</html>
</jsp:body>
</t:paginabasica>