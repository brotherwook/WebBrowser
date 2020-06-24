$(function() {
	// Subscriber Connection
	subscriber = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime().toString());
	subscriber.onMessageArrived = onMessageArrived;
	subscriber.connect({onSuccess:onSubscriberConnect});
});

//called when a message arrives
function onMessageArrived(message) {
	if(message.destinationName == "/camerapub") {
		$("#cameraView").attr("src", "data:image/jpg;base64, " + message.payloadString);
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
				
			}
		})
	}
}

// called when the client connects
function onSubscriberConnect() {
	console.log("mqtt broker subscriber connected");  
	subscriber.subscribe("/#");
}