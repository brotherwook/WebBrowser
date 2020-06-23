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
		<script
			src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		
		<!-- MQTT -->
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js"
			type="text/javascript"></script>
		
		<!-- HighChart -->
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script src="https://code.highcharts.com/modules/exporting.js"></script>
		<script src="https://code.highcharts.com/modules/export-data.js"></script>
		<script src="https://code.highcharts.com/modules/accessibility.js"></script>
		
		<!-- HighChart Theme -->
		<script src="https://code.highcharts.com/js/themes/dark-unica.js"></script>
		
		<!-- Sensors -->
		<script src="${pageContext.request.contextPath}/resource/js/photoresistor.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/thermistor.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/distance.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/gas.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/tracker.js"></script>
		
		
		<!--  Navbar, boy, highcharts -->
		<style type="text/css">
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
	<body>
		<div class="container-fluid mh-100">
			<!-- Navbar -->
			<div class="row">
				<div class="col">
					<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
					  <ul class="navbar-nav">
					    <li class="nav-item active">
					      <a class="nav-link" href="page1.do">
					      	<svg class="bi bi-command" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
							  <path fill-rule="evenodd" d="M2 3.5A1.5 1.5 0 0 0 3.5 5H5V3.5a1.5 1.5 0 1 0-3 0zM6 6V3.5A2.5 2.5 0 1 0 3.5 6H6zm8-2.5A1.5 1.5 0 0 1 12.5 5H11V3.5a1.5 1.5 0 0 1 3 0zM10 6V3.5A2.5 2.5 0 1 1 12.5 6H10zm-8 6.5A1.5 1.5 0 0 1 3.5 11H5v1.5a1.5 1.5 0 0 1-3 0zM6 10v2.5A2.5 2.5 0 1 1 3.5 10H6zm8 2.5a1.5 1.5 0 0 0-1.5-1.5H11v1.5a1.5 1.5 0 0 0 3 0zM10 10v2.5a2.5 2.5 0 1 0 2.5-2.5H10z"/>
							  <path fill-rule="evenodd" d="M10 6H6v4h4V6zM5 5v6h6V5H5z"/>
							</svg>
					      </a>
					    </li>
					    <li class="nav-item active">
					      <a class="nav-link" href="page2.do">
					      	<svg class="bi bi-gear" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
							  <path fill-rule="evenodd" d="M8.837 1.626c-.246-.835-1.428-.835-1.674 0l-.094.319A1.873 1.873 0 0 1 4.377 3.06l-.292-.16c-.764-.415-1.6.42-1.184 1.185l.159.292a1.873 1.873 0 0 1-1.115 2.692l-.319.094c-.835.246-.835 1.428 0 1.674l.319.094a1.873 1.873 0 0 1 1.115 2.693l-.16.291c-.415.764.42 1.6 1.185 1.184l.292-.159a1.873 1.873 0 0 1 2.692 1.116l.094.318c.246.835 1.428.835 1.674 0l.094-.319a1.873 1.873 0 0 1 2.693-1.115l.291.16c.764.415 1.6-.42 1.184-1.185l-.159-.291a1.873 1.873 0 0 1 1.116-2.693l.318-.094c.835-.246.835-1.428 0-1.674l-.319-.094a1.873 1.873 0 0 1-1.115-2.692l.16-.292c.415-.764-.42-1.6-1.185-1.184l-.291.159A1.873 1.873 0 0 1 8.93 1.945l-.094-.319zm-2.633-.283c.527-1.79 3.065-1.79 3.592 0l.094.319a.873.873 0 0 0 1.255.52l.292-.16c1.64-.892 3.434.901 2.54 2.541l-.159.292a.873.873 0 0 0 .52 1.255l.319.094c1.79.527 1.79 3.065 0 3.592l-.319.094a.873.873 0 0 0-.52 1.255l.16.292c.893 1.64-.902 3.434-2.541 2.54l-.292-.159a.873.873 0 0 0-1.255.52l-.094.319c-.527 1.79-3.065 1.79-3.592 0l-.094-.319a.873.873 0 0 0-1.255-.52l-.292.16c-1.64.893-3.433-.902-2.54-2.541l.159-.292a.873.873 0 0 0-.52-1.255l-.319-.094c-1.79-.527-1.79-3.065 0-3.592l.319-.094a.873.873 0 0 0 .52-1.255l-.16-.292c-.892-1.64.902-3.433 2.541-2.54l.292.159a.873.873 0 0 0 1.255-.52l.094-.319z"/>
							  <path fill-rule="evenodd" d="M8 5.754a2.246 2.246 0 1 0 0 4.492 2.246 2.246 0 0 0 0-4.492zM4.754 8a3.246 3.246 0 1 1 6.492 0 3.246 3.246 0 0 1-6.492 0z"/>
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
					    <li class="nav-item dropdown active">
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
			
			<!-- Sensors -->
			<div class="row">
				<div class="col">
					<figure class="highcharts-figure">
						<div id="photoresistor"></div>
						<p class="highcharts-description">
							<!-- Chart showing data updating every second, with old data being removed. -->
						</p>
					</figure>
				</div>
	
				<div class="col border border-white rounded-lg px-0">
					<img id="cameraView"
						src="${pageContext.request.contextPath}/resource/img/rover_view.jpg"
						style="width:100%; height:100%" />
				</div>
	
				<div class="col">
					<figure class="highcharts-figure">
						<div id="thermistor"></div>
						<p class="highcharts-description">
							<!-- Chart showing data updating every second, with old data being removed. -->
						</p>
					</figure>
				</div>
			</div>
			
			<div class="row">
				<div class="col">
					<br>
					<br>
				</div>
			</div>
	
			<div class="row">
				<div class="col">
					<figure class="highcharts-figure">
						<div id="gas"></div>
						<p class="highcharts-description">
							<!-- Chart showing data updating every second, with old data being removed. -->
						</p>
					</figure>
				</div>
	
				<div class="col">
					<figure class="highcharts-figure">
						<div id="distance"></div>
						<p class="highcharts-description">
							<!-- Chart showing data updating every second, with old data being removed. -->
						</p>
					</figure>
				</div>
	
				<div class="col">
					<figure class="highcharts-figure">
					    <div id="tracker"></div>
					    <p class="highcharts-description">
					        <!-- Chart showing data updating every second, with old data being removed. -->
					    </p>
					</figure>
				</div>
			</div>
		</div>
	</body>
</html>