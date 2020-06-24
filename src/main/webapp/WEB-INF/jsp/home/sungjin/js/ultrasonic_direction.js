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
		        data: [1],
		        dataLabels: {
		            format:
		                '<div style="text-align:center">' +
		                '<span style="font-size:100px;color:#82e0e2">{y}</span>' +
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
		        newVal,
		        inc;

		    if (chartSpeed) {
		        point = chartSpeed.series[0].points[0];
		        inc = Math.round((Math.random() - 0.5) * 100);
		        newVal = point.y + inc;

		        if (newVal < 0 || newVal > 200) {
		            newVal = point.y - inc;
		        }

		        point.update(newVal);
		    }

		    // RPM
		    if (chartRpm) {
		        point = chartRpm.series[0].points[0];
		        inc = Math.round((Math.random() - 0.5) * 100);
		        newVal = point.y + inc;

		        if (newVal < 0 || newVal > 5) {
		            newVal = point.y - inc;
		        }

		        point.update(newVal);
		    }
		}, 2000);
});