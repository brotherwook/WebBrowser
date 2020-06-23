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
		<script src="https://code.highcharts.com/highcharts-more.js"></script>
		<script src="https://code.highcharts.com/modules/solid-gauge.js"></script>
		<script src="https://code.highcharts.com/modules/exporting.js"></script>
		<script src="https://code.highcharts.com/modules/export-data.js"></script>
		<script src="https://code.highcharts.com/modules/accessibility.js"></script>
		
		<!-- HighChart Theme -->
		<script src="https://code.highcharts.com/js/themes/dark-unica.js"></script>
		
		<!-- Sensors -->
		<script src="${pageContext.request.contextPath}/resource/js/photoresistor.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/thermistor.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/gas.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/tracker.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/speeddistance.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/speeddistance2.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/speeddistance3.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/speeddistance4.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/speeddistance5.js"></script>
		
		<!-- Camera -->
		<script>
			$(function(){
				client = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime.toString());
				client.onMessageArrived = onMessageArrived;
				client.connect({onSuccess:onConnect});
			});
			
			function onConnect() {
				console.log("mqtt broker connected")
				client.subscribe("/camerapub");
			}
			
			function onMessageArrived(message) {
				if(message.destinationName == "/camerapub") {
					var cameraView = $("#cameraView").attr("src", "data:image/jpg;base64," + message.payloadString);	
				}
			}
		</script>
		
		<!--  Navbar, boy, highcharts -->
		<style type="text/css">
		.highcharts-figure .chart-container {
			width: 300px;
			height: 200px;
			float: left;
		}
		
		.highcharts-figure, .highcharts-data-table table {
			width: auto;
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
		</style>
	</head>
	<body class="h-100">
		<div class="container-fluid">
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
			
			<!-- main -->
			<div class="row">
				<div class="col-2">
					<figure class="highcharts-figure">
						<div id="photoresistor"></div>
						<p class="highcharts-description">
							<!-- Chart showing data updating every second, with old data being removed. -->
						</p>
					</figure>
				</div>
	
				<div class="col-6 px-0" align="center" >
					<div class="border border-white rounded-lg px-0">
						<img id="cameraView" style="width:50%"/>
						<!-- src="${pageContext.request.contextPath}/resource/img/rover_view.jpg"
							style="width:100%; height:100%" -->
					</div>
					
					<div class="row">
						<div class="col">
						</div>
					</div>
					
					<!-- 방향키 -->
					<div class="row">
					 <table class="table table-borderless text-center">
					    <thead>
					      <tr>
					        <th class="text-white" colspan="3">Camera</th>
					        <th class="text-white" colspan="3">Sensing Rover</th>
					        <th class="text-white" colspan="3">Ultrasonic Sensor</th>
					      </tr>
					    </thead>
					    <tbody>
					      <tr>
					        <td></td>
					        <td> <!-- 카메라 up -->
					        	<a>
						        	<svg class="bi bi-chevron-up text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									  <path fill-rule="evenodd" d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z"/>
									</svg>
					        	</a>
					        </td>
					        <td></td>
					        <td></td>
					        <td> <!-- DCMotor forward -->
					        	<a>
					        		<svg class="bi bi-arrow-up text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									  <path fill-rule="evenodd" d="M8 3.5a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-1 0V4a.5.5 0 0 1 .5-.5z"/>
									  <path fill-rule="evenodd" d="M7.646 2.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8 3.707 5.354 6.354a.5.5 0 1 1-.708-.708l3-3z"/>
									</svg>
					        	</a>
					        </td>
					        <td></td>
					        <td></td>
					        <td></td>
					        <td></td>
					      </tr>
					      <tr>
					        <td> <!-- 카메라 left -->
					        	<a>
					        		<svg class="bi bi-chevron-left text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									  <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/>
									</svg>
					        	</a>
					        </td>
					        <td> <!-- 카메라 정렬 -->
					        	<a>
					        		<svg class="bi bi-plus-circle text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									  <path fill-rule="evenodd" d="M8 3.5a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5H4a.5.5 0 0 1 0-1h3.5V4a.5.5 0 0 1 .5-.5z"/>
									  <path fill-rule="evenodd" d="M7.5 8a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1H8.5V12a.5.5 0 0 1-1 0V8z"/>
									  <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
									</svg>
					        	</a>
					        </td>
					        <td> <!-- 카메라 right -->
					        	<a>
					        		<svg class="bi bi-chevron-right text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									  <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
									</svg>
					        	</a>
					        </td>
					        <td> <!-- Front Tire left -->
					        	<a>
					        		<svg class="bi bi-arrow-left text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									  <path fill-rule="evenodd" d="M5.854 4.646a.5.5 0 0 1 0 .708L3.207 8l2.647 2.646a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 0 1 .708 0z"/>
									  <path fill-rule="evenodd" d="M2.5 8a.5.5 0 0 1 .5-.5h10.5a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z"/>
									</svg>
					        	</a>
					        </td>
					        <td> <!-- DCMotor Stop -->
					        	<a>
					        		<svg class="bi bi-x-circle text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									  <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
									  <path fill-rule="evenodd" d="M11.854 4.146a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708-.708l7-7a.5.5 0 0 1 .708 0z"/>
									  <path fill-rule="evenodd" d="M4.146 4.146a.5.5 0 0 0 0 .708l7 7a.5.5 0 0 0 .708-.708l-7-7a.5.5 0 0 0-.708 0z"/>
									</svg>
					        	</a>
					        </td>
					        <td> <!-- Front Tire Right -->
					        	<a>
					        		<svg class="bi bi-arrow-right text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									  <path fill-rule="evenodd" d="M10.146 4.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L12.793 8l-2.647-2.646a.5.5 0 0 1 0-.708z"/>
									  <path fill-rule="evenodd" d="M2 8a.5.5 0 0 1 .5-.5H13a.5.5 0 0 1 0 1H2.5A.5.5 0 0 1 2 8z"/>
									</svg>
					        	</a>
					        </td>
					        <td> <!-- Ultrasonic Left -->
					        	<a>
					        		<svg class="bi bi-chevron-left text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									  <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/>
									</svg>
					        	</a>
					        </td>
					        <td> <!-- Ultrasonic 정렬 -->
					        	<a>
					        		<svg class="bi bi-plus-circle text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									  <path fill-rule="evenodd" d="M8 3.5a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5H4a.5.5 0 0 1 0-1h3.5V4a.5.5 0 0 1 .5-.5z"/>
									  <path fill-rule="evenodd" d="M7.5 8a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1H8.5V12a.5.5 0 0 1-1 0V8z"/>
									  <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
									</svg>
					        	</a>
					        </td>
					        <td> <!-- Ultrasonic Right -->
					        	<a>
					        		<svg class="bi bi-chevron-right text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									  <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
									</svg>
					        	</a>
					        </td>
					      </tr>
					      <tr>
					        <td></td>
					        <td> <!-- 카메라 down -->
					        	<a>
						        	<svg class="bi bi-chevron-down text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									  <path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>
									</svg>
					        	</a>
					        </td>
					        <td></td>
					        <td></td>
					        <td> <!-- DCMotor Backward -->
					        	<a>
					        		<svg class="bi bi-arrow-down text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									  <path fill-rule="evenodd" d="M4.646 9.646a.5.5 0 0 1 .708 0L8 12.293l2.646-2.647a.5.5 0 0 1 .708.708l-3 3a.5.5 0 0 1-.708 0l-3-3a.5.5 0 0 1 0-.708z"/>
									  <path fill-rule="evenodd" d="M8 2.5a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-1 0V3a.5.5 0 0 1 .5-.5z"/>
									</svg>
					        	</a>
					        </td>
					        <td></td>
					        <td></td>
					        <td></td>
					        <td></td>
					      </tr>
					    </tbody>
					  </table>
				</div>
				
				<div class="row">
					<div class="col-6">
						<figure class="highcharts-figure">
						    <div id="distance4" class="chart-container"></div>
						</figure>
					</div>
					<div class="col-6">
						<figure class="highcharts-figure">
						    <div id="speed4" class="chart-container"></div>
						</figure>
					</div>
				</div>
			</div>
			
			<div class="col-4">
				<div class="row">
					<div class="col-6">
						<figure class="highcharts-figure">
						    <div id="distance" class="chart-container"></div>
						</figure>
					</div>
					<div class="col-6">
						<figure class="highcharts-figure">
						    <div id="speed" class="chart-container"></div>
						</figure>
					</div>
				</div>
				<div class="row">
					<div class="col-6">
						<figure class="highcharts-figure">
						    <div id="distance2" class="chart-container"></div>
						</figure>
					</div>
					<div class="col-6">
						<figure class="highcharts-figure">
						    <div id="speed2" class="chart-container"></div>
						</figure>
					</div>
				</div>
				<div class="row">
					<div class="col-6">
						<figure class="highcharts-figure">
						    <div id="distance3" class="chart-container"></div>
						</figure>
					</div>
					<div class="col-6">
						<figure class="highcharts-figure">
						    <div id="speed3" class="chart-container"></div>
						</figure>
					</div>
				</div>
				<div class="row">
					<div class="col-6">
						<figure class="highcharts-figure">
						    <div id="distance5" class="chart-container"></div>
						</figure>
					</div>
					<div class="col-6">
						<figure class="highcharts-figure">
						    <div id="speed5" class="chart-container"></div>
						</figure>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>