<%@ tag language="java" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<c:set var="usuario" scope="request" value='${session.getAttribute("usuarioLogin")}'/>

<div class="login2" >
		<c:if test='${usuario == null}'>
			<div class="normal">
				<ul class="nav navbar-nav" style="top:0%">
					<li><a class="btn-loginSkill btn-responsive" style="color:#fff;     border-color: rgba(245, 230, 197, 0);
					" href="${pageContext.request.contextPath}/login.html"><i class="fa fa-sign-in" aria-hidden="true"></i>
					 Inicio de sesión</a></li>
					<li><a class=" btn-loginSkill btn-responsive" style="color:#fff;     border-color: rgba(245, 230, 197, 0);
					" href="${pageContext.request.contextPath}/usuario/add.html">Registrar usuario</a>
				</ul>
			</div>
		</c:if>
		<c:if test='${usuario.rol !="ADMIN" &&  usuario.rol != null}'>
			<div class="normal">
				<ul class="nav navbar-nav" style="float:right; ">
					<li class="dropdown" style="margin-top: 0%">
						<a class=" btn-responsive" style="color: #fff;     border-color: rgba(245, 230, 197, 0);" id="DropDownUsuarios" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-user-circle" aria-hidden="true"></i>
						 Bienvenido/a ${usuario.usuario} <span class="caret"></span></a>
						<ul class="dropdown-menu" aria-labelledby="DropDownUsuarios">
							<li><a style="color: black" href="${pageContext.request.contextPath}/usuario/update/${usuario.usuario}.html"><i class="fa fa-pencil" aria-hidden="true"></i>
							 Editar tus datos</a></li>
							<li><a style="color: black" href="${pageContext.request.contextPath}/colaboracion/consultaHoras.html"><i class="fa fa-clock-o" aria-hidden="true"></i>
							 Consultar mis horas</a></li>
						</ul>
					</li>
					<li><a class=" btn-responsive" style="color:#fff;     border-color: rgba(245, 230, 197, 0);
					" href="${pageContext.request.contextPath}/logout.html"><i class="fa fa-sign-out" aria-hidden="true"></i>
					 Cerrar sesión</a></li>
				</ul>
			</div>
		</c:if>
<%-- 					<li><a class="btn btn-loginSkill btn-responsive" style="color:#fff;">Bienvenido/a ${usuario.usuario}</a></li>		
 --%>				
 		<c:if test='${usuario.rol =="ADMIN"}'>
			<div class="normal">
				<ul class="nav navbar-nav" style="">
					<li><a class="btn btn-loginSkill btn-responsive" style="color:#fff;     border-color: rgba(245, 230, 197, 0);
					"><i class="fa fa-user-circle" aria-hidden="true"></i>
					 Bienvenido/a ${usuario.usuario}</a></li>
					<li><a class="btn btn-loginSkill btn-responsive" style="color:#fff;     border-color: rgba(245, 230, 197, 0);
					" href="${pageContext.request.contextPath}/estadisticas/resumen.html"><i class="fa fa-bar-chart" aria-hidden="true"></i>
					Estadísticas</a></li>
					<li><a class="btn btn-loginSkill btn-responsive" style="color:#fff;     border-color: rgba(245, 230, 197, 0);
					" href="${pageContext.request.contextPath}/logout.html"><i class="fa fa-sign-out" aria-hidden="true"></i>
					 Cerrar sesión</a></li>
				</ul>
			</div>
		</c:if>		
</div>