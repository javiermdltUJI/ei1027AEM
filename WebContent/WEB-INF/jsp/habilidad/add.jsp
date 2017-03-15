<%@ page contentType="text/html; charset=iso-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>Crear una nueva habilidad</title>
</head>
<body>
	<h2>Nueva habilidad</h2>
	<form:form method="post" modelAttribute="habilidad">
		<table>
			<tr>
				<td><form:label path="nombre">Nombre</form:label></td>
				<td><form:input path="nombre" id="nombre" placeholder="Nombre"/></td>
			</tr>
			<tr>
				<td><form:label path="tipo">Tipo</form:label></td>
				<td><form:input path="tipo" id="tipo" placeholder="Tipo"/></td>
			</tr>
			<tr>
				<td><form:label path="descripcion">Descripción</form:label></td>
				<td><form:input path="descripcion" id="descripcion" placeholder="Descripción"/></td>
			</tr>
			<tr>
				<td>
				<form:label path="nivel">Nivel</form:label>
				    		<form:select path="nivel" class="form-control" id="tipoPropiedad">
								<form:option value="EXPERTO"> ---- </form:option>
								<form:option value="EXPERTO"> Experto </form:option>
								<form:option value="MEDIO">Medio</form:option>
								<form:option value="BAJO">Bajo</form:option>
							</form:select>
				</td>
			</tr>
			<tr>
				<td>
				<form:label path="estado">Estado</form:label>
				    		<form:select path="estado" class="form-control" id="tipoPropiedad">
								<form:option value="ACTIVO"> ---- </form:option>
								<form:option value="ACTIVO"> Activo </form:option>
								<form:option value="CANCELADO">Cancelado</form:option>
							</form:select>
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Agregar habilidad" /></td>
			</tr>				
		</table>
	</form:form>
</body>
</html>