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
<script src="${pageContext.request.contextPath}/js/canvasjs.min.js"></script>

<script type="text/javascript">

window.onload = function () {
	CanvasJS.addColorSet("greenShades",
            [//colorSet Array

            "#DB4D00",
            "#FF5A00",
            "#FF8E50",
            "#FFA371"
            ]);
	
	var chart2 = new CanvasJS.Chart("colaboraciones", {
		colorSet: "greenShades",
		title: {
			text: "Colaboraciones, ofertas y peticiones totales"
		},
		animationEnabled: false,   // change to true
		data: [              
		{
			// Change type to "bar", "area", "spline", "pie",etc.
			type: "bar",
			dataPoints: [
				
				{ label: "Ofertas Totales",  y: ${ofertasTotales}  },
				{ label: "Peticiones Totales", y: ${peticionesTotales}  },
				{ label: "Colaboraciones Totales",  y: ${colaboracionesTotales}  },
				{ label: "Colaboraciones Valoradas", y: ${colaboracionesValoradas}  }
				
			]
		}
		]
	});
	chart2.render();
	document.getElementsByClassName("canvasjs-chart-credit")[0].style.display = "none";
	var chart = new CanvasJS.Chart("chartContainer",{
		title: {
			text: "Colaboraciones iniciadas por meses"
		},
		colorSet: "greenShades",
		axisX:{
			minimum: 0,
			maximum: 13
		},
		data: [
		{
			type: "spline",
			cursor: "move",
			dataPoints: [
				{ label: "Enero", x:1, y: ${countColaboracionesPorMes[0]} },
				{ label: "Febrero", x:2, y: ${countColaboracionesPorMes[1]} },
				{ label: "Marzo", x:3, y: ${countColaboracionesPorMes[2]} },
				{ label: "Abril", x:4, y: ${countColaboracionesPorMes[3]} },
				{ label: "Mayo", x:5, y: ${countColaboracionesPorMes[4]} },
				{ label: "Junio", x:6, y: ${countColaboracionesPorMes[5]} },
				{ label: "Julio", x:7, y: ${countColaboracionesPorMes[6]} },
				{ label: "Agosto", x:8, y: ${countColaboracionesPorMes[7]} },
				{ label: "Septiembre", x:9, y: ${countColaboracionesPorMes[8]} },
				{ label: "Octubre", x:10, y: ${countColaboracionesPorMes[9]} },
				{ label: "Noviembre", x:11, y: ${countColaboracionesPorMes[10]} },
				{ label: "Diciembre", x:12, y: ${countColaboracionesPorMes[11]} }
			]
		}					
		]
	});

	chart.render();
	var record = false;
	var precisionLevel = 1;
	var xValue, yValue, parentOffset, relX, relY;
	var selected;
	var timerId = null;
	jQuery(".canvasjs-chart-canvas").last().on({
		mousedown: function(e) {
			parentOffset = $(this).parent().offset();
			relX = e.pageX - parentOffset.left;
			relY = e.pageY - parentOffset.top;
			xValue = Math.round(chart.axisX[0].convertPixelToValue(relX));
			yValue = Math.round(chart.axisY[0].convertPixelToValue(relY));
			var dps = chart.data[0].dataPoints;
			for(var i = 0; i < dps.length; i++ ) {
				if((xValue >= dps[i].x - precisionLevel && xValue <= dps[i].x + precisionLevel) && (yValue >= dps[i].y - precisionLevel && yValue <= dps[i].y + precisionLevel) ) {
					record = true;
					selected = i;
					break;
				} else {
					selected = null;
					continue;
				}
			}
		},
		mousemove: function(e) {
			if(record ==  true) {
				parentOffset = $(this).parent().offset();
				relX = e.pageX - parentOffset.left;
				relY = e.pageY - parentOffset.top;
				xValue = Math.round(chart.axisX[0].convertPixelToValue(relX));
				yValue = Math.round(chart.axisY[0].convertPixelToValue(relY));
				clearTimeout(timerId);
				timerId = setTimeout(function(){
				if(selected != null) {
					chart.data[0].dataPoints[selected].x = xValue;
					chart.data[0].dataPoints[selected].y = yValue;
					chart.render();
				}	
				}, 0);
			}
		},
		mouseup: function(e) {
			if(selected != null) {
				chart.data[0].dataPoints[selected].x = xValue;
				chart.data[0].dataPoints[selected].y = yValue;
				chart.render();
				record = false;
			}
		}
	});
	document.getElementsByClassName("canvasjs-chart-credit")[1].style.display = "none";

}
</script>


</head>
<body>
	<h2 class="titulo">Resumen de las estadísticas del sistema</h2>
	
	<table class="table">
		<tr>
			<th colspan="2"><h3>Informe de usuarios</h3></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th colspan="2"><h3>Informe de habilidades</h3></th>
		</tr>
		<tr>
			<td> Usuarios totales: </td>
			<td>${usuariosTotales}</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td> Habilidades totales: </td>
			<td> ${habilidadesTotales} </td>
		</tr>
		<tr>
			<td> Usuarios bloqueados: </td>
			<td> ${usuariosBloqueados} </td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td> Habilidades canceladas: </td>
			<td> ${habilidadesCanceladas} </td>
		</tr>
		<tr>
			<td> Usuarios eliminados: </td>
			<td> ${usuariosEliminados} </td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td> Habilidad más ofertada: </td>
			<td> ${habilidadMasOfertada} </td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
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
			<td colspan="2"> <div id="colaboraciones" style="height: 300px; width: 80%; margin: auto; "></div></td>
		</tr>
		<tr>
			<td colspan="2"> <div id="chartContainer" style="height: 300px; width: 80%; margin: auto; "></div></td>
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