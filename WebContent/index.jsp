<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page errorPage ="404error.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta charset="EUC-KR">
<title>강의평가 웹 사이트</title>
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
<body data-spy="scroll" data-target=".site-navbar-target"
	data-offset="300">
	<div class="site-mobile-menu site-navbar-target">
		<div class="site-mobile-menu-header">
			<div class="site-mobile-menu-close mt-3">
				<span class="icon-close2 js-menu-toggle"></span>
			</div>
		</div>
		<div class="site-mobile-menu-body"></div>
	</div>
	<div class="border-bottom top-bar py-2 bg-dark" id="home-section">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<p class="mb-0">
						<span class="mr-3"><strong class="text-white">Phone:</strong>
							<a href="tel://#">91557004</a></span> <span><strong
							class="text-white">Email:</strong> <a href="#">lsw96@naver.com</a></span>
					</p>
				</div>
				<div class="col-md-6">
					<ul class="social-media">
						<li><a href="#" class="p-2"><span class="icon-facebook"></span></a></li>
						<li><a href="#" class="p-2"><span class="icon-twitter"></span></a></li>
						<li><a href="#" class="p-2"><span class="icon-instagram"></span></a></li>
						<li><a href="#" class="p-2"><span class="icon-linkedin"></span></a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
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
    <jsp:include page="menu.jsp" />

	<div class="site-blocks-cover overlay"
		style="background-image: url(./images/hero_1.jpg);" data-aos="fade"
		data-stellar-background-ratio="0.5">
		<div class="container">
			<div
				class="row align-items-center justify-content-center text-center">
				<div class="col-md-12" data-aos="fade-up" data-aos-delay="400">
					<div class="row justify-content-center mb-4">
						<div class="col-md-8 text-center">
							<h1>
								Welcome To LeValuation<span class="text-primary">.</span>com with :<span class="typed-words">)</span>
							</h1>
							<p class="lead mb-5">
								수강신청에&nbsp;<a href="#" target="_blank">도움</a>을 주세요!
							</p>
							<div>
								<a href="#startpoint" class="btn btn-primary btn-md">시작하기</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<section class="container" id="startpoint">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="lectureDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="전공"
					<%if (lectureDivide.equals("전공"))
	out.println("selected");%>>전공</option>
				<option value="교양"
					<%if (lectureDivide.equals("교양"))
	out.println("selected");%>>교양</option>
				<option value="기타"
					<%if (lectureDivide.equals("기타"))
	out.println("selected");%>>기타</option>
			</select> <select name="searchType" class="form-control mx-1 mt-2">
				<option value="최신순">최신순</option>
				<option value="추천순"
					<%if (searchType.equals("추천순"))
	out.println("selected");%>>추천순</option>
			</select> <input type="text" name="search" class="form-control mx-1 mt-2"
				placeholder="내용을 입력하세요">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal"
				href="#registerModal">등록하기</a> <a class="btn btn-danger mx-1 mt-2"
				data-toggle="modal" href="#reportModal">신고</a>
		</form>
		<%
		ArrayList<EvaluationDTO> evaluationList = new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);
		if (evaluationList != null)
			for (int i = 0; i < evaluationList.size(); i++) {
				
				EvaluationDTO evaluation = evaluationList.get(i);
		%>
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left"><%=evaluation.getLectureName()%>&nbsp;<small><%=evaluation.getProfessorName()%></small>
					</div>
					<div class="col-4 text-right">
						종합 <span style="color: red;"><%=evaluation.getTotalScore()%></span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					<%=evaluation.getEvaluationTitle()%>&nbsp;<small>(<%=evaluation.getLectureYear()%>년
						<%=evaluation.getSemesterDivide()%>)
					</small>
				</h5>
				<p class="card-text"><%=evaluation.getEvaluationContent()%></p>
				<div class="row">
					<div class="col-9 text-left">
						성적<span style="color: red;"><%=evaluation.getCreditScore()%></span>
						널럴<span style="color: red;"><%=evaluation.getComfortableScore()%></span>
						강의<span style="color: red;"><%=evaluation.getLectureScore()%></span>
						<span style="color: green;">(추천 : <%=evaluation.getLikeCount()%>)
						</span>
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('추천하시겠습니까?')"
							href="./likeAction.jsp?evaluationID=<%=evaluation.getEvaluationID()%>">추천</a>
						<a onclick="return confirm('삭제하시겠습니까?')"
							href="./deleteAction.jsp?evaluationID=<%=evaluation.getEvaluationID()%>">삭제</a>
					</div>
				</div>
			</div>
		</div>
		<%
			}
		%>
	</section>

	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog"
		aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">평가 등록</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./evaluationRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>강의명</label> <input type="text" name="lectureName"
									class="form-control" maxlength="20">
							</div>
							<div class="form-group col-sm-6">
								<label>교수명</label> <input type="text" name="professorName"
									class="form-control" maxlength="20">
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>수강 연도</label> <select name="lectureYear"
									class="form-control">
									<option value="2011">2011</option>
									<option value="2012">2012</option>
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020" selected>2020</option>
									<option value="2021">2021</option>
									<option value="2022">2022</option>
									<option value="2023">2023</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>수강 학기</label> <select name="semesterDivide"
									class="form-control">
									<option value="1학기" selected>1학기</option>
									<option value="여름학기">여름학기</option>
									<option value="2학기">2학기</option>
									<option value="겨울학기">겨울학기</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>강의 구분</label> <select name="lectureDivide"
									class="form-control">
									<option value="전공" selected>전공</option>
									<option value="교양">교양</option>
									<option value="기타">기타</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label>제목</label> <input type="text" name="evaluationTitle"
								class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="evaluationContent" class="form-control"
								maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
								<label>종합</label> <select name="totalScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>성적</label> <select name="creditScore"
									class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>널럴</label> <select name="comfortableScore"
									class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>강의</label> <select name="lectureScore"
									class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">등록하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog"
		aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">신고하기</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method="post">

						<div class="form-group">
							<label>신고 제목</label> <input type="text" name="reportTitle"
								class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>신고 내용</label>
							<textarea name="reportContent" class="form-control"
								maxlength="2048" style="height: 180px;"></textarea>
						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-danger">신고하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<a id="MOVE_TOP_BTN" href="#">TOP</a>

	<%@ include file="footer.jsp"%>

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
	<script src="./js/topbutton.js"></script>
	<script>
		var typed = new Typed('.typed-words', {
			strings : [ "Web Apps", " WordPress", " Mobile Apps" ],
			typeSpeed : 80,
			backSpeed : 80,
			backDelay : 4000,
			startDelay : 1000,
			loop : true,
			showCursor : true
		});
	</script>
	<script src="./js/main.js"></script>
</body>
</html>