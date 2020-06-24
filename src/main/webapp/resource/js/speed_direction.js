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
		            innerRadius: '60%',
		            outerRadius: '100%',
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
		            [0.1, '#82e0e2'], // green
		            [0.5, '#82e0e2'], // yellow
		            [0.9, '#82e0e2'] // red
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
	
	var gaugeOptions2 = {
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

		// The speed gauge
		var chartSpeed = Highcharts.chart('speed', Highcharts.merge(gaugeOptions, {
		    yAxis: {
		        min: 0,
		        max: 200,
		        title: {
		            text: 'Speed'
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
		                '<span style="font-size:25px">{y}</span><br/>' +
		                '<span style="font-size:12px;opacity:0.4">km/h</span>' +
		                '</div>'
		        },
		        tooltip: {
		            valueSuffix: ' km/h'
		        }
		    }]

		}));

		// The RPM gauge
		var chartRpm = Highcharts.chart('direction', Highcharts.merge(gaugeOptions2, {
		    yAxis: {
		        min: 'null',
		        max: 'null',
		        title: {
		            text: 'Direction'
		        }
		    },

		    series: [{
		        name: 'RPM',
		        data: [1],
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