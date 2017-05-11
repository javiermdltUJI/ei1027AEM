<%@page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:paginabasica title="EI1027">
<jsp:body>
<html>
<head>
<meta charset=UTF-8>
<title>Crear una nueva habilidad</title>
</head>
<body>
	<h2>Nueva habilidad</h2>
	<form:form method="post" modelAttribute="habilidad">
			<div class="form-group">
				<form:label path="nombre">Nombre</form:label>
				<form:input class="form-control"  path="nombre" id="nombre" placeholder="Nombre" required="required"/>
				<form:errors path="nombre" cssClass="error fa fa-exclamation-circle"/>	
			</div>
			<div class="form-group">
			
				<form:label path="tipo">Tipo</form:label>
				<form:input class="form-control"  path="tipo" id="tipo" placeholder="Tipo" required="required"/>
				<form:errors path="tipo" cssClass="error fa fa-exclamation-circle"/>	
			</div>
			<div class="form-group">
			
				<form:label path="descripcion">Descripción</form:label>
				<form:input class="form-control"  path="descripcion" id="descripcion" placeholder="Descripción" required="required"/>
				<form:errors path="descripcion" cssClass="error fa fa-exclamation-circle"/>	
			</div>
			<div class="form-group">
				<form:label path="nivel">Nivel</form:label>
				<form:select path="nivel" class="form-control" id="tipoPropiedad">
								<form:option value="EXPERTO"> ---- </form:option>
								<form:option value="EXPERTO"> Experto </form:option>
								<form:option value="MEDIO">Medio</form:option>
								<form:option value="BAJO">Bajo</form:option>
				</form:select>
			</div>
			<div class="form-group">
				<form:label path="estado">Estado</form:label>
				<form:select path="estado" class="form-control" id="tipoPropiedad">
								<form:option value="ACTIVO"> ---- </form:option>
								<form:option value="ACTIVO"> Activo </form:option>
								<form:option value="CANCELADO">Cancelado</form:option>
				</form:select>
			</div>
			<div class="form-group">
	
				<input class="btn btn-secundary"  type="submit" value="Agregar habilidad" />
			</div>				
	</form:form>
</body>
</html>
</jsp:body>
</t:paginabasica>