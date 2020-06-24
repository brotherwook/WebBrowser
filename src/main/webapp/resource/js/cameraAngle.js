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
			 	
				left.update((sensor.servo2-90)*(-1), false);
				right.update((sensor.servo1)-30, false);
				chart.redraw();
			}
		}, 500);
	});
})