<%@page contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<meta charset=UTF-8>
<title>Mofificar una nueva colaboración</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>

<script>
  $(function() {
    $( "#fechaIni" ).datepicker({ dateFormat: 'dd-mm-yy' });
    $( "#fechaFin" ).datepicker({ dateFormat: 'dd-mm-yy' });

  });

</script>
</head>
<body>
  <h2>Colaboración</h2>
  <form:form method="post" modelAttribute="miColaboracion">
        <div class="form-group">
        <form:input type="hidden" name="idColaboracion" path="idColaboracion"/>
                      
      	</div>
      	<div class="form-group">
    	    <form:label path="horasTotales">Horas totales</form:label>        
        	<form:input class="form-control" path="horasTotales" id="horasTotales" placeholder="Horas Totales" required="required"/>
			<form:errors path="horasTotales" cssClass="error fa fa-exclamation-circle"/>	
      	</div>
      	<div class="form-group">
        	<form:label path="valoracion">Valoracion</form:label>
        <%--  <form:input  class="form-control" path="valoracion" id="valoracion" placeholder="Valoracion"/>
        --%>
        		<form:radiobutton path="valoracion" value="1"/>1
        		<form:radiobutton path="valoracion" value="2"/>2
		        <form:radiobutton path="valoracion" value="3"/>3
		        <form:radiobutton path="valoracion" value="4"/>4
		        <form:radiobutton path="valoracion" value="5"/>5
      	</div>
      	<div class="form-group">
        	<input class="btn btn-primary" type="submit" value="Valorar colaboración" />
      	</div>        
  	</form:form>
</body>
</html>
</jsp:body>
</t:paginabasica>