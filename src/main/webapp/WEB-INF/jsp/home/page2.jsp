<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Insert title here</title>
		<link rel="stylesheet"
			href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script
			src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script
			src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script
			src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet"
			href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
				
		<!-- MQTT -->
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js"
			type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/js/mqtt_subscriber.js"></script>

		
		<!-- HighChart -->
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script src="https://code.highcharts.com/modules/exporting.js"></script>
		<script src="https://code.highcharts.com/modules/export-data.js"></script>
		<script src="https://code.highcharts.com/modules/accessibility.js"></script>
		
		<!-- HighChart Theme -->
		<script src="https://code.highcharts.com/js/themes/dark-unica.js"></script>
		
		<script>
		setInterval(function(){
			if(sensor.tracker == "White") {
				$("#tracker").attr("src", "${pageContext.request.contextPath}/resource/img/white.jpg");
			} else{
				$("#tracker").attr("src", "${pageContext.request.contextPath}/resource/img/black.jpg");
			}
		}, 500);
		
		var gas=[];
		var photo=[];
		var temperature=[];
		var dist=[];
		var time=[];
		
		$.ajax({
			type: "POST",
			url: "highchartplot.do",
			async: false,
			success: function(data) {
				gas.push(data.gas);
				photo.push(data.photo);
				temperature.push(data.temperature);
				dist.push(data.dist);
			}
		});
		
		</script>
		
		<!-- Sensors -->
		<script src="${pageContext.request.contextPath}/resource/js/photoresistor.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/thermistor.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/distance.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/gas.js"></script>
		
		<!--  Navbar, boy, highcharts -->
		<style type="text/css">
		.highcharts-figure .chart-container {
			width: 300px;
			height: 200px;
			float: left;
		}
		
		.highcharts-figure, .highcharts-data-table table {
			width: 400px;
			margin: 0 auto;
		}
		
		.highcharts-data-table table {
		    font-family: Verdana, sans-serif;
		    border-collapse: collapse;
		    border: 1px solid #EBEBEB;
		    margin: 10px auto;
		    text-align: center;
		    width: 100%;
		    max-width: 500px;
		}
		.highcharts-data-table caption {
		    padding: 1em 0;
		    font-size: 1.2em;
		    color: #555;
		}
		.highcharts-data-table th {
			font-weight: 600;
		    padding: 0.5em;
		}
		.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
		    padding: 0.5em;
		}
		.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
		    background: #f8f8f8;
		}
		.highcharts-data-table tr:hover {
		    background: #f1f7ff;
		}
		
		@media (max-width: 600px) {
			.highcharts-figure, .highcharts-data-table table {
				width: 100%;
			}
			.highcharts-figure .chart-container {
				width: 300px;
				float: none;
				margin: 0 auto;
			}
		
		}
		
		.highcharts-background {
			fill: #343a40;
		}
		
		body {
			background-color: #343a40;
		}
		
		navbar navbar-expand-sm bg-dark navbar-dark {
			background-color: #343a40;
		}
		}
		</style>
	</head>
	<body class="h-100">
		
		<div class="container-fluid">
			<!-- Navbar -->
			<div class="row">
				<div class="col">
					<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
					  <ul class="navbar-nav">
					    <li class="nav-item">
					      <a class="nav-link" href="page1.do">
					      	<svg class="bi bi-command" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
							  <path fill-rule="evenodd" d="M2 3.5A1.5 1.5 0 0 0 3.5 5H5V3.5a1.5 1.5 0 1 0-3 0zM6 6V3.5A2.5 2.5 0 1 0 3.5 6H6zm8-2.5A1.5 1.5 0 0 1 12.5 5H11V3.5a1.5 1.5 0 0 1 3 0zM10 6V3.5A2.5 2.5 0 1 1 12.5 6H10zm-8 6.5A1.5 1.5 0 0 1 3.5 11H5v1.5a1.5 1.5 0 0 1-3 0zM6 10v2.5A2.5 2.5 0 1 1 3.5 10H6zm8 2.5a1.5 1.5 0 0 0-1.5-1.5H11v1.5a1.5 1.5 0 0 0 3 0zM10 10v2.5a2.5 2.5 0 1 0 2.5-2.5H10z"/>
							  <path fill-rule="evenodd" d="M10 6H6v4h4V6zM5 5v6h6V5H5z"/>
							</svg>
					      </a>
					    </li>
					    <li class="nav-item active">
					      <a class="nav-link" href="page3.do">
					      	<svg class="bi bi-graph-up" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
							  <path d="M0 0h1v16H0V0zm1 15h15v1H1v-1z"/>
							  <path fill-rule="evenodd" d="M14.39 4.312L10.041 9.75 7 6.707l-3.646 3.647-.708-.708L7 5.293 9.959 8.25l3.65-4.563.781.624z"/>
							  <path fill-rule="evenodd" d="M10 3.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-1 0V4h-3.5a.5.5 0 0 1-.5-.5z"/>
							</svg>
					      </a>
					    </li>
					    <li class="nav-item dropdown">
					      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
					        <svg class="bi bi-archive" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
							  <path fill-rule="evenodd" d="M2 5v7.5c0 .864.642 1.5 1.357 1.5h9.286c.715 0 1.357-.636 1.357-1.5V5h1v7.5c0 1.345-1.021 2.5-2.357 2.5H3.357C2.021 15 1 13.845 1 12.5V5h1z"/>
							  <path fill-rule="evenodd" d="M5.5 7.5A.5.5 0 0 1 6 7h4a.5.5 0 0 1 0 1H6a.5.5 0 0 1-.5-.5zM15 2H1v2h14V2zM1 1a1 1 0 0 0-1 1v2a1 1 0 0 0 1 1h14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H1z"/>
							</svg>
					      </a>
					      <div class="dropdown-menu">
					        <a class="dropdown-item" href="https://github.com/brotherwook/SensingRover">Sensing Rover</a>
					        <a class="dropdown-item" href="https://github.com/brotherwook/WebBrowser">Web Browser</a>
					      </div>
					    </li>
					  </ul>
					</nav>
				</div>
			</div>
			
			<div id="section">
				<table width="75%" style="text-align: center; border: none; margin: auto;">
					<tr>
						<td >
							<img id="tracker" src="${pageContext.request.contextPath}/resource/img/black.jpg" 
									style="width:100px; height: 210px; margin-top: 50px;">		
						</td>
						
						<td>
							<figure class="highcharts-figure">
								<div id="photoresistor"></div>
							</figure>
						</td>
						
						<td>
							<figure class="highcharts-figure">
								<div id="thermistor"></div>
							</figure>
						</td>
						
					</tr>
	
					<tr style="height: 20px;"></tr>
					
					<tr>
						<td>
						
						</td>
						<td>
							<figure class="highcharts-figure">
								<div id="gas"></div>
							</figure>
						</td>
						
						<td>
							<figure class="highcharts-figure">
								<div id="distance"></div>
							</figure>
						</td>				
					</tr>
				</table>
			</div>
			
	</body>
</html>