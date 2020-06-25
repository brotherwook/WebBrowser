<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
<!-- 		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> -->
<!-- 		<meta name="description" content=""> -->
<!-- 		<meta name="author"	content="Mark Otto, Jacob Thornton, and Bootstrap contributors"> -->
<!-- 		<meta name="generator" content="Jekyll v4.0.1"> -->
		<meta charset="UTF-8">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
				<%-- =============== subscriber ================= --%>
		<script src="${pageContext.request.contextPath}/resource/mobile_js/mqtt_subscriber.js"></script>
		<title>Cover Template · Bootstrap</title>
		
		<!-- Bootstrap core CSS -->
<%-- 		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/dist/css/bootstrap.css"> --%>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/highchart.css">
		<style>
			.bd-placeholder-img {
				font-size: 1.125rem;
				text-anchor: middle;
				-webkit-user-select: none;
				-moz-user-select: none;
				-ms-user-select: none;
				user-select: none;
			}
			
			@media ( min-width : 768px) {
				.bd-placeholder-img-lg {
					font-size: 3.5rem;
				}
			}
			
			#moveCar a {
				margin: 5px;
			}
		</style>
		<!-- css Layout -->
<%-- 		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/cover.css"> --%>

		<script src="https://code.highcharts.com/highcharts.js"></script>
		<!-- <script src="https://code.highcharts.com/highcharts-more.js"></script> -->
		<script src="${pageContext.request.contextPath}/resource/mobile_js/photoresistor.js"></script>
		<script src="${pageContext.request.contextPath}/resource/mobile_js/thermistor.js"></script>
		<script src="${pageContext.request.contextPath}/resource/mobile_js/gas.js"></script>
		<script src="${pageContext.request.contextPath}/resource/mobile_js/distance.js"></script>
		<script src="${pageContext.request.contextPath}/resource/mobile_js/speed.js"></script>
		<script src="${pageContext.request.contextPath}/resource/mobile_js/VU.js"></script>
		<script src="${pageContext.request.contextPath}/resource/mobile_js/cameraAngle.js"></script>
		
		<%-- =============== high_chart 테마 ================= --%>
		<%-- <script src="https://code.highcharts.com/js/themes/dark-unica.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/onoffbutton.css">--%>
		<script>
			//---------------- publisher ----------------
			$(function() {
				// Publisher Connection
				publisher = new Paho.MQTT.Client("192.168.3.250", 61614,
						new Date().getTime().toString());				publisher.connect({
					onSuccess : onPublisherConnect
				});
			});
	
			function onPublisherConnect() {
				console.log("mqtt broker publisher connected");
			}
			
			
			
			function keyPressOrder(keyCode){
		
				message = new Paho.MQTT.Message(String(keyCode));
				message.destinationName = "/command/order"
				publisher.send(message);
			}

			// -------------- Buzzer --------------
			function buzzer(flag) {
				if (flag=='on'){
					$("#on").removeAttr("hidden")
					$("#off").attr("hidden","hidden")
				}else{
					$("#off").removeAttr("hidden")
					$("#on").attr("hidden","hidden")
				}
				buzzer_flag = flag;

				var buzzer_message = new Paho.MQTT.Message(buzzer_flag);
				buzzer_message.destinationName = "/command/buzzer";
				publisher.send(buzzer_message);
			}

			// -------------- DC Motor --------------
			var speed = 1000;
			
			function forward() {
				if (speed >= 4095)
					speed = 4095;
				else
					speed += 20;
				setSpeed(speed);
				
				var message = new Paho.MQTT.Message("forward");
				message.destinationName = "/command/direction";
				publisher.send(message);
			}

			function backward() {
				if (speed >= 4095)
					speed = 4095;
				else
					speed += 20;
				setSpeed(speed);
				
				var message = new Paho.MQTT.Message("backward");
				message.destinationName = "/command/direction";
				publisher.send(message);
			}

			function stop() {
				var message = new Paho.MQTT.Message("stop");
				message.destinationName = "/command/direction";
				publisher.send(message);
			}

			function setSpeed(speed) {
				var message = new Paho.MQTT.Message(speed.toString());
				message.destinationName = "/command/speed";
				publisher.send(message);
			}
			
			// ------------------ 카메라 서보 --------------
			function cameraMoveUp(){
				message = new Paho.MQTT.Message("CameraUp");
			    message.destinationName = "/command";
			    console.log("CameraUp")
			    publisher.send(message);
			}
			function cameraMoveDown(){
				message = new Paho.MQTT.Message("CameraDown");
			    message.destinationName = "/command";
			    console.log("CameraDown")
			    publisher.send(message);
			}
			function cameraMoveLeft(){
				message = new Paho.MQTT.Message("CameraLeft");
			    message.destinationName = "/command";
			    console.log("CameraLeft")
			    publisher.send(message);
			}
			function cameraMoveRight(){
				message = new Paho.MQTT.Message("CameraRight");
			    message.destinationName = "/command";
			    console.log("CameraRight")
			    publisher.send(message);
			}
			function cameraMoveCenter(){
				message = new Paho.MQTT.Message("CameraCenter");
			    message.destinationName = "/command";
			    console.log("CameraCenter")
			    publisher.send(message);
			}
			
			// -------------- Laser --------------
			var laser_flag = "off";
			
			function laser() {
				if (laser_flag == "on") {
					laser_flag = "off";
					$("#laser").attr("fill","gray")
				} else {
					laser_flag = "on";
					$("#laser").attr("fill","white")
				}

				var message = new Paho.MQTT.Message(laser_flag);
				message.destinationName = "/command/laser";
				publisher.send(message);
			}
			// -------------- Chart slide --------------
			function chart() {
				if(!$("#lcd").attr("style").includes("none")){
					$("#lcd").animate({
				        width: "toggle"
				    }, 400, "linear");
				    $("#charts").animate({
				        width: "toggle"
				    }, 400, "linear");
				}else{
				    $("#charts").animate({
				        width: "toggle"
				    }, 400, "linear");
				    $("#speedometer").animate({
				        width: "toggle"
				    }, 400, "linear");
				    if($("#tracker").attr("hidden")=="hidden"){
				    	$("#tracker").removeAttr("hidden")
				    }else if($("#tracker").attr("hidden")!="hidden"){
				    	$("#tracker").attr("hidden","hidden")
				    }
				}
			};
			// -------------- LED --------------
			function LED() {
				console.log("111")
				if ($("#LED").attr("fill")=="gray"){
					console.log("222")
					$("#LED").attr("fill","red")
					$("#light").attr("fill","red")
					red()
				}else if ($("#LED").attr("fill")=="red"){
					$("#LED").attr("fill","green")
					$("#light").attr("fill","green")
					green()
				}else if ($("#LED").attr("fill")=="green"){
					$("#LED").attr("fill","blue")
					$("#light").attr("fill","blue")
					blue()
				}else if ($("#LED").attr("fill")=="blue"){
					$("#LED").attr("fill","gray")
					$("#light").attr("fill","gray")
					off()
				}
			}
			function red() {
				console.log("red")
				message = new Paho.MQTT.Message('LedRed');
				message.destinationName = "/command";
				publisher.send(message);
			}
			
			function green() {
				console.log("green")
				message = new Paho.MQTT.Message('LedGreen');
				message.destinationName = "/command";
				publisher.send(message);
			}
			
			function blue() {
				console.log("blue")
				message = new Paho.MQTT.Message('LedBlue');
				message.destinationName = "/command";
				publisher.send(message);
			}
			
			function off() {
				console.log("off")
				message = new Paho.MQTT.Message('LedOff');
				message.destinationName = "/command";
				publisher.send(message);
			}
			//------------LCD----------------------------
			function lcdappear(){
				if (!$("#charts").attr("style").includes("none")){
					$("#charts").animate({
				        width: "toggle"
				    }, 400, "linear");
					$("#lcd").animate({
				        width: "toggle"
				    }, 400, "linear");
				}else{
					$("#lcd").animate({
				        width: "toggle"
				    }, 400, "linear");
				    $("#speedometer").animate({
				        width: "toggle"
				    }, 400, "linear");
				    if($("#tracker").attr("hidden")=="hidden"){
				    	$("#tracker").removeAttr("hidden")
				    }else if($("#tracker").attr("hidden")!="hidden"){
				    	$("#tracker").attr("hidden","hidden")
				    }
				}
			}
			function LcdContentSend() {
						var str1 = $("#input1").val()
						var str2 = $("#input2").val()
						
						//LCD로 전달
						console.log("LCD1 전달")
						message = new Paho.MQTT.Message(str1);
						message.destinationName = "/command/lcd1";
						publisher.send(message);
						
						console.log("LCD2 전달")
						message = new Paho.MQTT.Message(str2);
						message.destinationName = "/command/lcd2";
						publisher.send(message);
			}

		</script>
	</head>
	<body style="background-color: #202020">
			<table>
				<tr>
					<td style="width: 10%">
						<nav class="navbar navbar-expand-sm navbar-dark">
							<ul class="navbar-nav">
								<li class="nav-item active">
									<a class="nav-link" href="javascript:chart()">
										<svg class="bi bi-graph-up" width="2em" height="2em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
											<path d="M0 0h1v16H0V0zm1 15h15v1H1v-1z"/>
											<path fill-rule="evenodd" d="M14.39 4.312L10.041 9.75 7 6.707l-3.646 3.647-.708-.708L7 5.293 9.959 8.25l3.65-4.563.781.624z"/>
											<path fill-rule="evenodd" d="M10 3.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-1 0V4h-3.5a.5.5 0 0 1-.5-.5z"/>
										</svg>
									</a>
									<a class="nav-link" href="javascript:LED()">
										<svg class="bi bi-brightness-high-fill" width="2em" height="2em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
											<circle id="LED" fill="gray" cx="8" cy="8" r="4"/>
											<path id="light" fill-rule="evenodd" fill="gray" d="M8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z"/>
										</svg>
									</a>
									<a class="nav-link" href="javascript:laser()">
										<svg class="bi bi-lightning-fill" width="2em" height="2em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
											<path id="laser" fill="gray" fill-rule="evenodd" d="M11.251.068a.5.5 0 0 1 .227.58L9.677 6.5H13a.5.5 0 0 1 .364.843l-8 8.5a.5.5 0 0 1-.842-.49L6.323 9.5H3a.5.5 0 0 1-.364-.843l8-8.5a.5.5 0 0 1 .615-.09z"/>
										</svg>
									</a>
									<a class="nav-link" href="javascript:buzzer('off')" id="on" hidden="hidden">
										<svg class="bi bi-volume-up-fill" width="2em" height="2em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
											<path d="M11.536 14.01A8.473 8.473 0 0 0 14.026 8a8.473 8.473 0 0 0-2.49-6.01l-.708.707A7.476 7.476 0 0 1 13.025 8c0 2.071-.84 3.946-2.197 5.303l.708.707z"/>
											<path d="M10.121 12.596A6.48 6.48 0 0 0 12.025 8a6.48 6.48 0 0 0-1.904-4.596l-.707.707A5.483 5.483 0 0 1 11.025 8a5.483 5.483 0 0 1-1.61 3.89l.706.706z"/>
											<path d="M8.707 11.182A4.486 4.486 0 0 0 10.025 8a4.486 4.486 0 0 0-1.318-3.182L8 5.525A3.489 3.489 0 0 1 9.025 8 3.49 3.49 0 0 1 8 10.475l.707.707z"/>
											<path fill-rule="evenodd" d="M6.717 3.55A.5.5 0 0 1 7 4v8a.5.5 0 0 1-.812.39L3.825 10.5H1.5A.5.5 0 0 1 1 10V6a.5.5 0 0 1 .5-.5h2.325l2.363-1.89a.5.5 0 0 1 .529-.06z"/>
										</svg>
									</a>
									<a class="nav-link" href="javascript:buzzer('on')" id="off">
										<svg class="bi bi-volume-mute-fill" width="2em" height="2em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
											<path fill-rule="evenodd" d="M6.717 3.55A.5.5 0 0 1 7 4v8a.5.5 0 0 1-.812.39L3.825 10.5H1.5A.5.5 0 0 1 1 10V6a.5.5 0 0 1 .5-.5h2.325l2.363-1.89a.5.5 0 0 1 .529-.06zm7.137 1.596a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708l4-4a.5.5 0 0 1 .708 0z"/>
											<path fill-rule="evenodd" d="M9.146 5.146a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0z"/>
										</svg>
									</a>
									<a class="nav-link" href="javascript:lcdappear()" id="text">
										<svg class="bi bi-type" width="2em" height="2em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
											<path d="M2.244 13.081l.943-2.803H6.66l.944 2.803H8.86L5.54 3.75H4.322L1 13.081h1.244zm2.7-7.923L6.34 9.314H3.51l1.4-4.156h.034zm9.146 7.027h.035v.896h1.128V8.125c0-1.51-1.114-2.345-2.646-2.345-1.736 0-2.59.916-2.666 2.174h1.108c.068-.718.595-1.19 1.517-1.19.971 0 1.518.52 1.518 1.464v.731H12.19c-1.647.007-2.522.8-2.522 2.058 0 1.319.957 2.18 2.345 2.18 1.06 0 1.716-.43 2.078-1.011zm-1.763.035c-.752 0-1.456-.397-1.456-1.244 0-.65.424-1.115 1.408-1.115h1.805v.834c0 .896-.752 1.525-1.757 1.525z"/>
										</svg>
									</a>
								</li>
							</ul>
						</nav>
					</td>
					<td style="width: 50%">
						<div id="cameraView" align="center" style="position:relative;height:250px">
							<table>
								<tr>
									<td>
										<div style="display: none; background-color: #202020;height: 250px" id="charts" class="row">
											<div class="col-sm-6">
												<figure class="highcharts-figure">
											    	<div id="distance"></div>
												</figure>
											</div>
											<div class="col-sm-6">
												<figure class="highcharts-figure">
											    	<div id="photoresistor"></div>
												</figure>
											</div>
											<div class="col-sm-6">
												<figure class="highcharts-figure">
											    	<div id="thermistor"></div>
												</figure>
											</div>
											<div class="col-sm-6">
												<figure class="highcharts-figure">
											    	<div id="gas"></div>
												</figure>
											</div>
										</div>
									</td>
									<td>
										<div style="display: none; background-color: #202020;height: 250px;width: 100%" id="lcd">
											<div align="center">
												<table style="margin: 20px">
													<tr align="center">
														<td style="color: #82e0e2;font-size: 15px">LCD</td>
													</tr>
													<tr>
														<td>
															<input id="input1" type="text" style="font-size: 25px"/>
														</td>
													</tr>
													<tr>
														<td>
															<input id="input2" type="text" style="font-size: 25px"/>
														</td>
													</tr>
													<tr align="right">
														<td>
															<input onclick="LcdContentSend()" value="send" type="button" class="btn btn-primary btn-sm" style="width:100px">
														</td>
													</tr>
												</table>
											</div>
										</div>
									</td>
									<td>
										<p style="position: absolute;right:10px;bottom:0px">
											<svg class="bi bi-square-fill" id="tracker" width = "30" height = "25">
												<rect width="25" height="25" x="5"/>
											</svg>
										</p>
									<td>
									<td align="center" style="height: 200px;">
										<div id="speedometer" style="width:">
											<figure class="highcharts-figure" style="display: inline-block;">
										    	<div id="Speedometer">
												</div>
											</figure>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</td>
					<td style="width: 20%" align="center">
						<figure class="highcharts-figure">
						    <div id="container"></div>
						    <p class="highcharts-description">
						    </p>
						</figure>	
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<table style="height: 200px;width: 900px">
							<thead>
								<tr align="center">
									<td colspan="3" style="color: #82e0e2;">Sensing Rover</td>
									<td colspan="3" style="color: #82e0e2;">Ultrasonic Sensor</td>
									<td colspan="3" style="color: #82e0e2;">Camera</td>
								</tr>
							</thead>
							<tbody>
								<tr align="center" >
									<td/>
									<td> <!-- DCMotor forward -->
										<a>
											<svg class="bi bi-arrow-up text-white" width="1em" height="1em" fill="currentColor" xmlns="http://www.w3.org/2000/svg" onclick="forward()">
												<path fill-rule="evenodd" d="M8 3.5a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-1 0V4a.5.5 0 0 1 .5-.5z"/>
												<path fill-rule="evenodd" d="M7.646 2.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8 3.707 5.354 6.354a.5.5 0 1 1-.708-.708l3-3z"/>
											</svg>
										</a>
									</td>
									<td/>
									<td/>
									<td/>
									<td/>
									<td/>
									<td> <!-- 카메라 up -->
										<a>
											<svg class="bi bi-chevron-up text-white" width="1em" height="1em" fill="currentColor" xmlns="http://www.w3.org/2000/svg" onclick="cameraMoveUp()">
												<path fill-rule="evenodd" d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z"/>
											</svg>
										</a>
									</td>
									<td/>
								</tr>
								<tr align="center">
									<td> <!-- Front Tire left -->
										<a>
											<svg class="bi bi-arrow-left text-white" width="1em" height="1em" fill="currentColor" xmlns="http://www.w3.org/2000/svg" onclick="keyPressOrder(37)">
												<path fill-rule="evenodd" d="M5.854 4.646a.5.5 0 0 1 0 .708L3.207 8l2.647 2.646a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 0 1 .708 0z"/>
												<path fill-rule="evenodd" d="M2.5 8a.5.5 0 0 1 .5-.5h10.5a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z"/>
											</svg>
										</a>
									</td>
									<td> <!-- DCMotor Stop -->
										<a>
											<svg class="bi bi-x-circle text-white" width="1em" height="1em" fill="currentColor" xmlns="http://www.w3.org/2000/svg"  onclick="stop()">
												<path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
												<path fill-rule="evenodd" d="M11.854 4.146a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708-.708l7-7a.5.5 0 0 1 .708 0z"/>
												<path fill-rule="evenodd" d="M4.146 4.146a.5.5 0 0 0 0 .708l7 7a.5.5 0 0 0 .708-.708l-7-7a.5.5 0 0 0-.708 0z"/>
											</svg>
										</a>
									</td>
									<td> <!-- Front Tire Right -->
										<a>
											<svg class="bi bi-arrow-right text-white" width="1em" height="1em" fill="currentColor" xmlns="http://www.w3.org/2000/svg" onclick="keyPressOrder(39)">
												<path fill-rule="evenodd" d="M10.146 4.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L12.793 8l-2.647-2.646a.5.5 0 0 1 0-.708z"/>
												<path fill-rule="evenodd" d="M2 8a.5.5 0 0 1 .5-.5H13a.5.5 0 0 1 0 1H2.5A.5.5 0 0 1 2 8z"/>
											</svg>
										</a>
									</td>
									<td> <!-- Ultrasonic Left -->
										<a>
											<svg class="bi bi-chevron-left text-white" width="1em" height="1em" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
												<path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/>
											</svg>
										</a>
									</td>
									<td> <!-- Ultrasonic 정렬 -->
										<a>
											<svg class="bi bi-plus-circle text-white" width="1em" height="1em" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
												<path fill-rule="evenodd" d="M8 3.5a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5H4a.5.5 0 0 1 0-1h3.5V4a.5.5 0 0 1 .5-.5z"/>
												<path fill-rule="evenodd" d="M7.5 8a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1H8.5V12a.5.5 0 0 1-1 0V8z"/>
												<path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
											</svg>
										</a>
									</td>
									<td> <!-- Ultrasonic Right -->
										<a>
											<svg class="bi bi-chevron-right text-white" width="1em" height="1em" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
												<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
											</svg>
										</a>
									</td>
									<td> <!-- 카메라 left -->
										<a>
											<svg class="bi bi-chevron-left text-white" width="1em" height="1em" fill="currentColor" xmlns="http://www.w3.org/2000/svg" onclick="cameraMoveLeft()">
												<path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/>
											</svg>
										</a>
									</td>
									<td> <!-- 카메라 정렬 -->
										<a>
											<svg class="bi bi-plus-circle text-white" width="1em" height="1em" fill="currentColor" xmlns="http://www.w3.org/2000/svg" onclick="cameraMoveCenter()">
												<path fill-rule="evenodd" d="M8 3.5a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5H4a.5.5 0 0 1 0-1h3.5V4a.5.5 0 0 1 .5-.5z"/>
												<path fill-rule="evenodd" d="M7.5 8a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1H8.5V12a.5.5 0 0 1-1 0V8z"/>
												<path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
											</svg>
										</a>
									</td>
									<td> <!-- 카메라 right -->
										<a>
											<svg class="bi bi-chevron-right text-white" width="1em" height="1em" fill="currentColor" xmlns="http://www.w3.org/2000/svg" onclick="cameraMoveRight()">
												<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
											</svg>
										</a>
									</td>
								</tr>
								<tr align="center">
									<td/>
									<td> <!-- DCMotor Backward -->
										<a>
											<svg class="bi bi-arrow-down text-white" width="1em" height="1em" fill="currentColor" xmlns="http://www.w3.org/2000/svg"  onclick="backward()">
												<path fill-rule="evenodd" d="M4.646 9.646a.5.5 0 0 1 .708 0L8 12.293l2.646-2.647a.5.5 0 0 1 .708.708l-3 3a.5.5 0 0 1-.708 0l-3-3a.5.5 0 0 1 0-.708z"/>
												<path fill-rule="evenodd" d="M8 2.5a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-1 0V3a.5.5 0 0 1 .5-.5z"/>
											</svg>
										</a>
									</td>
									<td/>
									<td/>
									<td/>
									<td/>
									<td/>
									<td> <!-- 카메라 down -->
										<a>
											<svg class="bi bi-chevron-down text-white" width="1em" height="1em" fill="currentColor" xmlns="http://www.w3.org/2000/svg" onclick="cameraMoveDown()">
												<path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>
											</svg>
										</a>
									</td>
									<td/>
								</tr>
				   			</tbody>
						</table>
					</td>
				</tr>
			</table>
	</body>
</html>
