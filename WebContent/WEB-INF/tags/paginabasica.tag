<%@ tag description="Estructura d'una pàgina normal"
	pageEncoding="UTF-8"%>
<%@ attribute name="title" required="false"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${title}</title>

<!-- Bootstrap -->
<link href="${pageContext.request.contextPath}/css/bootstrap.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css"
	rel="stylesheet">

<script>
$('.dropdown-toggle').dropdown();
</script>



<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>


</head>

<body>
	<header class="container page-header">
		<a href="${pageContext.request.contextPath}" >
		<img alt="Skills sharing" src="${pageContext.request.contextPath}/img/titulo.png" style="width:60%">
	
		</a>
	<t:login />
	
	</header>
	<t:navegacio />
	<div class="container" style="left:2%">
	
		<jsp:doBody />
	</div>
	<!-- <footer style="left:2%">
	<hr>
	<p class="text-muted" >
	
	EI1027 - Disseny i Implementació de Sistemes d'Informació
	</p>
	</footer> -->
	
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<footer style="margin-top:2%">
  

  <div class=" bg-primary py-3" style="padding:0.7%; font-size:small;">
    <div class="container" style="font-size:x-small;">
       <div class="col-md-4">
    	 <div class="row py-2">
			<div>
				  <span class="fa fa-2x fa-fw fa-laptop" style=" vertical-align: middle;"></span>
				  <span class="my-text">Cookie policy</span>
			</div>     
          
          </div>
  
    	</div>
    	<div class="col-md-4">
          <!-- row start -->
          <div class="row py-2">
            <div>
				  <span class="fa fa-2x fa-fw fa-address-card" style=" vertical-align: middle;"></span>
				  <span class="my-text">Contact us</span>
			</div>
            
          </div>
          <!-- row end -->
          
        </div>
        <!-- footer column 2 end -->
        <!-- footer column 3 start -->
        <!-- <div class="col-md-4">          
          row starting 
          <div class="row py-2">
          	<div class="col-sm-9">
            	<i class="fa fa-2x fa-fw fa-info" aria-hidden="true "></i>Info
          	</div>
          </div>
          row ended
        </div> -->
        <div class="col-md-4">          
          <!-- row starting  -->
          <div class="row py-2">
          	<div class="col-sm-9">
	          	 <div>
					  <span class="fa fa-2x fa-fw " style=" vertical-align: middle;"></span>
					  <span class="my-text">Copyright © 2017 All rights reserved</span>
				</div>
                  
          	</div>
          </div>
          <!-- row ended -->
        </div>
        <!-- footer column 3 end -->
      </div>
      <!-- <div style="margin-top:1%; margin-left:40%; margin-right:40%">
               <p class="text-white">   Copyright © 2017 All rights reserved</p> 
      </div>       -->
  	</div>
</footer>
</body>
</html>