<%@ tag language="java" pageEncoding="ISO-8859-1"%>
<%@ tag description="Estructura d'una pàgina normal" pageEncoding="UTF-8"%>
<%@ attribute name="title" required="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<body>
<div id="container">

	<div id="head">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>${title}</title>
	
	<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<script>
	$('.dropdown-toggle').dropdown();
	</script>
	
		
		<t:navegacio />
		
	</div>
	<div id="body">
		<div class="container" style="left:2%">
		
			<jsp:doBody />
		</div>
		
	</div>
	
	
	
	<!--//BLOQUE COOKIES-->
	<c:if test='${ok!="1"}'>
		<div id="barraaceptacion" style="display: block;">
		    <div class="inner">
		        Solicitamos su permiso para obtener datos estadísticos de su navegación en esta web, en cumplimiento del Real 
		        Decreto-ley 13/2012. Si continúa navegando consideramos que acepta el uso de cookies.
		        <a href="javascript:void(0);" class="ok" onclick="PonerCookie();"><b>OK</b></a> | 
		        <a href="${pageContext.request.contextPath}/principal/politicas.html" target="_blank" class="info">Más información</a>
		    </div>
		</div>
	</c:if>
	<script>
	function PonerCookie(){
	    document.getElementById("barraaceptacion").style.display="none";
	    $.ajax({type: "POST",
            url: "${pageContext.request.contextPath}/principal/ok.html",
            success:function(result){
            },
           error:function(result)
            {
           }
       });
	    
	}
	
	</script>
	<!--//FIN BLOQUE COOKIES-->
	
	
	
</div>
</body>
</html>