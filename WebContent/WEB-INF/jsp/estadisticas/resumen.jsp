<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<meta charset=UTF-8>
<title>Crear una nueva oferta</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>


</head>
<body>
	<h2 class="titulo">Resumen de las estadísticas del sistema</h2>
	
	<table class="table">
		<tr>
			<th><h3>Informe de usuarios</h3></th>
			<th></th>
		</tr>
		<tr>
			<td> Usuarios totales: </td>
			<td>${usuariosTotales}</td>
		</tr>
		<tr>
			<td> Usuarios bloqueados: </td>
			<td> ${usuariosBloqueados} </td>
		</tr>
		<tr>
			<td> Usuarios eliminados: </td>
			<td> ${usuariosEliminados} </td>
		</tr>		
	</table>
	
	<table class="table">
		<tr>
			<th><h3>Informe de habilidades</h3></th>
			<th></th>
		</tr>
		<tr>
			<td> Habilidades totales: </td>
			<td> ${habilidadesTotales} </td>
		</tr>
		<tr>
			<td> Habilidades canceladas: </td>
			<td> ${habilidadesCanceladas} </td>
		</tr>
		<tr>
			<td> Habilidad más ofertada: </td>
			<td> ${habilidadMasOfertada} </td>
		</tr>
		<tr>
			<td> Habilidad más demandada: </td>
			<td> ${habilidadMasDemandada} </td>
		</tr>
	</table>
	
	<table class="table">
		<tr>
			<th><h3>Informe de colaboraciones </h3></th>
			<th></th>
		</tr>
		<tr>
			<td> Colaboraciones totales: </td>
			<td> ${colaboracionesTotales} </td>
		</tr>
		<tr>
			<td> Colaboraciones valoradas: </td>
			<td> ${colaboracionesValoradas} </td>
		</tr>
		<tr>
			<td> Peticiones totales: </td>
			<td> ${peticionesTotales} </td>
		</tr>
		<tr>
			<td> Ofertas totales: </td>
			<td> ${ofertasTotales} </td>
		</tr>
		<tr>
			<td> Horas totales de colaboraciones: </td>
			<td>${colaboracionesHorasTotales}</td>
		</tr>
		<tr>
			<td> Media de horas por colaboración: </td>
			<td>${mediaHorasColaboracion}</td>
		</tr>
		<tr>
			<td> Valoración media de colaboraciones: </td>
			<td>${mediaValoracionColaboraciones}</td>
		</tr>
		
		
	</table>	
</body>
</html>
</jsp:body>
</t:paginabasica>