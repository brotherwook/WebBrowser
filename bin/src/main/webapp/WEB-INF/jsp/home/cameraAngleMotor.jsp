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
		<script>
			$(function(){
				client = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime.toString());
				client.connect({onSuccess:onConnect});
				client.onMessageArrived = onMessageArrived;
			})
			
			function onConnect() {
		  		console.log('mqtt broker connected')
				client.subscribe("/sensor");
		  		message = new Paho.MQTT.Message("Hello");
			  	message.destinationName = "/command";
			  	client.send(message);
			}

			function onMessageArrived(message) {
				var value = message.payloadString
				value = JSON.parse(value)
				console.log(typeof(value))
				console.log(value)
	  			if(message.destinationName == "/sensor"){
	  				$('#cameraUD').attr('value',value.cudangle)
	  				$('#cameraLR').attr('value',value.clrangle)
	  			}
			}
		</script>
	</head>
	<body>
		<h5 class = "alert alert-info" >/cameraAngle.jsp</h5>
		<div align="center">
			<input id="cameraUD" readonly>
		</div>
		<div align="center">
			<input id="cameraLR" readonly>
			</div>
	</body>
</html>
