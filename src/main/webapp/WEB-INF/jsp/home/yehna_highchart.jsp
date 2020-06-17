<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/distance.js" type="text/javascript"></script>
		<script src="https://code.highcharts.com/js/themes/dark-unica.js"></script>
		<script src="https://code.highcharts.com/highcharts.js"></script>		
	</head>
	<body>
		<h5 class="alert alert-info">/home/yehna_highchart.jsp</h5>
		
		<figure class="highcharts-figure">
		    <div id="distance"></div>
		    <p class="highcharts-description">
		        Chart showing data updating every second, with old data being removed.
		    </p>
		</figure>
	</body>
</html>