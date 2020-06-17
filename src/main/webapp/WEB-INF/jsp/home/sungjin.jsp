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
		
		<!-- MQTT -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
		
		<!-- HighChart -->
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script src="https://code.highcharts.com/modules/exporting.js"></script>
		<script src="https://code.highcharts.com/modules/export-data.js"></script>
		<script src="https://code.highcharts.com/modules/accessibility.js"></script>
		<!-- HighChart Theme -->
		<script src="https://code.highcharts.com/js/themes/dark-unica.js"></script>
		
		<!-- HighChart CSS -->
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
		
			//------------- MQTT ------------------	
		
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
					svalue = message.payloadString
					svalue = JSON.parse(svalue)
					/* console.log(svalue) */
					var sensorView = $("#sensorView").attr("value", message.payloadString)
				}
			}
			
			//---------------------------------------------
			
			// ------------ RGB -------------------------
			
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
			
			//-----------------------------------------------
			
			//----------- HighCharts --------------------
			
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
				                        y = Number(svalue["photo"])
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
				                        y = Number(svalue["temperature"])
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
			
			// ---------------------------------------------
			
		</script>
	</head>
	<body>
		<h5 class="alert alert-info">/home/sungjin.jsp</h5>
		<img id="cameraView"/>
		<input id="sensorView" type="text" value="none">
		<button id="button1" onclick="red()" value="red">빨강</button>
		<button id="button2" onclick="green()" value="green">초록</button>
		<button id="button3" onclick="blue()" value="blue">파랑</button>
		<figure class="highcharts-figure">
			<div id="photoresistor"></div>
			    <p class="highcharts-description">
			        Chart showing data updating every second, with old data being removed.
			    </p>
		</figure>
		<figure class="highcharts-figure">
			<div id="thermistor"></div>
			    <p class="highcharts-description">
			        Chart showing data updating every second, with old data being removed.
			    </p>
		</figure>
		
	</body>
</html>