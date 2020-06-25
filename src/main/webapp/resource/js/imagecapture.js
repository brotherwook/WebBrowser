function image_capture() {
	console.log("captured");
	var capture = $("#cameraView2").attr("src");
	console.log(capture);
	console.log("captured");
	$("#capture").attr("src", capture);
}

function modal_open() {
	console.log("opened");
	$.ajax({
		url:"get.do",
		success:function(data){
			$("#show1").attr("src", data.img0);
			$("#show2").attr("src", data.img1);
			$("#show3").attr("src", data.img2);
			$("#show4").attr("src", data.img3);
		}
	});
}

function image_save() {
	console.log("saved");
	
	var idata = $("#capture").attr("src");
	
	$.ajax({
		url:"save.do",
		method: "POST",
		data: {idata:idata},
		success:function(data){
			$("#show1").attr("src", data.img0);
			$("#show2").attr("src", data.img1);
			$("#show3").attr("src", data.img2);
			$("#show4").attr("src", data.img3);
		}
	});
	
	console.log("saved2");
}

// location.reload()