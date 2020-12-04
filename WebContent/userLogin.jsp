<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page errorPage ="404error.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta charset="EUC-KR">
<title>Login</title>
<link href="https://fonts.googleapis.com/css?family=Quicksand:300,400,500,700,900" rel="stylesheet">
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
</head>
<body>
<fmt:setLocale value='<%=request.getParameter("language")%>'/>
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태입니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
%>
<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #03e2cf;">
<a class="navbar-brand" href="index.jsp">Welcome To LeValuation.com</a>
<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
	<span class="navbar-toggler-icon"></span>
</button>
<div id="navbar" class="collapse navbar-collapse">
	<ul class="navbar-nav mr-auto">
		<li class="nav-item active">
		<a class="nav-link" href="index.jsp">메인</a>
	</li>
	<li class="nav-item dropdown">
	<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
		회원관리
	</a>
	<div class="dropdown-menu" aria-labelledby="dropdown">
<%
	if(userID == null) {
%> 
		<a class="dropdown-item" href="userLogin.jsp">로그인</a>
		<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
<%
	} else {
		
%>
		<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
	}
%>
	</div>
	</li>
	</ul>
</div>
</nav>
<section class="container mt-3" style="max-width : 560px;">
	<form method="post" action="./userLoginAction.jsp">
		<div class="form-group">
		<fmt:setBundle basename="bundle.message" />
		<a href="?language=ko">Korean</a> |
		<a href="?language=en">English</a> <br>
			<label><fmt:message key="userID" /></label>
			<input type="text" name="userID" class="form-control">
		</div>
		<div class="form-group">
			<label><fmt:message key="userPassword" /></label>
			<input type="password" name="userPassword" class="form-control">
		</div>
		<input name="loginButton" value="<fmt:message key="loginButton" />" type="submit" class="btn btn-primary">
	</form>
</section>

<%@ include file="footer.jsp" %>

<script src="./js/jquery-3.3.1.min.js"></script>
  <script src="./js/jquery-migrate-3.0.1.min.js"></script>
  <script src="./js/jquery-ui.js"></script>
  <script src="./js/popper.min.js"></script>
  <script src="./js/bootstrap.min.js"></script>
  <script src="./js/owl.carousel.min.js"></script>
  <script src="./js/jquery.stellar.min.js"></script>
  <script src="./js/jquery.countdown.min.js"></script>
  <script src="./js/bootstrap-datepicker.min.js"></script>
  <script src="./js/jquery.easing.1.3.js"></script>
  <script src="./js/aos.js"></script>
  <script src="./js/jquery.fancybox.min.js"></script>
  <script src="./js/jquery.sticky.js"></script>
  <script src="./js/typed.js"></script>
            <script>
            var typed = new Typed('.typed-words', {
            strings: ["Web Apps"," WordPress"," Mobile Apps"],
            typeSpeed: 80,
            backSpeed: 80,
            backDelay: 4000,
            startDelay: 1000,
            loop: true,
            showCursor: true
            });
            </script>
  <script src="./js/main.js"></script>
</body>
</html>