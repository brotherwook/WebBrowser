<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
	</head>
	<body>
		<div class="container-fluid bg-dark vh-100">
			<div class="row" style="height:5%">
				<div class="col bg-danger" style="height:100%">hello</div>
				<div class="col bg-success" style="height:100%">hello</div>
				<div class="col bg-info" style="height:100%">hello</div>
			</div>
			<div class="row" style="height:95%">
				<div class="col bg-light" style="height:100%">hello</div>
				<div class="col bg-light" style="height:100%">hello</div>
				<div class="col bg-light" style="height:100%">hello</div>
			</div>
			<div class="row" style="height:100%">
				<div class="col bg-danger" style="height:100%">hello</div>
				<div class="col bg-success" style="height:100%">hello</div>
				<div class="col bg-info" style="height:100%">hello</div>
			</div>
		</div>
	</body>
</html>