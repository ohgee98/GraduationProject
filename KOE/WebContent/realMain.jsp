<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE HTML>

<html>
<head>
<title>KOE 코드 유사도 검사 프로그램</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<noscript>
	<link rel="stylesheet" href="assets/css/noscript.css" />
</noscript>
<script src="assets/js/jquery.min.js"></script>
</head>
<body class="is-preload">

	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Header -->
		<header id="header">
			<a class="logo"><strong>KOE</strong> <span>코드 유사도 검사 프로그램</span></a>
		</header>

		<!-- Main -->
		<div id="main" class="alt">

			<!-- One -->
			<section id="one">
				<div class="inner">
					<header class="major">
						<h2>예제 목록</h2>
						<pre>예제는 '프로그래머스' 사이트의 코딩테스트 연습 중 <span><a href="https://programmers.co.kr/learn/challenges" target="_blank">코딩테스트 고득점 Kit</a></span> 문제를 사용하였습니다.
유사도 검사를 위한 데이터는 TISTORY 블로그에서 코드를 수집하였습니다.</pre>
					</header>
					<br />
					<div class="table-wrapper">
						<table id="probTable" style="text-align: center;" hidden>
							<thead>
								<tr>
									<th style="text-align: center;">번호</th>
									<th style="text-align: center;">알고리즘</th>
									<th style="text-align: center;">문제 제목</th>
									<th style="text-align: center;" hidden>링크</th>
									<th style="text-align: center;">언어</th>
								</tr>
							</thead>
							<tbody id="probBody">
							</tbody>
						</table>
					</div>
					<br/>
					
					<form id="probForm" action="./prob/allProb.jsp" method="post">
						<input type="hidden" id="algN" name="algN" value="">
						<input type="hidden" id="probN" name="probN" value="">
						<input type="hidden" id="urlN" name="urlN" value="">
					</form>

				</div>
		</div>

		<!-- Scripts -->
		
		<script>
		
		window.onload = function(){
			probLoad();
		}

		function probLoad() {

			$.ajax({
						type : "POST",
						url : "./prob/getProbData.jsp",
						dataType : "text json",
						success : function(res) {
							var data = "";
							if(res.length==0){
								data+="<tr><td colspan=\"5\">코딩테스트 문제가 존재하지 않습니다.</td></tr>";
								$("#probBody").html(data);
							}
							else{
								for (var i = 0; i < res.length; i++) {
									var temp = res;
	
									data += "<tr><td>"
											+ (i+1)
											+"</td><td>"
											+ temp[i].algName
											+ "</td><td>"
											+ temp[i].probNum
											+ "</td><td hidden>"
											+ temp[i].probURL
											+ "</td><td>"
											+ "Java"
											+ "</td><td>"
											+ "<button onclick=\"goToProb()\">검사하기</button></td></tr>";
											
									$("#probBody").html(data);
	
								}
							}

							$("#probTable").show();
						},
						error : function(request, status, error) {
							alert("find error \n code:" + request.status + "\n"
									+ "message:" + request.responseText + "\n"
									+ "error:" + error);
						}

					});
		}
		
		 function goToProb(){
			 var alg = $(event.target).parent().parent().children().eq(1).text();
			 var prob = $(event.target).parent().parent().children().eq(2).text();
			 var url = $(event.target).parent().parent().children().eq(3).text();
		     
			$("#algN").val(alg);
		    $("#probN").val(prob);
		    $("#urlN").val(url);
		    	
		    $("#probForm").submit();

		 }

	</script>

		<script src="assets/js/jquery.scrolly.min.js"></script>
		<script src="assets/js/jquery.scrollex.min.js"></script>
		<script src="assets/js/browser.min.js"></script>
		<script src="assets/js/breakpoints.min.js"></script>
		<script src="assets/js/util.js"></script>
		<script src="assets/js/main.js"></script>
</body>
</html>