$(function(){
	Highcharts.chart('thermistor', {
	    chart: {
	        type: 'spline',
	        animation: Highcharts.svg, // don't animate in old IE
	        marginRight: 10,
	        events: {
	            load: function () {
	
	                // set up the updating of the chart each second
	                var series = this.series[0];
	                setInterval(function () {
	                    var x = (new Date()).getTime(), // current time
	                        y = Number(sensor.temperature)
	                    series.addPoint([x, y], true, true);
	                }, 1000);
	            }
	        }
	    },
	
	    time: {
	        useUTC: false
	    },
	
	    title: {
	        text: 'Thermistor : Temperature'
	    },
	
	    xAxis: {
	        type: 'datetime',
	        tickPixelInterval: 150
	    },
	
	    yAxis: {
	        title: {
	            text: 'Value'
	        },
	        plotLines: [{
	            value: 0,
	            width: 1,
	            color: '#808080'
	        }]
	    },
	
	    tooltip: {
	        headerFormat: '<b>{series.name}</b><br/>',
	        pointFormat: '{point.x:%Y-%m-%d %H:%M:%S}<br/>{point.y:.2f}'
	    },
	
	    legend: {
	        enabled: false
	    },
	
	    exporting: {
	        enabled: false
	    },
	
	    series: [{
	        name: 'temperature',
	        data: (function () {
	            // generate an array of random data
	            var data = [],
	                time = (new Date()).getTime(),
	                i;
	
	            for (i = -10; i <= 0; i += 1) {
	                data.push({
	                    x: time + i * 1000,
	                    y: 0
	                });
	            }
	            return data;
	        }())
	    }]
	});
});