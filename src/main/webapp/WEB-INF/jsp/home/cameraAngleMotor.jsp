<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix ="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
		<script>
			$(function(){
				subscriber = new Paho.MQTT.Client('192.168.3.131', 61614, new Date().getTime.toString());
				subscriber.connect({onSuccess:onConnect});
				subscriber.onMessageArrived = onMessageArrived;
				
				publisher = new Paho.MQTT.Client('192.168.3.131', 61614, new Date().getTime.toString());
				publisher.connect({onSuccess:onConnect})
			})
			
			function onConnect() {
		  		console.log('mqtt broker connected')
				subscriber.subscribe("#");
			}

			function onMessageArrived(message) {
	  			console.log(message.payloadString)
				var value = message.payloadString
				value = JSON.parse(value)
	  			if(message.destinationName == "/sensor"){
	  				$('#cameraUD').attr('value',value.cudangle)
	  				$('#cameraLR').attr('value',value.clrangle)
	  			}
				if(message.destinationName == "/camerapub") {
					$("#cameraView").attr("src", "data:image/jpg;base64," + message.payloadString);
				}
			}
			function cameraMoveUp(){
				message = new Paho.MQTT.Message("CameraUp");
			    message.destinationName = "/command";
			    publisher.send(message);
			}
			function cameraMoveDown(){
				message = new Paho.MQTT.Message("CameraDown");
			    message.destinationName = "/command";
			    publisher.send(message);
			}
			function cameraMoveLeft(){
				message = new Paho.MQTT.Message("CameraLeft");
			    message.destinationName = "/command";
			    publisher.send(message);
			}
			function cameraMoveRight(){
				message = new Paho.MQTT.Message("CameraRight");
			    message.destinationName = "/command";
			    publisher.send(message);
			}
		</script>
	</head>
	<body>
		<h5 class = "alert alert-info" >/cameraAngle.jsp</h5>
		<div align="center"><input type="button" value="상" onclick="cameraMoveUp()"></div>
		<div align="center">
			<input type="button" value="좌" onclick="cameraMoveLeft()">
			<img id="cameraView"/>
			<input type="button" value="우" onclick="cameraMoveRight()">
		</div>
		<div align="center"><input type="button" value="하" onclick="cameraMoveDown()"></div>
		<div align="center"></div>
		<div align="center">
			<input id="cameraUD" readonly>
		</div>
		<div align="center">
			<input id="cameraLR" readonly>
		</div>
	</body>
</html>
