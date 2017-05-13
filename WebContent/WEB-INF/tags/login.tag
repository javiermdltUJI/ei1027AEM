<%@ tag language="java" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<c:set var="usuario" scope="request" value='${session.getAttribute("usuarioLogin")}'/>

<div class="login" style="float:right; margin-top:0.5%">
		<c:if test='${usuario == null}'>
			<div class="normal">
				<ul class="nav navbar-nav" style="float:right; top:0%">
					<li><a class="btn btn-loginSkill btn-responsive" style="color:#fff;" href="${pageContext.request.contextPath}/login.html">Inicio de sesión</a></li>
					<li><a class="btn btn-loginSkill btn-responsive" style="color:#fff;" href="${pageContext.request.contextPath}/usuario/add.html">Registrar usuario</a>
				</ul>
			</div>
		</c:if>
		<c:if test='${usuario != null}'>
			<div class="normal">
				<ul class="nav navbar-nav" style="float:right; top:0%">
					<li><a class="btn btn-loginSkill btn-responsive" style="color:#fff;">Bienvenido/a ${usuario.usuario}</a></li>
					<li><a class="btn btn-loginSkill btn-responsive" style="color:#fff;" href="${pageContext.request.contextPath}/logout.html">Cerrar sesión</a></li>
				</ul>
			</div>
		</c:if>
		

	<c:if test='${usuario == null}'>
		
		<div class="buttonslogin dropdown" style="margin-left:-180%">
			  	<button type="button" class="btn btn-loginSkill dropdown-toggle" id="menu" data-toggle="dropdown">
			  		<span class="caret"></span>
			  	</button>
				<ul class="dropdown-menu" role="menu">
				    <li><a class="btn btn-loginSkill2 btn-responsive" href="${pageContext.request.contextPath}/login.html">Inicio de sesión</a></li>
					<li><a class="btn btn-loginSkill2 btn-responsive" href="${pageContext.request.contextPath}/usuario/add.html">Registrar usuario</a>
				</ul>
		</div>
			
	</c:if>
	<c:if test='${usuario != null}'>
			<div class="buttonslogin dropdown" style="margin-left:-180%">
				<button type="button" class="btn btn-loginSkill dropdown-toggle" data-toggle="dropdown">
					<span class="caret"></span>
				</button>
				<ul class="dropdown-menu" role="menu">
					<li><a class="btn btn-loginSkill2 btn-responsive" >Bienvenido/a ${usuario.usuario}</a></li>
					<li><a class="btn btn-loginSkill2 btn-responsive" href="${pageContext.request.contextPath}/logout.html">Cerrar sesión</a></li>
				</ul>
			</div>
	</c:if>
</div>

		