<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "user.UserDAO" %>
<%@ page import = "evaluation.EvaluationDTO" %>
<%@ page import = "evaluation.EvaluationDAO" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("UTF-8");
	String lectureDivide = "전체";
	String searchType = "최신순";
	String search = "";
	int pageNumber = 0;
	
	if(request.getParameter("lectureDivide") != null) {
		lectureDivide = request.getParameter("lectureDivide");
	}
	
	if(request.getParameter("searchType") != null) {
		searchType = request.getParameter("searchType");
	}
	
	if(request.getParameter("search") != null) {
		search = request.getParameter("search");
	}
	
	if(request.getParameter("pageNumber") != null) {
		try {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));			
		} catch (Exception e) {
			System.out.println("검색 페이지 번호 오류");
		}
	}
	
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
%>
    <nav class="navbar navbar-expand-lg navbar-light" style="background-color: white;">
<div class="col-11 col-xl-2">
            <h1 class="mb-0 site-logo"><a href="index.jsp" class="text-black h2 mb-0">LeValuation<span class="text-primary">.</span>com</a></h1>
          </div>
<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
	<span class="navbar-toggler-icon"></span>
</button>
<div id="navbar" class="collapse navbar-collapse">
	<ul class="navbar-nav mr-auto">
		<li class="nav-item active">
		<a class="nav-link" href="#startpoint">메인</a>
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
	<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
		<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="검색어 입력 " aria-label="Search">
		<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
	</form>
</div>
</nav>