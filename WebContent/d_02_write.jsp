<%@page import="java.util.List"%>
<%@page import="RE.ReservationService"%>
<%@page import="RE.Reservation"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html> 
<head>
<title>예약하기</title>
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
<h1> 예약 </h1>
<%
	request.setCharacterEncoding("utf-8");//인코딩	
	ReservationService reservationService = new ReservationService();
	
	String name = request.getParameter("name");
	String resv_date =  request.getParameter("date");
	int room =  Integer.parseInt(request.getParameter("room"));
	String addr =  request.getParameter("addr");
	String telnum =  request.getParameter("telnum");
	String inname =  request.getParameter("inname");
	String comment =  request.getParameter("comment");
	
	
	
	Reservation reservation = new Reservation();
	reservation.setName(name);
	reservation.setResv_date(resv_date);
	reservation.setRoom(room);
	reservation.setAddr(addr);
	reservation.setTelnum(telnum);
	reservation.setInname(inname);
	reservation.setComment(comment);
	
	reservationService.update(reservation);
%>
<script>
		location.href = 'd_01.jsp'; /* 예약현황으로 이동 */
</script>
</body>
</center>
</html>