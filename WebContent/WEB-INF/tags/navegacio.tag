<%@ tag language="java" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<c:set var="usuario" scope="request" value='${session.getAttribute("usuarioLogin")}'/>


<nav class="navbar navbar-default">
	<div class="container">
		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li><a href="${pageContext.request.contextPath}">Inicio</a></li>
				<c:choose>
				<c:when test='${usuario.rol=="ADMIN"}'>
					<li><a href="${pageContext.request.contextPath}/usuario/listar.html">Usuarios</a></li>
					<li><a href="${pageContext.request.contextPath}/habilidad/listar.html">Habilidades</a></li>
					<li><a href="${pageContext.request.contextPath}/oferta/listar.html">Ofertas</a></li>
					<li><a href="${pageContext.request.contextPath}/peticion/listar.html">Peticiones</a></li>
					<li><a href="${pageContext.request.contextPath}/colaboracion/listar.html">Colaboraciones</a></li>
				</c:when>
				<c:when test='${usuario.rol=="ESTUDIANTE"}'>
					<li><a href="${pageContext.request.contextPath}/habilidad/listarActivas.html">Habilidades</a></li>
					
					<li class="dropdown">
					
          				<a id="DropDownOfertas" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Ofertas <span class="caret"></span></a>
          				<ul class="dropdown-menu" aria-labelledby="DropDownOfertas">
			            	<li><a href="${pageContext.request.contextPath}/oferta/listarMisOfertas.html">Mis Ofertas</a></li>
							<li><a href="${pageContext.request.contextPath}/oferta/listarOfertas.html">Ver Ofertas</a></li>
							
						</ul>
			        </li>
					<li class="dropdown">
          				<a id="DropDownPeticiones" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Peticiones <span class="caret"></span></a>
          				<ul class="dropdown-menu" aria-labelledby="DropDownPeticiones">
							<li><a href="${pageContext.request.contextPath}/peticion/listarMisPeticiones.html">Mis Peticiones</a></li>
							<li><a href="${pageContext.request.contextPath}/peticion/listarPeticiones.html">Ver Peticiones</a></li>
						</ul>
					<li><a href="${pageContext.request.contextPath}/colaboracion/listarMisColaboraciones.html">Mis Colaboraciones</a></li>
				</c:when>
					
				<c:when test='${usuario.rol==null}'>
					<li><a href="${pageContext.request.contextPath}/habilidad/listarActivas.html">Habilidades</a></li>
					<li><a href="${pageContext.request.contextPath}/oferta/listar.html">Ofertas</a></li>
					<li><a href="${pageContext.request.contextPath}/peticion/listar.html">Peticiones</a></li>
				</c:when>
				</c:choose>

			</ul>
<%-- 			<c:if test='${usuario == null}'> --%>
<!-- 			<ul class="nav navbar-nav" style="float:right"> -->
<%-- 				<li><a href="${pageContext.request.contextPath}/login.html">Inicio de sesión</a></li> --%>
<!-- 			</ul> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test='${usuario != null}'> --%>
<!-- 			<ul class="nav navbar-nav" style="float:right"> -->
<%-- 				<li><a style="color:blue">Bienvenido/a ${usuario.nombre}</a></li> --%>
<%-- 				<li><a href="${pageContext.request.contextPath}/logout.html">Cerrar sesión</a></li> --%>
<!-- 			</ul> -->
<%-- 			</c:if> --%>
			
			
		</div>
	</div>
</nav>