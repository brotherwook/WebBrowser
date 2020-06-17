<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix ="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
		<script src="https://code.highcharts.com/js/themes/dark-unica.js"></script>
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
		<style type="text/css">
			.highcharts-figure, .highcharts-data-table table {
			  min-width: 320px; 
			  max-width: 800px;
			  margin: 1em auto;
			}
			
			#container {
			  height: 400px;
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
			    } else if(keyCode == 49){ // 1 red
			    	ledred()
			    } else if(keyCode == 50){ // 2 green
			    	ledgreen()
			    } else if(keyCode == 51){ // 3 blue
			    	ledblue()
			    } else if(keyCode == 52){ // 4(off)
			    	ledoff()
			    }
			  })
			})
			
			function onConnect() {
		  		console.log('mqtt broker connected')
				client.subscribe("/#");
			}
			var value
			function onMessageArrived(message) {
	  			if(message.destinationName == "/sensor"){
					value = message.payloadString
					value = JSON.parse(value)
					$("#LedView").attr("value", value.led);
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
			function ledred() {
				message = new Paho.MQTT.Message('LedRed');
				message.destinationName = "/command";
				console.log("red")
				client.send(message);
			}
			
			function ledgreen() {
				console.log("green")
				message = new Paho.MQTT.Message('LedGreen');
				message.destinationName = "/command";
				client.send(message);
			}
			
			function ledblue() {
				console.log("blue")
				message = new Paho.MQTT.Message('LedBlue');
				message.destinationName = "/command";
				client.send(message);
			}
			
			function ledoff() {
				console.log("Ledoff")
				message = new Paho.MQTT.Message('LedOff');
				message.destinationName = "/command";
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

				  function(chart) {
					setInterval(function() {
						if (chart.series) { // the chart may be destroyed
							var left = chart.series[0].points[0],
							  	right = chart.series[1].points[0];
						 	
							left.update((Number(value.servo2)-90)*(-1), false);
							right.update(Number(value.servo1)-30, false);
							chart.redraw();
						}
					}, 500);
				});
			})
			//------------------------------------------------------
			$(function(){
				Highcharts.chart('photoresistor', {
				    chart: {
				        type: 'spline',
				        animation: Highcharts.svg, // don't animate in old IE
				        marginRight: 10,
				        events: {
				            load: function () {
				
				                // set up the updating of the chart each second
				                var series = this.series[0];
				                setInterval(function () {
				                    var x = (new Date()).getTime(), // current time
				                        y = Number(value.photo)
				                    series.addPoint([x, y], true, true);
				                }, 1000);
				            }
				        }
				    },
				
				    time: {
				        useUTC: false
				    },
				
				    title: {
				        text: 'Photoresistor : Light Intensity'
				    },
				
				    accessibility: {
				        announceNewData: {
				            enabled: true,
				            minAnnounceInterval: 15000,
				            announcementFormatter: function (allSeries, newSeries, newPoint) {
				                if (newPoint) {
				                    return 'New point added. Value: ' + newPoint.y;
				                }
				                return false;
				            }
				        }
				    },
				
				    xAxis: {
				        type: 'datetime',
				        tickPixelInterval: 150
				    },
				
				    yAxis: {
				        title: {
				            text: 'Value'
				        },
				        plotLines: [{
				            value: 0,
				            width: 1,
				            color: '#808080'
				        }]
				    },
				
				    tooltip: {
				        headerFormat: '<b>{series.name}</b><br/>',
				        pointFormat: '{point.x:%Y-%m-%d %H:%M:%S}<br/>{point.y:.2f}'
				    },
				
				    legend: {
				        enabled: false
				    },
				
				    exporting: {
				        enabled: false
				    },
				
				    series: [{
				        name: 'light intensity',
				        data: (function () {
				            // generate an array of random data
				            var data = [],
				                time = (new Date()).getTime(),
				                i;
				
				            for (i = -19; i <= 0; i += 1) {
				                data.push({
				                    x: time + i * 1000,
				                    y: Math.random()
				                });
				            }
				            return data;
				        }())
				    }]
				});
			});
			
			$(function(){
				Highcharts.chart('thermistor', {
				    chart: {
				        type: 'spline',
				        animation: Highcharts.svg, // don't animate in old IE
				        marginRight: 10,
				        events: {
				            load: function () {
				
				                // set up the updating of the chart each second
				                var series = this.series[0];
				                setInterval(function () {
				                    var x = (new Date()).getTime(), // current time
				                        y = Number(value.temperature)
				                    series.addPoint([x, y], true, true);
				                }, 1000);
				            }
				        }
				    },
				
				    time: {
				        useUTC: false
				    },
				
				    title: {
				        text: 'Thermistor : Temperature'
				    },
				
				    accessibility: {
				        announceNewData: {
				            enabled: true,
				            minAnnounceInterval: 15000,
				            announcementFormatter: function (allSeries, newSeries, newPoint) {
				                if (newPoint) {
				                    return 'New point added. Value: ' + newPoint.y;
				                }
				                return false;
				            }
				        }
				    },
				
				    xAxis: {
				        type: 'datetime',
				        tickPixelInterval: 150
				    },
				
				    yAxis: {
				        title: {
				            text: 'Value'
				        },
				        plotLines: [{
				            value: 0,
				            width: 1,
				            color: '#808080'
				        }]
				    },
				
				    tooltip: {
				        headerFormat: '<b>{series.name}</b><br/>',
				        pointFormat: '{point.x:%Y-%m-%d %H:%M:%S}<br/>{point.y:.2f}'
				    },
				
				    legend: {
				        enabled: false
				    },
				
				    exporting: {
				        enabled: false
				    },
				
				    series: [{
				        name: 'temperature',
				        data: (function () {
				            // generate an array of random data
				            var data = [],
				                time = (new Date()).getTime(),
				                i;
				
				            for (i = -19; i <= 0; i += 1) {
				                data.push({
				                    x: time + i * 1000,
				                    y: Math.random()
				                });
				            }
				            return data;
				        }())
				    }]
				});
			});
			
		</script>
	</head>
	<body style="background-color: #505053">
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
			<input id="LedView" type="text" readonly>
			<button id="button1" onclick="ledred()">빨강</button>
			<button id="button2" onclick="ledgreen()">초록</button>
			<button id="button3" onclick="ledblue()">파랑</button>
			<button id="button3" onclick="ledoff()">Off</button>
		</div>
		<div align="center">
			<figure class="highcharts-figure">
			    <div id="container"></div>
			    <p class="highcharts-description">
			        	카메라 각도
			    </p>
			</figure>
			<figure class="highcharts-figure" style="display:inline-block">
				<div id="photoresistor"></div>
				    <p class="highcharts-description">
				        Chart showing data updating every second, with old data being removed.
				    </p>
			</figure>
			<figure class="highcharts-figure" style="display:inline-block">
				<div id="thermistor"></div>
				    <p class="highcharts-description">
				        Chart showing data updating every second, with old data being removed.
				    </p>
			</figure>
		</div>
	</body>
</html>
