<%@ tag language="java" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<c:set var="usuario" scope="request" value='${session.getAttribute("usuarioLogin")}'/>


<nav >
	<div class="container">
		<div class="navbar-collapse">
			<ul class="nav nav-tabs nav-justified">
				<li><a style="color: #fff" href="${pageContext.request.contextPath}">Inicio</a></li>
				<c:choose>
				<c:when test='${usuario.rol=="ADMIN"}'>
					<li class="dropdown">
						<a style="color: #fff" id="DropDownUsuarios" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Usuarios <span class="caret"></span></a>
						<ul class="dropdown-menu" aria-labelledby="DropDownUsuarios">
							<li><a style="color: black" href="${pageContext.request.contextPath}/usuario/add.html">Crear Usuario</a></li>
							<li><a style="color: black" href="${pageContext.request.contextPath}/usuario/listar.html">Ver Usuarios</a></li>
						</ul>
					</li>
					<li class="dropdown">
						<a style="color: #fff" id="DropDownHabilidades" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Habilidades <span class="caret"></span></a>
						<ul class="dropdown-menu" aria-labelledby="DropDownHabilidades">
							<li><a style="color: black" href="${pageContext.request.contextPath}/habilidad/add.html">Crear Habilidad</a></li>
							<li><a style="color: black" href="${pageContext.request.contextPath}/habilidad/listar.html">Ver Habilidades</a></li>
						</ul>
					</li>
					<li class="dropdown">
						<a style="color: #fff" id="DropDownOfertas" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Ofertas <span class="caret"></span></a>
						<ul class="dropdown-menu" aria-labelledby="DropDownOfetas">
							<li><a style="color: black" href="${pageContext.request.contextPath}/oferta/add.html">Crear Oferta</a></li>
							<li><a style="color: black" href="${pageContext.request.contextPath}/oferta/listar.html">Ver Ofertas</a></li>
						</ul>
					</li>
					<li class="dropdown">
						<a style="color: #fff" id="DropDownPeticiones" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Peticiones <span class="caret"></span></a>
						<ul class="dropdown-menu" aria-labelledby="DropDownPeticiones">
							<li><a style="color: black" href="${pageContext.request.contextPath}/peticion/add.html">Crear Petición</a></li>
							<li><a style="color: black"  href="${pageContext.request.contextPath}/peticion/listar.html">Ver Peticiones</a></li>
						</ul>
					</li>
					<li class="dropdown">
						<a style="color: #fff" id="DropDownColaboraciones" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Colaboraciones <span class="caret"></span></a>
						<ul class="dropdown-menu" aria-labelledby="DropDownColaboraciones">
							<li><a style="color: black" href="${pageContext.request.contextPath}/colaboracion/add.html">Crear Colaboración</a></li>
							<li><a style="color: black" href="${pageContext.request.contextPath}/colaboracion/listar.html">Ver Colaboracion</a></li>
						</ul>
					</li>
				</c:when>
				<c:when test='${usuario.rol=="ESTUDIANTE"}'>
					<li><a style="color: #fff" href="${pageContext.request.contextPath}/habilidad/listarActivas.html">Habilidades</a></li>
					
					<li class="dropdown">
          				<a style="color: #fff" id="DropDownOfertas" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Ofertas <span class="caret"></span></a>
          				<ul class="dropdown-menu" aria-labelledby="DropDownOfertas">
 			            	<li><a style="color: black" href="${pageContext.request.contextPath}/oferta/add.html">Crear Oferta</a></li>
			            	<li><a style="color: black" href="${pageContext.request.contextPath}/oferta/listarMisOfertas/${usuario.usuario}.html">Mis Ofertas</a></li>
							<li><a style="color: black" href="${pageContext.request.contextPath}/oferta/listarOfertas.html">Ver Ofertas</a></li>
							
						</ul>
			        </li>
					<li class="dropdown">
          				<a style="color: #fff" id="DropDownPeticiones" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Peticiones <span class="caret"></span></a>
          				<ul style="color: black" class="dropdown-menu" aria-labelledby="DropDownPeticiones">
          					<li><a style="color: black" href="${pageContext.request.contextPath}/peticion/add.html">Crear Petición</a></li>
							<li><a style="color: black" href="${pageContext.request.contextPath}/peticion/listarMisPeticiones/${usuario.usuario}.html">Mis Peticiones</a></li>
							<li><a style="color: black" href="${pageContext.request.contextPath}/peticion/listarPeticiones.html">Ver Peticiones</a></li>
						</ul>
					<li><a style="color: #fff" href="${pageContext.request.contextPath}/miColaboracion/listar/${usuario.usuario}.html">Mis Colaboraciones</a></li>
				</c:when>
					
				<c:when test='${usuario.rol==null}'>
					<li><a style="color: #fff" href="${pageContext.request.contextPath}/habilidad/listarActivas.html">Habilidades</a></li>
					<li><a style="color: #fff"href="${pageContext.request.contextPath}/oferta/listar.html">Ofertas</a></li>
					<li><a style="color: #fff"href="${pageContext.request.contextPath}/peticion/listar.html">Peticiones</a></li>
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