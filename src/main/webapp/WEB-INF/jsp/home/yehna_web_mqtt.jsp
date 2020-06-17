<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
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
		<script src="${pageContext.request.contextPath}/resource/js/mqtt_subscriber.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/onoffbutton.css">
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script src="https://code.highcharts.com/highcharts-more.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/speed.js"></script>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<style>
			#moveCar a {
				margin: 5px;
			}
			
			.arrow-right {
				width: 0;
				height: 0;
				border-top: 30px solid transparent;
				border-bottom: 30px solid transparent;
				border-left: 30px solid blue;
			}
			
			.arrow-left {
				width: 0;
				height: 0;
				border-top: 30px solid transparent;
				border-bottom: 30px solid transparent;
				border-right: 30px solid blue;
			}
		</style>
	
		<script>
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
			$(function() {
				document.addEventListener('keydown', function(e) {
					const keyCode = e.keyCode;
					console.log('pushed key ' + keyCode);

					if (keyCode == 32) { // Space키 - Buzzer 
						buzzer("on");
					}

					if (keyCode == 38) { // forward 키
						forward();
						if (speed >= 4095)
							speed = 4095;
						else
							speed += 20;
						setSpeed(speed);
					}

					if (keyCode == 40) { // backward 키
						backward();
						if (speed >= 4095)
							speed = 4095;
						else
							speed += 20;
						setSpeed(speed);
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
				var message = new Paho.MQTT.Message("forward");
				message.destinationName = "/command/direction";
				publisher.send(message);
			}

			function backward() {
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

			// -------------- Servo Motor --------------
			var hcsr_angle = 90;
			var isPressed = false;
			
			function hcsrMotor_down(direction) {
				hcsr_flag = true;
					console.log("클릭");
					if(direction == "left") {
						if (hcsr_angle >= 180)
							hcsr_angle = 180;
						else
							hcsr_angle += 30;
					}
					else if(direction == "right") {
						if (hcsr_angle <= 0)
							hcsr_angle = 0;
						else
							hcsr_angle -= 30;
					}
					else
						hcsr_angle = 90;
					
					var message = new Paho.MQTT.Message(hcsr_angle.toString());
					message.destinationName = "/command/servo3";
					publisher.send(message);
				
			}
			
			function hcsrMotor_up() {
				hcsr_flag = false;
			}
		</script>
	</head>
	<body>
		<h5 class="alert alert-info">/home/yehna_web_mqtt.jsp</h5>
		
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
		

		<a class="arrow-left" onmousedown="hcsrMotor_down('left')" onmouseup="hcsrMotor_up()" 
		style="display: inline-block; margin: 10px"></a>

		<a class="arrow-right" onmousedown="hcsrMotor_down('right')" onmouseup="hcsrMotor_up()" 
		style="display: inline-block; margin: 10px"></a>

		
		<br/>
		<form action="" method="post" onsubmit="sendMessage()">
			<input id="command" type="text" name="command" />
			<input type="submit" value="전송" />
		</form>
		
		<label class="switch">
			<input type="checkbox" onclick="laser()">
			<span class="slider round"></span>
		</label>
		<p id="p1">OFF</p>
		
		<img id="cameraView" />
		
		<figure class="highcharts-figure">
		    <div id="Speedometer"></div>
		</figure>
	</body>
</html>