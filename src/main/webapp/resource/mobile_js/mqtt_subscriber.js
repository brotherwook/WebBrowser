$(function() {
	// Subscriber Connection
	subscriber = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime().toString());
	subscriber.onMessageArrived = onMessageArrived;
	subscriber.connect({onSuccess:onSubscriberConnect});
});

//called when a message arrives
function onMessageArrived(message) {
	if(message.destinationName == "/camerapub") {
		$("#cameraView").attr("style","background-image: url(data:image/jpg;base64," + message.payloadString+");background-repeat: no-repeat;background-size: 100%;position:relative;height:250px");
	}
	
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
				if(sensor.tracker=='Black'){
					$("#tracker rect").attr("fill","black")
				}
				else if(sensor.tracker=='White'){
					$("#tracker rect").attr("fill","white")
				}
			}
		})
	}
	
	
}

// called when the client connects
function onSubscriberConnect() {
	console.log("mqtt broker subscriber connected");  
	subscriber.subscribe("/#");
}