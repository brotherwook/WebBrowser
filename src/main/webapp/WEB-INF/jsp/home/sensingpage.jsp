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
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script src="https://code.highcharts.com/highcharts-more.js"></script>		
		<script src="https://code.highcharts.com/js/themes/dark-unica.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/photoresistor.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/thermistor.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/distance.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/gas.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/highchart.css">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		
		<style>
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
		// -------------- Publisher --------------
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

		// -------------- UltraSonic Servo Motor --------------
		var hcsr_angle = 90;
		
		function hcsrMotor_down(direction) {
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
		</script>
	</head>
	<body>
		<div>
		<!-- 온도 하이차트 -->
			<figure class="highcharts-figure">
				<div id="thermistor"></div>
				    <p class="highcharts-description">
				        Chart showing data updating every second, with old data being removed.
				    </p>
			</figure>
		</div>
		<div>
		<!-- 조도 하이차트 -->
			<figure class="highcharts-figure">
				<div id="photoresistor"></div>
				    <p class="highcharts-description">
				        Chart showing data updating every second, with old data being removed.
				    </p>
			</figure>
		</div>
	
		<div>
		<!-- 가스 하이차트 -->
			<figure class="highcharts-figure">
				<div id="container"></div>
					<p class="highcharts-description">
						Chart showing data updating every second, with old data being removed.
					</p>
			</figure>
		</div>
		<div>
		<!-- 초음파 하이차트 -->
			<figure class="highcharts-figure">
			    <div id="distance"></div>
			    <p class="highcharts-description">
			    	Chart showing data updating every second, with old data being removed.
			    </p>
			</figure>
		</div>
		
		<div>
		<!-- 초음파 방향키 -->
			<a class="arrow-left" onmousedown="hcsrMotor_down('left')" style="display: inline-block; margin: 10px"></a>
			<a class="arrow-right" onmousedown="hcsrMotor_down('right')" style="display: inline-block; margin: 10px"></a>
		</div>
		
		<div>
		<!-- 트래커 black white -->
		</div>
	</body>
</html>