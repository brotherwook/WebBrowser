$(function(){
	var gaugeOptions = {
			credits: {
				enabled:false
			},
			
		    chart: {
		        type: 'solidgauge'
		    },

		    title: null,

		    pane: {
		        center: ['50%', '85%'],
		        size: '140%',
		        startAngle: -90,
		        endAngle: 90,
		        background: {
		            backgroundColor:
		                Highcharts.defaultOptions.legend.backgroundColor || '#EEE',
		            innerRadius: '0%',
		            outerRadius: '0%',
		            shape: 'arc'
		        }
		    },

		    exporting: {
		        enabled: false
		    },

		    tooltip: {
		        enabled: false
		    },

		    // the value axis
		    yAxis: {
		        stops: [
		            [0.1, '#55BF3B'], // green
		            [0.5, '#DDDF0D'], // yellow
		            [0.9, '#DF5353'] // red
		        ],
		        lineWidth: 0,
		        tickWidth: 0,
		        minorTickInterval: null,
		        tickAmount: 2,
		        title: {
		            y: -70
		        },
		        labels: {
		            y: 16
		        }
		    },

		    plotOptions: {
		        solidgauge: {
		            dataLabels: {
		                y: 5,
		                borderWidth: 0,
		                useHTML: true
		            }
		        }
		    }
		};

		// Ultrasonic Direction
		var chartSpeed = Highcharts.chart('ultrasonic_direction', Highcharts.merge(gaugeOptions, {
		    yAxis: {
		        min: 'null',
		        max: 'null',
		        title: {
		            text: 'Ultrasonic Angle'
		        }
		    },

		    credits: {
		        enabled: false
		    },

		    series: [{
		        name: 'Speed',
		        data: [90],
		        dataLabels: {
		            format:
		                '<div style="text-align:center">' +
		                '<span style="font-size:100px;color:#82e0e2">{y}˚</span>' +
		                '</div>'
		        },
		        tooltip: {
		            valueSuffix: ' km/h'
		        }
		    }]

		}));

		// Distance
		var chartRpm = Highcharts.chart('ultrasonic', Highcharts.merge(gaugeOptions, {
		    yAxis: {
		        min: 'null',
		        max: 'null',
		        title: {
		            text: 'Distance'
		        }
		    },

		    series: [{
		        name: 'RPM',
		        data: [0],
		        dataLabels: {
		            format:
		                '<div style="text-align:center">' +
		                '<span id="distan" style="font-size:100px;color:#82e0e2">{y}</span>' +
		                '<span style="font-size:12px;opacity:0.4">' +
		                'km' +
		                '</span>' +
		                '</div>'
		        },
		        tooltip: {
		            valueSuffix: ' revolutions/min'
		        }
		    }]

		}));

		// Bring life to the dials
		setInterval(function () {
		    // Speed
		    var point,
		        newVal;
		     

		    if (chartSpeed) {
		        point = chartSpeed.series[0].points[0];
	
		        newVal =parseInt(sensor.servo3);

		        point.update(newVal);
		    }

		    // RPM
		    if (chartRpm) {
		        point = chartRpm.series[0].points[0];

		        newVal = parseInt(sensor.distance);
		        point.update(newVal);
		        if(newVal <=15){
			        $('#distan').attr('style','font-size:120px;color:#FF0000');
			        console.log("1111");
		        }
		        else{
		        	$('#distan').attr('style','font-size:100px;color:#82e0e2');
		        	console.log("2222");
		        }
		       
		    }
		}, 500);
});