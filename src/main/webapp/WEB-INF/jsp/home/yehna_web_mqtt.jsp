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
		<style>			
			#moveCar a {
				margin:5px;
			}
		</style>
	
		<script>
			var buzzer_flag;
			var laser_flag;
			
			$(function() {
				// Publisher Connection
				publisher = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime().toString());
				publisher.connect({onSuccess:onPublisherConnect});
			});			

			function onPublisherConnect() {
				console.log("mqtt broker publisher connected");
			}

			function lcd() {
				var text = $("#lcd").val();
				var message = new Paho.MQTT.Message(command);
				message.destinationName = "/command/servo3";
				publisher.send(message);
			}
			
			function button_click(){
				var temp = $("#p1").html();
				
				if(laser_flag == "on") {
					laser_flag = "off";
				} else {
					laser_flag = "on";
				}
				
				var message = new Paho.MQTT.Message(laser_flag);
				message.destinationName = "/command/laser";
				publisher.send(message);
				
				if(temp == "ON"){
					$("#p1").html("OFF");
				} else {
					$("#p1").html("ON")
				}
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
		</form>

		<form action="" method="post" onsubmit="sendMessage()">
			<input id="command" type="text" name="command" />
			<input type="submit" value="전송" />
		</form>
		
		<label class="switch">
			<input type="checkbox" onclick="button_click()">
			<span class="slider round"></span>
		</label>
		<p id="p1">OFF</p>
		
		<img id="cameraView" />
		
		<figure class="highcharts-figure">
		    <div id="Speedometer"></div>
		</figure>
	</body>
</html>