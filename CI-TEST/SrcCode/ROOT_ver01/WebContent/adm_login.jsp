<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ page import="java.sql.*, javax.sql.*, java.net.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<script
   src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<!-- 부트스트랩 -->
<link
   href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
   rel="stylesheet">
<meta charset="UTF-8">
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@900&family=Rowdies:wght@300&display=swap');
</style>
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
<%
	String jump = "adm_allview.jsp"; // adm_login jump 
%>
<center>
<h2 style="font-family: 'Noto Serif KR', serif;">관리자 로그인</h2>
<form method="post" action="adm_loginck.jsp" autocomplete="off"> <!-- adm_loginck.jsp로 post방식으로 보냄 -->
<table border=1 style="background-color:#ffffff; width:300">
	<tr>
		<td class="form-control" align="center" style="width:200">아이디</td>
		<td><input type="text" class="form-control" name="id" size=10></td> <!-- id 입력상자 -->
	</tr>
	<tr>
		<td class="form-control" align="center" style="width:200">비밀번호</td>
		<td ><input type="password" class="form-control" name="passwd" size=10></td> <!-- passwd 입력상자 -->
	</tr>
	<tr>
		<td colspan=2 align="center"><input type="submit" class="form-control" value="로그인"></td> <!-- submit버튼을 통해 입력 값을 보내는데...↑ -->
	</tr>
</table>
<input type="hidden" name="jump" value='<%= jump %>'> <!-- jump값을 넘기기위해 사용 -->
</form>
</center>
</body>
</html>