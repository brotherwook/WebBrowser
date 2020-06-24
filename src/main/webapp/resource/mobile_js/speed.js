// 속력 하이차트
var speedchart
$(function(){
	 speedchart= Highcharts.chart('Speedometer', {

	    chart: {
	    	backgroundColor: "rgba(0,0,0,0)",
	        type: 'gauge',
	        plotBackgroundColor: 'transparent',
	        plotBackgroundImage: null,
	        plotBorderWidth: 0,
	        plotShadow: false,
	        height:'100%',
	        width:200
	    },
	    credits: {
            enabled: false
        },

	    title: {
	        text: 'Speedometer',
	        style:{ "color": "#82e0e2", "fontSize": "15px" }
	    },

	    pane: {
	        startAngle: -150,
	        endAngle: 150,
	        background: null
	    },

	    // the value axis
	    yAxis: {
	        min: 0,
	        max: 200,

	        minorTickInterval: 'auto',
	        minorTickWidth: 1,
	        minorTickLength: 10,
	        minorTickPosition: 'outside',
	        minorTickColor: '#00FFFF',

	        tickPixelInterval: 30,
	        tickWidth: 2,
	        tickPosition: 'inside',
	        tickLength: 10,
	        tickColor: '#00FFFF ',
	        labels: {
	            step: 2,
	            rotation: 'auto',
            	distance:'120%'
	        },
	        title: {
	            text: 'km/h'
	        },
	        plotBands: [{
	            from: 0,
	            to: 200,
	            color: '#82e0e2' // green
	        }]
	    },

	    series: [{
	        name: 'Speed',
	        data: [0],
	        tooltip: {
	            valueSuffix: ' km/h'
	        }
	    }]

	},
	function (speedchart) {
	    if (!speedchart.renderer.forExport) {
	    	setInterval(function () {
	    	    var point = speedchart.series[0].points[0],
	    	        newVal
	    	    try{
	    	        inc = sensor.dcmotor_speed;
	    	    } catch(e){
	    	    	inc=0;
	    	    }
	    	    newVal = Math.round(inc/20.475);
	    	    point.update(newVal);
	    	
	    	}, 100);
	    }
	});
});

