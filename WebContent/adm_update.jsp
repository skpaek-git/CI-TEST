<%@page import="java.util.List"%>
<%@page import="RE.ReservationService"%>
<%@page import="RE.Reservation"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html> 
<head>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@900&family=Rowdies:wght@300&display=swap');
</style>
<title>예약하기</title>
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
<center>
<body>

<%
	request.setCharacterEncoding("utf-8");//인코딩	
	ReservationService reservationService = new ReservationService();
	
	String name = request.getParameter("name");
	String resv_date =  request.getParameter("date"); // 예전 거
	String resv_date2 = request.getParameter("date2"); // 수정할 거
	int room =  Integer.parseInt(request.getParameter("room")); // 예전 거
	int room2 = Integer.parseInt(request.getParameter("room2")); // 수정할 거
	String addr =  request.getParameter("addr");
	String telnum =  request.getParameter("telnum");
	String inname =  request.getParameter("inname");
	String comment =  request.getParameter("comment");
	String write_date = request.getParameter("write_date");
	String processing = request.getParameter("processing");
	
	Reservation reservation = new Reservation();
	reservation.setName(name);
	reservation.setResv_date(resv_date2);
	reservation.setRoom(room2);
	reservation.setAddr(addr);
	reservation.setTelnum(telnum);
	reservation.setInname(inname);
	reservation.setComment(comment);
	reservation.setWrite_date(write_date);
	reservation.setProcessing(Integer.parseInt(processing));
	
	if(resv_date.equals(resv_date2) && room == room2) {
%>
<script>
		alert("이미 예약된 방입니다.");
</script>
<%	
	} else {
		reservationService.delete(resv_date, room); // 삭제가 안되고 
		reservationService.insertN(resv_date, room); // 값이 못들어가고
		reservationService.delete(resv_date2, room2); // 삭제가 되는데
		reservationService.insert(reservation);
	}
%>
<script>
		location.href = 'adm_allview.jsp'; /* 예약현황으로 이동 */
</script>
</body>
</center>
</html>