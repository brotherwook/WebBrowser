<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Insert title here</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/js/gas.js" type="text/javascript"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/gas.css">	
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script src="https://code.highcharts.com/modules/exporting.js"></script>
		<script src="https://code.highcharts.com/modules/export-data.js"></script>
		<script src="https://code.highcharts.com/modules/accessibility.js"></script>
		<script src="https://code.highcharts.com/js/themes/dark-unica.js"></script>
		<script>
			var sensorValues;
			var sensorValue;
			$(function(){
			client = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime().toString())
			client.onMessageArrived = onMessageArrived;
			client.connect({onSuccess:onConnect});
			})
			function onMessageArrived(message) {
				if(message.destinationName == "/camerapub"){
					var cameraView = $("#cameraView").attr(
							"src", "data:image/jpg;base64,"+message.payloadString);
				}
				if(message.destinationName =="/sensor"){
					sensorValues = JSON.parse(message.payloadString);
					sensorValue = sensorValues["gasValue"];
					console.log(sensorValue);
				}
				
			}
			function onConnect() {
				console.log("mqtt broker connected");
				client.subscribe("/#");
			}
			function sendMessage(){
				order = $("#order").val();
				message = new Paho.MQTT.Message(order);
				message.destinationName = "/order"
				client.send(message);
				console.log("111");
			}
			function keyPressOrder(keyCode){
		
				message = new Paho.MQTT.Message(String(keyCode));
				message.destinationName = "/order"
				client.send(message);
			}
			function keyPressed(){
				keyCode = event.keyCode;
				console.log(keyCode);
				keyPressOrder(keyCode);
			}
			function keyUp(){
				console.log("keyUp");
				keyPressOrder("slow");
			}
		</script>
	</head>
	<body onkeydown="keyPressed()" onkeyup="keyUp()">
		<h5 class="alert alert-info">/home/jj_publish.jsp</h5>
		<form>
			order: <input id="order" type="text"></input>
			<button onclick="sendMessage()" class="btn btn-success btn-sm">전송</button>
		</form>
		<img id="cameraView"/>
		<figure class="highcharts-figure">
			<div id="container"></div>
			<p class="highcharts-description">
			</p>
		</figure>
	</body>
</html>