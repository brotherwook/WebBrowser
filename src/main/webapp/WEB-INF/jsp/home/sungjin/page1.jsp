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
	
<!-- Highcharts -->
<script
	src="${pageContext.request.contextPath}/resource/js/speed_direction.js"></script>
	
<!-- MQTT start -->	
<script
			src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js"
			type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath}/resource/js/mqtt.js"></script>
<!-- MQTT end -->

<!-- HighCharts -->

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/solid-gauge.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
		
<!-- HighCharts Theme -->
<script src="https://code.highcharts.com/js/themes/dark-unica.js"></script>

<!-- HighCharts CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/highcharts_gauge.css">
	
<!-- Toggle Switch CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/toggle_switch.css">

<!-- Angles and sensors -->
		<!-- Highcharts -->
<script src="${pageContext.request.contextPath}/resource/js/speed_direction.js"></script>
<script src="${pageContext.request.contextPath}/resource/js/camera_direction.js"></script>

<script src="${pageContext.request.contextPath}/resource/js/ultrasonic_direction.js"></script>

<script>
function LcdContentSend() {
			var str1 = $("#input1").val()
			var str2 = $("#input2").val()
			
			//LCD로 전달
}
</script>
</head>
<body class="bg-dark">

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
					<li class="nav-item active"><a class="nav-link"
						href="page1.do"> <svg class="bi bi-command" width="1em"
								height="1em" viewBox="0 0 16 16" fill="currentColor"
								xmlns="http://www.w3.org/2000/svg">
							  <path fill-rule="evenodd"
									d="M2 3.5A1.5 1.5 0 0 0 3.5 5H5V3.5a1.5 1.5 0 1 0-3 0zM6 6V3.5A2.5 2.5 0 1 0 3.5 6H6zm8-2.5A1.5 1.5 0 0 1 12.5 5H11V3.5a1.5 1.5 0 0 1 3 0zM10 6V3.5A2.5 2.5 0 1 1 12.5 6H10zm-8 6.5A1.5 1.5 0 0 1 3.5 11H5v1.5a1.5 1.5 0 0 1-3 0zM6 10v2.5A2.5 2.5 0 1 1 3.5 10H6zm8 2.5a1.5 1.5 0 0 0-1.5-1.5H11v1.5a1.5 1.5 0 0 0 3 0zM10 10v2.5a2.5 2.5 0 1 0 2.5-2.5H10z" />
							  <path fill-rule="evenodd" d="M10 6H6v4h4V6zM5 5v6h6V5H5z" />
							</svg>
					</a></li>
					<li class="nav-item"><a class="nav-link" href="page2.do">
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
		<div class="row" style="height:94%">
		
			<div class="col-lg-4 h-100 bg-dark">
				<div class="row">
					<div class="col-3">
					</div>
					<div class="col-6 text-white">
						<!-- Rounded switch -->
						<p>Laser Emitter</p>
						<label class="switch">
						  <input type="checkbox">
						  <span class="slider round"></span>
						</label>
						<!-- Rounded switch -->
						<p>Active Buzzer</p>
						<label class="switch">
						  <input type="checkbox">
						  <span class="slider round"></span>
						</label>
						<!-- Rounded switch -->
						<p>Laser Emitter</p>
						<label class="switch">
						  <input type="checkbox">
						  <span class="slider round"></span>
						</label>
						<!-- Rounded switch -->
						<p class="text-white">Led Red</p>
						<label class="switch">
						  <input type="checkbox">
						  <span class="slider round"></span>
						</label>
						<!-- Rounded switch -->
						<p>Led Green</p>
						<label class="switch">
						  <input type="checkbox">
						  <span class="slider round"></span>
						</label>
						<!-- Rounded switch -->
						<p>Led Blue</p>
						<label class="switch">
						  <input type="checkbox">
						  <span class="slider round"></span>
						</label>
						<p>LCD</p>
						 
						  <div class="form-group">
						    <input type="text" class="form-control" id="input1">
						  </div>
						  <div class="form-group">
						    <input type="text" class="form-control" id="input2">
						  </div>
						  <button onclick="LcdContentSend()" class="btn btn-primary">Submit</button>
						
					</div>
					<div class="col-3">
					</div>
				</div>
			</div>
			
			<div class="col-lg-4 h-100 bg-dark">
				<div class="h-50 border border-white rounded-lg p-0">
					<img id="cameraView" style="height:100%; width:100%"/>
				</div>
				<div>
					<br>
					<br>
				</div>
				<div class>
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
			</div>
			
			<div class="col-lg-4 h-100 bg-dark">
			<br>
			<br>
			<br>
			<br>
				<div>
							<figure class="highcharts-figure">
			    <div id="speed" class="chart-container"></div>
			    <div id="direction" class="chart-container"></div>
			</figure>
				</div>
				
				<div>
							<figure class="highcharts-figure">
			    <div id="camera_vertical" class="chart-container"></div>
			    <div id="camera_horizontal" class="chart-container"></div>
			</figure>
				</div>
				
				<div>
							<figure class="highcharts-figure">
			    <div id="ultrasonic_direction" class="chart-container"></div>
			    <div id="ultrasonic" class="chart-container"></div>
			</figure>
				</div>
			</div>
			
		</div>
		<!-- Main end -->
		
	</div>
	<!-- main end -->
</body>
</html>