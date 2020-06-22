<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Jekyll v4.0.1">
    <title>Dashboard Template · Bootstrap</title>
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
	<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
	<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/mqtt_subscriber.js"></script>
	
    <link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/dashboard/">
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/highcharts-more.js"></script>		
	<script src="https://code.highcharts.com/js/themes/dark-unica.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/photoresistor.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/thermistor.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/distance.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/gas.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/highchart.css">
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/resource/assets/dist/css/bootstrap.css" rel="stylesheet">
	
    <style>
	      .bd-placeholder-img {
	        font-size: 1.125rem;
	        text-anchor: middle;
	        -webkit-user-select: none;
	        -moz-user-select: none;
	        -ms-user-select: none;
	        user-select: none;
	      }
	
	      @media (min-width: 768px) {
	        .bd-placeholder-img-lg {
	          font-size: 3.5rem;
	        }
	      }
	      
		.arrow-right {
			width: 0;
			height: 0;
			border-top: 40px solid transparent;
			border-bottom: 40px solid transparent;
			border-left: 40px solid blue;
		}
		
		.rectangle {
			width: 0;
			height: 0;
/* 			border-top: 40px solid transparent; */
/* 			border-bottom: 40px solid transparent; */
/* 			border-right: 40px solid blue; */
			border: 40px solid blue;
			fill:blue;stroke:pink;opacity:0.5;
		}
		
		.arrow-left {
			width: 0;
			height: 0;
			border-top: 40px solid transparent;
			border-bottom: 40px solid transparent;
			border-right: 40px solid blue;
		}

    </style>
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/resource/css/dashboard.css" rel="stylesheet">
    
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
			console.log(direction);
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
		var temp = 90;
		function test(){
			$("#inputtag").attr("value", temp);
		}
	</script>
    
  </head>
  <body>
    <nav class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
  <a class="navbar-brand col-md-3 col-lg-2 mr-0 px-3" href="#">Company name</a>
  <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-toggle="collapse" data-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <input class="form-control form-control-dark w-100" type="text" placeholder="Search" aria-label="Search">
  <ul class="navbar-nav px-3">
    <li class="nav-item text-nowrap">
      <a class="nav-link" href="#">Sign out</a>
    </li>
  </ul>
</nav>

<div class="container-fluid">
  <div class="row">
    <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
      <div class="sidebar-sticky pt-3">
        <ul class="nav flex-column">
          <li class="nav-item">
            <a class="nav-link" href="#">
              <span data-feather="home"></span>
              Drive
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link  active" href="#">
              Sensor Data
            </a>
          </li>
          </ul>
      </div>
    </nav>

    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Dashboard</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
          <div class="btn-group mr-2">
            <button type="button" class="btn btn-sm btn-outline-secondary">Share</button>
            <button type="button" class="btn btn-sm btn-outline-secondary">Export</button>
          </div>
          <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle">
            <span data-feather="calendar"></span>
            This week
          </button>
        </div>
      </div>
	
	
	<div style="margin-left: 10%; margin-bottom: 5%; margin-right: 10%;">
		<!-- 온도 하이차트 -->
		<figure class="highcharts-figure" style="height: 200px; width: 500px; display: inline-block;" >
			<div id="thermistor"></div>
		</figure>
	
		<!-- 조도 하이차트 -->
		<figure class="highcharts-figure" style="height: 200px; width: 500px; display: inline-block; margin-left: 30px">
			<div id="photoresistor"></div>
		</figure>
		
		<br/>
		<!-- 가스 하이차트 -->
		<figure class="highcharts-figure" style="height: 200px; width: 500px; display: inline-block;">
			<div id="container"></div>
		</figure>
	
		<!-- 초음파 하이차트 -->
		<figure class="highcharts-figure" style="height: 200px; width: 500px; display: inline-block; margin-left: 30px">
		    <div id="distance"></div>
		</figure>
		
		<!-- 초음파 방향키 -->
		<div style="margin-left: 30px ">
			<a class="arrow-left" onmousedown="hcsrMotor_down('left')" onclick="test()" style="display: inline-block; margin: 10px"></a>
			<a class="rectangle" onmousedown="hcsrMotor_down('center')" onclick="test()" style="display: inline-block; margin: 10px"></a>
			<a class="arrow-right" onmousedown="hcsrMotor_down('right')" onclick="test()" style="display: inline-block; margin: 10px"></a>
		</div>
		<div style="margin-left: 70px">
			<input id="inputtag" disabled="disabled" style="text-align: center;" value="">
		</div>

	</div>
	
      <h2 style="margin-left: 10%">Section title</h2>
      <div class="table-responsive">
        <table class="table table-striped table-sm" style="width: 60%; margin-left: 10%;">
          <thead>
            <tr>
              <th>Sensor</th>
              <th>Value</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>thermister</td>
              <td><script>sensor.temperature</script></td>
            </tr>
            <tr>
              <td>photoresistor</td>
              <td><script>sensor.photo</script></td>
            </tr>
            <!-- 왜 적용이 안되는거여 -->
            <tr>
              <td>ultrasonic</td>
              <td><script>sensor.distance</script></td>
            </tr>
            <tr>
              <td>gas</td>
              <td><script>sensor.gas</script></td>
            </tr>
          </tbody>
        </table>
      </div>
    </main>
  </div>
</div>
</html>
