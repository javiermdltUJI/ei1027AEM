<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>


<h1>Relación de colaboraciones de peticiones y ofertas</h1>


<c:if test='${sessionScope.horas==0}'>
<p>Has realizado el mismo numero de horas para peticiones que para colaboraciones</p>
</c:if>
<c:if test='${sessionScope.horas<0}'>
<p>Has realizado el más horas para peticiones que para colaboraciones</p>
</c:if>
<c:if test='${sessionScope.horas>0}'>
<p>Has realizado el más horas para colaboraciones que para peticiones</p>
</c:if>
<p class="text-justify"> Total: ${sessionScope.horas}</p>


</jsp:body>
</t:paginabasica>