<%@page import="RE.AdminService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ page import="java.sql.*, javax.sql.*, java.net.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
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
</style>
</head>
<body>
<center>	
<%
	AdminService adminService = new AdminService();

	String id_db = adminService.selectAll().get(0).getId();  
	String pass_db = adminService.selectAll().get(0).getPass();		
			
	request.setCharacterEncoding("utf-8");

	String jump = request.getParameter("jump"); // 파라미터 jump를 불러와 jump에 저장 
	String id = request.getParameter("id"); // 파라미터 id를 불러와 id에 저장
	String pass = request.getParameter("passwd"); // 파라미터 passwd를 불러와 pass에 저장

	boolean bPassChk = false; // 아무것도 입력하지 않았을 때의 경우를 대비하여 false를 초기값으로 설정
	
	if (id.replaceAll(" ","").equals(id_db) && pass.replaceAll(" ","").equals(pass_db)) {// id가 admin이고 passwd가 admin이면 
		bPassChk = true; //  true
	} else { // 둘중 하나라도 admin이 아니면
		bPassChk = false; // false
	}

	if(bPassChk) { // bPassChk가 ture면
		session.setAttribute("login_ok", "yes"); // yes를 담은 login_ok
		session.setAttribute("login_id", id); // id를 담는 login_id를 보낸다
		response.sendRedirect(jump); // jump로
	} else { // false면
		out.println("<h2>아이디 또는 패스워드 오류</h2>"); // id / passwd 메세지 출력하고
		out.println("<input class='btn btn-default' type='button' value='로그인' Onclick=\"location.href='adm_login.jsp?jump=" + jump + "'\">"); // jump로 넘어가는 로그인 버튼을 만든다
	}
%>
</center>
</body>
</html>