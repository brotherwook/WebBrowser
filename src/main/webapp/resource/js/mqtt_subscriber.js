// Subscriber Connection
subscriber = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime().toString());
subscriber.onMessageArrived = onMessageArrived;
subscriber.connect({onSuccess:onSubscriberConnect});

