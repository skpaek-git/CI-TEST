<%@page import="java.util.List"%>
<%@page import="RE.ReservationService"%>
<%@page import="RE.Reservation"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html> 
<head>
<title>예약하기</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@900&family=Rowdies:wght@300&display=swap');
</style>
<style>
body {
	background-image: url("./배경화면.jpg");
	background-repeat:no-repeat;
	background-size: cover;
	}
</style>
</head>
<center>
<body>
<h1 style="font-family: 'Noto Serif KR', serif;"> 삭제 </h1>
<%
	request.setCharacterEncoding("utf-8");//인코딩	
	ReservationService reservationService = new ReservationService();

	String resv_date =  request.getParameter("date"); // 예전 거
	int room =  Integer.parseInt(request.getParameter("room")); // 예전 거

	
	reservationService.delete(resv_date, room); 
	reservationService.insertN(resv_date, room); 
%>
<script>
		location.href = 'adm_allview.jsp'; /* 예약현황으로 이동 */
</script>
</body>
</center>
</html>