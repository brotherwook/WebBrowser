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
		
		<style>			
			#moveCar a {
				margin:5px;
			}
		</style>
		
		<script>
			var buzzer_flag;
			var laser_flag;
			
			$(function() {
				// Subscriber Connection
				subscriber = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime().toString());
				subscriber.onMessageArrived = onMessageArrived;
				subscriber.connect({onSuccess:onSubscriberConnect});
				
				// Publisher Connection
				publisher = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime().toString());
				publisher.connect({onSuccess:onPublisherConnect});
			});
			
			// called when a message arrives
			function onMessageArrived(message) {
				if(message.destinationName == "/sensor") {
					sensor = JSON.parse(message.payloadString);
					$.ajax({
						type: "POST",
						url: "receivedData.do",
						data: {
							buzzer : sensor.buzzer,
							dcmotor_speed : sensor.dcmotor_speed,
							dcmotor_dir : sensor.dcmotor_dir,
							gas : sensor.gas,
							distance : sensor.distance,
							laser : sensor.laser,
							photo : sensor.photo,
							led : sensor.led,
							servo1 : sensor.servo1,
							servo2 : sensor.servo2,
							servo3 : sensor.servo3,
							servo4 : sensor.servo4,
							temperature : sensor.temperature,
							tracker : sensor.tracker
							},
						success: function() {
							
						}
					})

					// Buzzer ON/OFF 데이터 전송 받음
					buzzer_flag = sensor.buzzer;
					
					// Laser ON/OFF 데이터 전송 받음
					laser_flag = sensor.laser;
				}
			}

			// called when the client connects
			function onSubscriberConnect() {
				console.log("mqtt broker subscriber connected");
				subscriber.subscribe("/sensor");
			}

			function onPublisherConnect() {
				console.log("mqtt broker publisher connected");
			}

			function lcd() {
				var text = $("#lcd").val();
				var message = new Paho.MQTT.Message(command);
				message.destinationName = "/command/servo3";
				publisher.send(message);
			}

			function buzzer() {
				if(buzzer_flag == "on") {
					buzzer_flag = "off";
				} else {
					buzzer_flag = "on";
				}
				var buzzer_message = new Paho.MQTT.Message(buzzer_flag);
				buzzer_message.destinationName = "/command/buzzer";
				publisher.send(buzzer_message);
			}

			function laser() {
				if(laser_flag == "on") {
					laser_flag = "off";
				} else {
					laser_flag = "on";
				}
				var message = new Paho.MQTT.Message(laser_flag);
				message.destinationName = "/command/laser";
				publisher.send(message);
			}
			
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
		<br/>
		
		<form action="" method="post" onsubmit="lcd()">
			<input id="lcd" type="text" name="lcd_text" />
			<input type="submit" value="전송" />
		</form>
	</body>
</html>