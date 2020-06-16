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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/onoffbutton.css">
		<script>
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
			
			function sendMessage() {
				var command = $("#command").val();
				var message = new Paho.MQTT.Message(command);
				message.destinationName = "/command/servo1";
				message.qos = 0;
				message.retain = false;
			    publisher.send(message);
			}
			
			
			function button_click(){
				var temp = $("#p1").html();
				console.log(temp);
				if(temp == "ON"){
					$("#p1").html("OFF");
				} else {
					$("#p1").html("ON")
				}
			}
			
		</script>
	</head>
	<body>
		<h5 class="alert alert-info">/home/yehna_web_mqtt.jsp</h5>

		<form action="" method="post" onsubmit="sendMessage()">
			<input id="command" type="text" name="command" />
			<input type="submit" value="전송" />
		</form>
		
		<label class="switch">
			<input type="checkbox" onclick="button_click()">
			<span class="slider round"></span>
		</label>
		<p id="p1">OFF</p>
	</body>
</html>