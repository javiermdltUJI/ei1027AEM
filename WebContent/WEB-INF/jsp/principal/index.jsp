<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %> 
<t:paginabasica title="EI1027">
<jsp:body>
<html> 
  <head>
<title>Skill Sharing</title>
  </head>
  <ul>
	<li><a href="${pageContext.request.contextPath}/usuario/listar.html">Gesti�n de Usuarios</a></li>
	<li><a href="${pageContext.request.contextPath}/habilidad/listar.html">Gesti�n de Habilidades</a></li>
	<li><a href="${pageContext.request.contextPath}/oferta/listar.html">Gesti�n de Ofertas</a></li>
	<li><a href="${pageContext.request.contextPath}/peticion/listar.html">Gesti�n de Peticiones</a></li>
	<li><a href="${pageContext.request.contextPath}/colaboracion/listar.html">Gesti�n de Colaboraciones</a></li>
</ul>
</html>
</jsp:body>
</t:paginabasica>