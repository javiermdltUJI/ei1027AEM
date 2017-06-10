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
		<c:if test='${usuario.rol !="ADMIN" &&  usuario.rol != null}'>
			<div class="normal">
				<ul class="nav navbar-nav" style="float:right; top:0%">
					<li class="dropdown">
						<a class="btn btn-loginSkill btn-responsive" style="color: #fff" id="DropDownUsuarios" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Bienvenido/a ${usuario.usuario} <span class="caret"></span></a>
						<ul class="dropdown-menu" aria-labelledby="DropDownUsuarios">
							<li><a style="color: black" href="${pageContext.request.contextPath}/usuario/update/${usuario.usuario}.html">Editar tus datos</a></li>
							<li><a style="color: black" href="${pageContext.request.contextPath}/colaboracion/consultaHoras.html">Consultar mis horas</a></li>
						</ul>
					</li>
					<li><a class="btn btn-loginSkill btn-responsive" style="color:#fff;" href="${pageContext.request.contextPath}/logout.html">Cerrar sesión</a></li>
				</ul>
			</div>
		</c:if>
<%-- 					<li><a class="btn btn-loginSkill btn-responsive" style="color:#fff;">Bienvenido/a ${usuario.usuario}</a></li>		
 --%>				
 		<c:if test='${usuario.rol =="ADMIN"}'>
			<div class="normal">
				<ul class="nav navbar-nav" style="float:right; top:0%">
					<li><a class="btn btn-loginSkill btn-responsive" style="color:#fff;">Bienvenido/a ${usuario.usuario}</a></li>
					<li><a class="btn btn-loginSkill btn-responsive" style="color:#fff;" href="${pageContext.request.contextPath}/estadisticas/resumen.html">Estadísticas</a></li>
					<li><a class="btn btn-loginSkill btn-responsive" style="color:#fff;" href="${pageContext.request.contextPath}/logout.html">Cerrar sesión</a></li>
				</ul>
			</div>
		</c:if>		
</div>

		