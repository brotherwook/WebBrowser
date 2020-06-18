<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="">
		<meta name="author"	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
		<meta name="generator" content="Jekyll v4.0.1">
		<meta charset="UTF-8">
		<title>Insert title here</title>
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
		<script src="${pageContext.request.contextPath}/resource/js/mqtt_subscriber.js"></script>
		<title>Cover Template · Bootstrap</title>
		
		<!-- Bootstrap core CSS -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/dist/css/bootstrap.css">
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
		<!-- Custom styles for this template -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/cover.css">

		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script src="https://code.highcharts.com/highcharts-more.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/speed.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/cameraAngle.js"></script>
		
		<%-- =============== high_chart 테마 ================= --%>
		<script src="https://code.highcharts.com/js/themes/dark-unica.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/onoffbutton.css">
		<script>
			//---------------- publisher ----------------
			$(function() {
				// Publisher Connection
				publisher = new Paho.MQTT.Client(location.hostname, 61614,
						new Date().getTime().toString());
				publisher.connect({
					onSuccess : onPublisherConnect
				});
			});
	
			function onPublisherConnect() {
				console.log("mqtt broker publisher connected");
			}
			
			// -------------- Keyboard Pressed --------------
			$(function(){
				console.log('event ready')
		  		document.addEventListener('keydown', function(e) {
				    const keyCode = e.keyCode;
				    console.log(keyCode);
				    if (keyCode == 32) { // Space키 - Buzzer 
						buzzer("on");
					}

					if (keyCode == 38) { // forward 키
						forward();
					} else if (keyCode == 40) { // backward 키
						backward();
					}
					
				    if(keyCode == 87){ // w
				    	cameraMoveUp()
				    } else if(keyCode == 83){ // s
				    	cameraMoveDown()
				    } else if(keyCode == 65){ // a
				    	cameraMoveLeft()
				    } else if(keyCode == 68){ // d
				    	cameraMoveRight()
				    } else if(keyCode == 82){ // r(카메라 중앙정렬)
				    	cameraMoveCenter()
				    } else if(keyCode == 49){ // 1 red
				    	ledred()
				    } else if(keyCode == 50){ // 2 green
				    	ledgreen()
				    } else if(keyCode == 51){ // 3 blue
				    	ledblue()
				    } else if(keyCode == 52){ // 4(off)
				    	ledoff()
				    }
				})
			})
			
			// -------------- Keyboard Up --------------
			$(function() {
				document.addEventListener('keyup', function(e) {
					const keyCode = e.keyCode;
					console.log('pushed key ' + e.key);

					if (keyCode == 32) { // Space키 - Buzzer 
						buzzer("off");
					}

					if (keyCode == 38 || keyCode == 40) { // forward, backward 키
						stop();
						speed = 1000;
					}
				})
			})
			
			// -------------- Buzzer --------------
			function buzzer(flag) {
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
			var laser_flag;
			
			function laser() {
				var temp = $("#p1").html();

				if (laser_flag == "on") {
					laser_flag = "off";
				} else {
					laser_flag = "on";
				}

				var message = new Paho.MQTT.Message(laser_flag);
				message.destinationName = "/command/laser";
				publisher.send(message);

				if (temp == "ON") {
					$("#p1").html("OFF");
				} else {
					$("#p1").html("ON")
				}
			}
		</script>
	</head>
	<body>
		
		<div>
			<a id="buzzer" class="btn btn-info" onclick="buzzer()">Buzzer</a>
			<a id="laser" class="btn btn-danger" onclick="laser()">Laser</a>
		</div>
		<div id="moveCar" style="margin-top: 20px;">
			<a id="forward" style="margin-left: 60px;" class="btn btn-warning" onclick="forward()">Forward</a>
			<br/>
			<a id="left" class="btn btn-warning" onclick="left()">Left</a>
			<a id="stop" class="btn btn-secondary" onclick="stop()">Stop</a>
			<a id="right" class="btn btn-warning" onclick="right()">Right</a>
			<br/>
			<a id="backward" style="margin-left: 55px;" class="btn btn-warning" onclick="backward()">Backward</a>
		</div>
		<div align="center"><input type="button" value="상" onclick="cameraMoveUp()"></div>
		<div align="center">
			<input type="button" value="좌" onclick="cameraMoveLeft()">
			<img id="cameraView"/>
			<input type="button" value="우" onclick="cameraMoveRight()">
		</div>
		<div align="center"><input type="button" value="하" onclick="cameraMoveDown()"></div>
		<div align="center"><input type="button" value="정면" onclick="cameraMoveCenter()"></div>
	
		<div>
			<figure class="highcharts-figure">
		    	<div id="Speedometer"></div>
			</figure>
		</div>
		
		<div>
			<figure class="highcharts-figure">
			    <div id="container"></div>
			    <p class="highcharts-description">
			        	카메라 각도
			    </p>
			</figure>
		</div>
		
		<div>
			<label class="switch">
				<input type="checkbox" onclick="laser()">
				<span class="slider round"></span>
			</label>
			<p id="p1">OFF</p>
		</div>
			
	</body>
</html>
