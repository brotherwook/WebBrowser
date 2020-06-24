$(function(){
				Highcharts.chart('container', {
	    chart: {
	    	backgroundColor: "rgba(0,0,0,0)",
			type: 'gauge',
			plotBorderWidth: 1,
			plotBackgroundColor: 'transparent',
			plotBackgroundImage: null,
			width: 120,
			height: 200
	    },

	    title: {
    		text: 'Camera Angle',
	        style:{ "color": "#82e0e2", "fontSize": "10px" }
	    },

	    pane: [{
	      startAngle: -55,
	      endAngle: 55,
	      background: null,
	      center: ['50%', '40%'],
	      size: 70
	    }, {
	      startAngle: -120,
	      endAngle: 60,
	      background: null,
	      center: ['50%', '80%'],
	      size: 70
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
	      minorTickColor: '#00FFFF',
	      tickPosition: 'outside',
	      tickColor: '#00FFFF ',
	      labels: {
	        rotation: 'auto',
	        distance: '130%'
	      },
	      pane: 0,
	      title: {
	        text: 'LR<br/><span style="font-size:8px">Camera Location</span>',
	        y: 0
	      }
	    }, {
	      min: -30,
	      max: 150,
	      minorTickPosition: 'outside',
	      minorTickColor: '#00FFFF',
	      tickPosition: 'outside',
	      tickColor: '#00FFFF ',
	      labels: {
	        rotation: 'auto',
	        distance: '120%'
	      },
	      pane: 1,
	      title: {
	        text: 'UD<br/><span style="font-size:8px">Camera Location</span>',
	        y: 0
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
	    credits: {
            enabled: false
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