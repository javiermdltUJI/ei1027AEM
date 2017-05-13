<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %> 
<t:paginabasica title="EI1027">
<jsp:body>
<html> 
  <head>
<title>Skill Sharing</title>
  </head>
  <body>
  
  	<div id="left_widget_column">
  
		
		<img alt="" src="${pageContext.request.contextPath}/img/brains.png" style="width:50%;     margin-right: 25%;   margin-left: 25%;">
		<h4 >Bienvenido a la aplicación web Skill Sharing</h4>
		
		Somos un grupo de estudiantes de informática que pretende mejorar la comunicación entre estudiantes con el objetivo de que unos aprendan de otros y colaboren activamente.
		
	</div>

	<div id="right_widget_column">
		<h2>Empieza ahora a utilizarlo</h2>
		<p>
  			Con esta plataforma podrás enseñar tus habilidades y  conocimientos a otros estudiantes y a la vez podrás recibir conocimientos de otros estudiantes.
		</p>
		<img alt="" src="${pageContext.request.contextPath}/img/Customer-Feedback.jpg" style="width:34%;     margin-right: 32%;   margin-left: 32%;">
					
		<p>Registrate ahora para empezar a utilizarlo!!</p>
					
					<a class="btn btn-warning" style="color:#fff; margin-left:40%" href="${pageContext.request.contextPath}/usuario/add.html">Registrarme!</a>
		
	</div>  
  	
  	
	
 </body>
 </html>
</jsp:body>
</t:paginabasica>