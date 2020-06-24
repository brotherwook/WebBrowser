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
	
<!-- MQTT start -->	
<script
			src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js"
			type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath}/resource/js/mqtt.js"></script>
<!-- MQTT end -->

<!-- HighCharts -->
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script src="https://code.highcharts.com/modules/exporting.js"></script>
		<script src="https://code.highcharts.com/modules/export-data.js"></script>
		<script src="https://code.highcharts.com/modules/accessibility.js"></script>
		
<!-- HighCharts Theme -->
<script src="https://code.highcharts.com/js/themes/dark-unica.js"></script>

<!-- HighCharts CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/highcharts_line.css">

<!-- Sensors -->
		<script src="${pageContext.request.contextPath}/resource/js/photoresistor.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/thermistor.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/distance.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/gas.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/tracker.js"></script>

</head>
<body>

	<!--  main start -->
	<div class="container-fluid bg-dark vh-100">
	
		<!-- Navbar start -->
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse"
				id="navbarNavDropdown">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link"
						href="page1.do"> <svg class="bi bi-command" width="1em"
								height="1em" viewBox="0 0 16 16" fill="currentColor"
								xmlns="http://www.w3.org/2000/svg">
							  <path fill-rule="evenodd"
									d="M2 3.5A1.5 1.5 0 0 0 3.5 5H5V3.5a1.5 1.5 0 1 0-3 0zM6 6V3.5A2.5 2.5 0 1 0 3.5 6H6zm8-2.5A1.5 1.5 0 0 1 12.5 5H11V3.5a1.5 1.5 0 0 1 3 0zM10 6V3.5A2.5 2.5 0 1 1 12.5 6H10zm-8 6.5A1.5 1.5 0 0 1 3.5 11H5v1.5a1.5 1.5 0 0 1-3 0zM6 10v2.5A2.5 2.5 0 1 1 3.5 10H6zm8 2.5a1.5 1.5 0 0 0-1.5-1.5H11v1.5a1.5 1.5 0 0 0 3 0zM10 10v2.5a2.5 2.5 0 1 0 2.5-2.5H10z" />
							  <path fill-rule="evenodd" d="M10 6H6v4h4V6zM5 5v6h6V5H5z" />
							</svg>
					</a></li>
					<li class="nav-item active"><a class="nav-link" href="page2.do">
							<svg class="bi bi-graph-up" width="1em" height="1em"
								viewBox="0 0 16 16" fill="currentColor"
								xmlns="http://www.w3.org/2000/svg">
							  <path d="M0 0h1v16H0V0zm1 15h15v1H1v-1z" />
							  <path fill-rule="evenodd"
									d="M14.39 4.312L10.041 9.75 7 6.707l-3.646 3.647-.708-.708L7 5.293 9.959 8.25l3.65-4.563.781.624z" />
							  <path fill-rule="evenodd"
									d="M10 3.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-1 0V4h-3.5a.5.5 0 0 1-.5-.5z" />
							</svg>
					</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbardrop"
						data-toggle="dropdown"> <svg class="bi bi-archive" width="1em"
								height="1em" viewBox="0 0 16 16" fill="currentColor"
								xmlns="http://www.w3.org/2000/svg">
							  <path fill-rule="evenodd"
									d="M2 5v7.5c0 .864.642 1.5 1.357 1.5h9.286c.715 0 1.357-.636 1.357-1.5V5h1v7.5c0 1.345-1.021 2.5-2.357 2.5H3.357C2.021 15 1 13.845 1 12.5V5h1z" />
							  <path fill-rule="evenodd"
									d="M5.5 7.5A.5.5 0 0 1 6 7h4a.5.5 0 0 1 0 1H6a.5.5 0 0 1-.5-.5zM15 2H1v2h14V2zM1 1a1 1 0 0 0-1 1v2a1 1 0 0 0 1 1h14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H1z" />
							</svg>
					</a>
						<div class="dropdown-menu"
							aria-labelledby="navbarDropdownMenuLink">
							<a class="dropdown-item"
								href="https://github.com/brotherwook/SensingRover">Sensing
								Rover</a> <a class="dropdown-item"
								href="https://github.com/brotherwook/WebBrowser">Web Browser</a>
						</div></li>
				</ul>
			</div>
		</nav>
		<!-- Navbar end -->
		
		<!-- Main start -->
		<div class="row row-cols-lg-3" style="height:94%">
			<div class="col-lg h-50 bg-dark">
				<figure class="highcharts-figure">
						<div id="photoresistor"></div>
						<p class="highcharts-description">
							<!-- Chart showing data updating every second, with old data being removed. -->
						</p>
					</figure>
			</div>
			<div class="col-lg h-50 bg-dark border border-white rounded-lg p-0">
				<img id="cameraView" style="height:100%; width:100%"/>
			</div>
			<div class="col-lg h-50 bg-dark">
				<figure class="highcharts-figure">
						<div id="thermistor"></div>
						<p class="highcharts-description">
							<!-- Chart showing data updating every second, with old data being removed. -->
						</p>
					</figure>
			</div>
			<div class="col-lg h-50 bg-dark">
				<figure class="highcharts-figure">
						<div id="gas"></div>
						<p class="highcharts-description">
							<!-- Chart showing data updating every second, with old data being removed. -->
						</p>
					</figure>
			</div>
			<div class="col-lg h-50 bg-dark">
				<figure class="highcharts-figure">
						<div id="distance"></div>
						<p class="highcharts-description">
							<!-- Chart showing data updating every second, with old data being removed. -->
						</p>
					</figure>
			</div>
			<div class="col-lg h-50 bg-dark">
				<figure class="highcharts-figure">
					    <div id="tracker"></div>
					    <p class="highcharts-description">
					        <!-- Chart showing data updating every second, with old data being removed. -->
					    </p>
					</figure>
			</div>
		</div>
		<!-- Main end -->
		
	</div>
	<!-- main end -->
</body>
</html>