<%@ tag language="java" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<c:set var="usuario" scope="request" value='${session.getAttribute("usuarioLogin")}'/>

<div style="float:right; margin-top:0.5%">
		<c:if test='${usuario == null}'>
			<ul class="nav navbar-nav" style="float:right; top:0%">
				<li><a class="btn btn-loginSkill" style="color:#fff;" href="${pageContext.request.contextPath}/login.html">Inicio de sesión</a></li>
				<li><a class="btn btn-loginSkill" style="color:#fff;" href="${pageContext.request.contextPath}/usuario/add.html">Registrar usuario</a>
			</ul>
		</c:if>
		<c:if test='${usuario != null}'>
			<ul class="nav navbar-nav" style="float:right; top:0%">
				<li><a class="btn btn-loginSkill" style="color:#fff;">Bienvenido/a ${usuario.usuario}</a></li>
				<li><a class="btn btn-loginSkill" style="color:#fff;" href="${pageContext.request.contextPath}/logout.html">Cerrar sesión</a></li>
			</ul>
		</c:if>
</div>