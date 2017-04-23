<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %> 
<t:paginabasica title="EI1027">
<jsp:body>
<html> 
  <head>
<title>Skill Sharing</title>
  </head>
  <ul>
	<li><a href="${pageContext.request.contextPath}/usuario/listar.html">Gestión de Usuarios</a></li>
	<li><a href="${pageContext.request.contextPath}/habilidad/listar.html">Gestión de Habilidades</a></li>
	<li><a href="${pageContext.request.contextPath}/oferta/listar.html">Gestión de Ofertas</a></li>
	<li><a href="${pageContext.request.contextPath}/peticion/listar.html">Gestión de Peticiones</a></li>
	<li><a href="${pageContext.request.contextPath}/colaboracion/listar.html">Gestión de Colaboraciones</a></li>
</ul>
</html>
</jsp:body>
</t:paginabasica>