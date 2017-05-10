<%@ tag description="Estructura d'una pàgina normal" pageEncoding="UTF-8"%>
<%@ attribute name="title" required="false"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
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
	
		<header style="border:none; ">
			<a href="${pageContext.request.contextPath}" >
			<img alt="Skills sharing" src="${pageContext.request.contextPath}/img/titulo.png" style="width:30%">
		
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
		  		
		    	<a style="vertical-align:middle; color:#fff; font-size: 1.2em " href='#' class="generic-anchor footer-list-anchor">Politica de cookies</a>
		  	
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
	console.log($("#body").height());
	console.log($("#footer").height());

		if($("#body").height()<=500){
			 	document.getElementById("footer").style.position = "absolute";
			     document.getElementById("footer").style.marginBottom = "0px";
			     

			    
			 /* $('#footer').css('margin-bottom','0 em !important');
			console.log("...."); */



		}
	
	</script>
</div>
</body>
</html>