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

		// Camera Vertical Angle
		var chartSpeed = Highcharts.chart('camera_vertical', Highcharts.merge(gaugeOptions, {
		    yAxis: {
		        min: 'null',
		        max: 'null',
		        title: {
		            text: 'Camera VA'
		        }
		    },

		    credits: {
		        enabled: false
		    },

		    series: [{
		        name: 'Speed',
		        data: [80],
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

		// Camera Horizontal Angle
		var chartRpm = Highcharts.chart('camera_horizontal', Highcharts.merge(gaugeOptions, {
		    yAxis: {
		        min: 'null',
		        max: 'null',
		        title: {
		            text: 'Camera HA'
		        }
		    },

		    series: [{
		        name: 'RPM',
		        data: [0],
		        dataLabels: {
		            format:
		                '<div style="text-align:center">' +
		                '<span style="font-size:100px;color:#82e0e2">{y}˚</span>' +
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
		        newVal = parseInt(sensor.servo1);
		        point.update(newVal);
		        
		    }

		    // RPM
		    if (chartRpm) {
		    	point = chartRpm.series[0].points[0];
		        newVal = parseInt(sensor.servo2);		    
		        point.update(newVal);
		    }
		}, 500);
});