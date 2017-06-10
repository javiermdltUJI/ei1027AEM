<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>


<h1>Relación de horas entre colaboraciones de peticiones y ofertas</h1>

<div style="margin-left:15%">
<c:if test='${sessionScope.horas==0}'>
<h3>Has realizado el mismo numero de horas para peticiones que para ofertas</h3>
</c:if>
<c:if test='${sessionScope.horas<0}'>
<h3>Has realizado más horas para peticiones que para ofertas</h3>
</c:if>
<c:if test='${sessionScope.horas>0}'>
<h3>Has realizado más horas para ofertas que para peticiones</h3>
</c:if>
<h3 class="text-justify"> Total: ${sessionScope.horas}</h3>

</div>
</jsp:body>
</t:paginabasica>