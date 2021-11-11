<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*,RE.*"%>
<html>
<head>
<meta charset="utf-8">
</head>
<%
	
	ReservationService reservationService = new ReservationService();
	Reservation reservation = new Reservation();
	
	reservationService.dropTable();
	reservationService.createTable(); // 테이블 생성
%>
<body>
	<h1>데이터 만들기</h1>
<%
	reservationService.insert(); // 제목,내용 insert
%>
</body>
</html>