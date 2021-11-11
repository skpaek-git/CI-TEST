<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ page import="java.sql.*, javax.sql.*, java.net.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@900&family=Rowdies:wght@300&display=swap');
</style>
<script
   src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<!-- 부트스트랩 -->
<link
   href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
   rel="stylesheet">
<style>
body {
	background-image: url("./배경화면.jpg");
	background-repeat:no-repeat;
	background-size: cover;
	}
table { 
	border-collapse: collapse; 
	}
	td { border : 0px solid #444444;
	}
</style>
</head>
<body>
<center>
<%	
	String loginOK = null; // 초기값은 NULL
	String jumpURL = "adm_login.jsp?jump=adm_login.jsp"; // 자기자신의 URL
	loginOK = (String) session.getAttribute("login_ok"); // login_oK 세션 생성하여 담음

	if(loginOK == null) { // loginOK가 NULL이면
		response.sendRedirect(jumpURL); // jumpURL로 보낸다
		return; // 리턴
	}
	if(!loginOK.equals("yes")) { // loginOK가 yes가 아니면
		response.sendRedirect(jumpURL); // jumpURL로 보낸다
		return; // 리턴
	}

	session.invalidate(); // 세션을 종료
	out.println("<h2>로그아웃 되었습니다.</h2>"); // 상태 메세지 출력
	out.println("<input class='btn btn-default' type='button' value='메인 페이지' Onclick=\"location.href='main.jsp'\">"); // 로그인(메인페이지)로 이동하는 버튼을 생성
%>
</center>
</body>
</html>