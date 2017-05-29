<%@ tag description="Estructura d'una pàgina normal" pageEncoding="ISO-8859-1"%>
<%@ attribute name="title" required="false"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/logo.ico?" type="image/x-icon" />
</head>

<body>
<div id="container">

	<div id="head">
	<meta charset="ISO-8859-1">
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
	
		<header style="border:none;">
			<a href="${pageContext.request.contextPath}" style="margin-left:33%" >
			<img alt="Skills sharing" src="${pageContext.request.contextPath}/img/titulo3.png" style="width:28%">
		
			</a>
			<t:login />
		
		</header>
		<t:navegacio />
		
	</div>
	<div id="body">
		<div class="container" style="left:2%">
		
		
			<jsp:doBody />
		</div>
		
	</div>
	
		<div id="footer" class="flex-rw">
		  
		  <div class="footer-list-top">
		
		  	<div style="margin-left:10% ;font-size:1.4em">
<!-- 		  	  <span style="vertical-align:middle; color:#fff">CONNECT <span class="footer-social-small">with</span> US    </span>
 -->		  	
		 	  <a style="vertical-align:middle; color:#fff; font-size: 1.2em " href="https://plus.google.com/" title="Google Plus" >  <i class="fa fa-google-plus"></i></a>
			  <a style="vertical-align:middle; color:#fff; font-size: 1.2em " href="https://github.com/javiermdltUJI/ei1027AEM" title="GitHUb" ><i class="fa fa-github" aria-hidden="true"></i></a>
		
		 	</div>
		    </div>
		  
		  
		  <div class="footer-list-top">
		      <span class="footer-social-overlap footer-social-icons-wrapper">
		  		
		  	    <a style="vertical-align:middle; color:#fff; font-size: 1.2em " href='+#' class="generic-anchor footer-list-anchor" >Sobre Nosotros</a>
		  	
		 	  </span>
		    
		   </div>
		  <div class="footer-list-top">
	
		    <span class="footer-social-overlap footer-social-icons-wrapper">
		  		
		    	<a style="vertical-align:middle; color:#fff; font-size: 1.2em " href='${pageContext.request.contextPath}/principal/politicas.html' class="generic-anchor footer-list-anchor">Politica de cookies</a>
		  	
		 	</span>
		    
		    
		  </div>
		  <div class="footer-list-top"> 
		      <span class="footer-social-overlap footer-social-icons-wrapper">
		  		
		   		<a style="vertical-align:middle; color:#fff; font-size: 1.2em " href='#' class="generic-anchor footer-list-anchor" >Algo más</a>
		  	
		 	</span>
		   
		  </div>
		  <section class="footer-bottom-section flex-rw">
			<div style="margin-left:40%; color:#fff" class="footer-bottom-wrapper">   
				<i style="color:#fff " class="fa fa-copyright" role="copyright">
		 
				</i> 2017 Skills Sharing <address class="footer-address" role="company address">EAM, Castellón de la plana</address><span class="footer-bottom-rights"> - All Rights Reserved - </span>
		    </div>
		   
		  </section>
		</div>
		
		<script>


		if($("#body").height()<=500){
			 	document.getElementById("footer").style.position = "absolute";
			 	
			 	
			     document.getElementById("footer").style.marginBottom = "0px";
			     

			    
			 /* $('#footer').css('margin-bottom','0 em !important');
			console.log("...."); */



		}else{
		 	document.getElementById("footer").style.position = "relative";

		}
	
	</script>
	
	
	
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