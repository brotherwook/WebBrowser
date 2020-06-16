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
		<script>
			$(function(){
				client = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime.toString());
				client.onMessageArrived = onMessageArrived;
				client.connect({onSuccess:onConnect});
			});
			
			function onConnect() {
				console.log("mqtt broker connected")
				client.subscribe("/sensor")
				client.subscribe("/camerapub");
			}
			
			function onMessageArrived(message) {
				if(message.destinationName == "/camerapub") {
					var cameraView = $("#cameraView").attr("src", "data:image/jpg;base64," + message.payloadString);
				}
				if(message.destinationName == "/sensor") {
					var sensorView = $("#sensorView").attr("value", message.payloadString)
				}
			}
			
			function red() {
				console.log($("#button1").val())
				var myObj = {led: $("#button1").val()};
				var myJSON = JSON.stringify(myObj);
				message = new Paho.MQTT.Message(myJSON);
				message.destinationName = "/command";
				client.send(message);
			}
			
			function green() {
				console.log($("#button2").val())
				var myObj = {led: $("#button2").val()};
				var myJSON = JSON.stringify(myObj);
				message = new Paho.MQTT.Message(myJSON);
				message.destinationName = "/command";
				client.send(message);
			}
			
			function blue() {
				console.log($("#button3").val())
				var myObj = {led: $("#button3").val()};
				var myJSON = JSON.stringify(myObj);
				message = new Paho.MQTT.Message(myJSON);
				message.destinationName = "/command";
				client.send(message);
			}
		</script>
	</head>
	<body>
		<h5 class="alert alert-info">/home/sungjin.jsp</h5>
		<img id="cameraView"/>
		<input id="sensorView" type="text" value="none">
		<button id="button1" onclick="red()" value="red">빨강</button>
		<button id="button2" onclick="green()" value="green">초록</button>
		<button id="button3" onclick="blue()" value="blue">파랑</button>
	</body>
</html>