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
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script src="https://code.highcharts.com/highcharts-more.js"></script>
		<script src="https://code.highcharts.com/modules/exporting.js"></script>
		<script src="https://code.highcharts.com/modules/export-data.js"></script>
		<script src="https://code.highcharts.com/modules/accessibility.js"></script>
		<style type="text/css">
			.highcharts-figure, .highcharts-data-table table {
			    min-width: 310px; 
			    max-width: 800px;
			    margin: 1em auto;
			}
			
			.highcharts-data-table table {
				font-family: Verdana, sans-serif;
				border-collapse: collapse;
				border: 1px solid #EBEBEB;
				margin: 10px auto;
				text-align: center;
				width: 100%;
				max-width: 500px;
			}
			.highcharts-data-table caption {
			    padding: 1em 0;
			    font-size: 1.2em;
			    color: #555;
			}
			.highcharts-data-table th {
				font-weight: 600;
			    padding: 0.5em;
			}
			.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
			    padding: 0.5em;
			}
			.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
			    background: #f8f8f8;
			}
			.highcharts-data-table tr:hover {
			    background: #f1f7ff;
			}
		
		</style>
		<script>
			$(function(){
				client = new Paho.MQTT.Client('192.168.3.131', 61614, new Date().getTime().toString());
				client.connect({onSuccess:onConnect})
				client.onMessageArrived = onMessageArrived;
			})
			$(function(){
				console.log('event ready')
		  		document.addEventListener('keydown', function(e){
			    const keyCode = e.keyCode;
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
			    }
			  })
			})
			var leftVal
			var rightVal
			
			function onConnect() {
		  		console.log('mqtt broker connected')
				client.subscribe("/#");
			}
			function onMessageArrived(message) {
	  			if(message.destinationName == "/sensor"){
					var value = message.payloadString
					value = JSON.parse(value)
					leftVal = Number(value.servo2)
					rightVal = Number(value.servo1)
					console.log(leftVal)
					console.log(rightVal)
	  			}
				if(message.destinationName == "/camerapub") {
					var cameraView = $("#cameraView").attr("src", "data:image/jpg;base64," + message.payloadString);
				}
			}
			function cameraMoveUp(){
				message = new Paho.MQTT.Message("CameraUp");
			    message.destinationName = "/command";
			    console.log("CameraUp")
			    client.send(message);
			}
			function cameraMoveDown(){
				message = new Paho.MQTT.Message("CameraDown");
			    message.destinationName = "/command";
			    console.log("CameraDown")
			    client.send(message);
			}
			function cameraMoveLeft(){
				message = new Paho.MQTT.Message("CameraLeft");
			    message.destinationName = "/command";
			    console.log("CameraLeft")
			    client.send(message);
			}
			function cameraMoveRight(){
				message = new Paho.MQTT.Message("CameraRight");
			    message.destinationName = "/command";
			    console.log("CameraRight")
			    client.send(message);
			}
			function cameraMoveCenter(){
				message = new Paho.MQTT.Message("CameraCenter");
			    message.destinationName = "/command";
			    console.log("CameraCenter")
			    client.send(message);
			}
			
			$(function(){
				Highcharts.chart('container', {
				    chart: {
				      type: 'gauge',
				      plotBorderWidth: 1,
				      plotBackgroundColor: {
				        linearGradient: {
				          x1: 0,
				          y1: 0,
				          x2: 0,
				          y2: 1
				        },
				        stops: [
				          [0, '#FFF4C6'],
				          [0.3, '#FFFFFF'],
				          [1, '#FFF4C6']
				        ]
				      },
				      plotBackgroundImage: null,
				      height: 350
				    },

				    title: {
				      text: 'Camera Angle'
				    },

				    pane: [{
				      startAngle: -55,
				      endAngle: 55,
				      background: null,
				      center: ['25%', '70%'],
				      size: 250
				    }, {
				      startAngle: -120,
				      endAngle: 60,
				      background: null,
				      center: ['75%', '70%'],
				      size: 250
				    }],

				    exporting: {
				      enabled: false
				    },

				    tooltip: {
				      enabled: false
				    },

				    yAxis: [{
				      min: -55,
				      max: 55,
				      minorTickPosition: 'outside',
				      tickPosition: 'outside',
				      labels: {
				        rotation: 'auto',
				        distance: 20
				      },
				      pane: 0,
				      title: {
				        text: 'LR<br/><span style="font-size:8px">Camera Location</span>',
				        y: -40
				      }
				    }, {
				      min: -30,
				      max: 150,
				      minorTickPosition: 'outside',
				      tickPosition: 'outside',
				      labels: {
				        rotation: 'auto',
				        distance: 20
				      },
				      pane: 1,
				      title: {
				        text: 'UD<br/><span style="font-size:8px">Camera Location</span>',
				        y: -40
				      }
				    }],

				    plotOptions: {
				      gauge: {
				        dataLabels: {
				          enabled: false
				        },
				        dial: {
				          radius: '100%'
				        }
				      }
				    },

				    series: [{
				      name: 'Camera Location',
				      data: [0],
				      yAxis: 0
				    }, {
				      name: 'Camera Location',
				      data: [0],
				      yAxis: 1
				    }]

				  },

				  // Let the music play
				  function(chart) {
					setInterval(function() {
						if (chart.series) { // the chart may be destroyed
							var left = chart.series[0].points[0],
							  	right = chart.series[1].points[0];
						 	
							left.update((leftVal-90)*(-1), false);
							right.update(rightVal-30, false);
							chart.redraw();
						}
					}, 500);
				});
			})
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
		<div align="center"><input type="button" value="정면" onclick="cameraMoveCenter()"></div>
		<div align="center">
			<figure class="highcharts-figure">
			    <div id="container"></div>
			    <p class="highcharts-description">
			        Chart showing separate gauge series in a single chart, simulating stereo
			        VU meters. Each gauge has its own pane and y-axis. The chart is updated
			        dynamically every 500 milliseconds.
			    </p>
			</figure>
		</div>
	</body>
</html>
