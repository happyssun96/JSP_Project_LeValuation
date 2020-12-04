<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta charset="EUC-KR"><title>404 Error</title>
<link
	href="https://fonts.googleapis.com/css?family=Quicksand:300,400,500,700,900"
	rel="stylesheet">
<link rel="stylesheet" href="./fonts/icomoon/style.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<link rel="stylesheet" href="./css/jquery-ui.css">
<link rel="stylesheet" href="./css/owl.carousel.min.css">
<link rel="stylesheet" href="./css/owl.theme.default.min.css">
<link rel="stylesheet" href="./css/owl.theme.default.min.css">
<link rel="stylesheet" href="./css/jquery.fancybox.min.css">
<link rel="stylesheet" href="./css/bootstrap-datepicker.css">
<link rel="stylesheet" href="./fonts/flaticon/font/flaticon.css">
<link rel="stylesheet" href="./css/aos.css">
<link rel="stylesheet" href="./css/style.css">
<link rel="stylesheet" href="./css/topbutton.css">
</head>
<body>
<jsp:include page="menu.jsp" />
<div class ="jumbotron">
	<div class="container">
		<h2 class="alert alert-danger">해당 페이지가 없습니다.</h2>
	</div>
</div>
<div class="container">
<p><%=request.getRequestURL()%>?<%=request.getQueryString()%>
<p><a href="index.jsp" class="btn btn-secondary">홈으로 돌아가기</a>
</div>

	<%@ include file="footer.jsp"%>

</body>
</html>