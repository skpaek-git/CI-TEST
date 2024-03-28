<%@page import="com.sun.corba.se.impl.ior.WireObjectKeyTemplate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.text.SimpleDateFormat, java.util.*, java.util.Calendar.*"%>
<%@ page import="RE.*"%>
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
	table { border-collapse: collapse; 
	}
	td { border : 0px solid #444444;
	}
	th {
	background-color: #bbdefb;
	}
body {
	background-image: url("./배경화면.jpg");
	background-repeat:no-repeat;
	background-size: cover;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script type="text/javascript">
   $(document).ready(function(){
      $(".error").hide();//기본적으로 error클래스는 숨긴다
      $("#submit").click( function(event){//add가 클릭했을 때
        var name = $("#name").val();//name은 #name의 값
        var nameLen = name.length;
        var pattern_spc = /[가-힣a-zA-Z]/; // 특수문자
        var pattern_spc2 = /[1-4]{1}/; // 특수문자
        if(nameLen < 1){//글자수가 0이면
            $("#errMsg_01").show();
            $("#errMsg_01").text(" 비어 있음"); //출력
            event.preventDefault();
        } else if(nameLen == 1){//글자수가 1또는 2이면
            $("#errMsg_01").show();
            $("#errMsg_01").text(" 이름 오류"); //출력
            event.preventDefault();
        } else if (!pattern_spc.test(name)) {
            $("#errMsg_01").show();
            $("#errMsg_01").text(" 잘못된 이름"); //출력
            event.preventDefault();
		} else {//아니면
            $("#errMsg_01").hide();//숨김
        }


         var inname = $("#inname").val();//name은 #name의 값
         var innameLen = inname.length;
         if(innameLen < 1){//글자수가 0이면
            $("#errMsg_02").show();
            $("#errMsg_02").text(" 비어 있음"); //출력
            event.preventDefault();
         } else if (!pattern_spc.test(inname)) {
            $("#errMsg_02").show();
            $("#errMsg_02").text(" 잘못된 이름"); //출력
            event.preventDefault();
            } else {//아니면
            $("#errMsg_02").hide();//숨김
         }
         
         var tel = $("#tel").val();//name은 #name의 값
         var telLen = tel.length;
         if(telLen < 1){//글자수가 0이면
            $("#errMsg_03").show();
            $("#errMsg_03").text(" 비어 있음"); //출력
            event.preventDefault();
         } else if (!/01[01689]-[1-9]{1}[0-9]{2,3}-[0-9]{4}$/.test(tel)) {
            $("#errMsg_03").show();
            $("#errMsg_03").text(" 잘못된 입력"); //출력
            event.preventDefault();
            } else {//아니면
            $("#errMsg_03").hide();//숨김
         }
         
         var addr = $("#addr").val();//name은 #name의 값
         var addrLen = addr.length;
         if(addrLen < 1){//글자수가 0이면
            $("#errMsg_04").show();
            $("#errMsg_04").text(" 비어 있음"); //출력
            event.preventDefault();
         } else if (!pattern_spc.test(addr)) {
            $("#errMsg_04").show();
            $("#errMsg_04").text(" 잘못된 입력"); //출력
            event.preventDefault();
            } else {//아니면
            $("#errMsg_04").hide();//숨김
         }
         
         var date2 = $("#date2").val();//name은 #name의 값
         var date2Len = date2.length;
         if(date2Len < 1){//글자수가 0이면
            $("#errMsg_05").show();
            $("#errMsg_05").text(" 비어 있음"); //출력
            event.preventDefault();
            } else {//아니면
            $("#errMsg_05").hide();//숨김
         }

         var processing = $("#processing").val();//name은 #name의 값
         var processingLen = processing.length;
         if(processingLen < 1){//글자수가 0이면
            $("#errMsg_06").show();
            $("#errMsg_06").text(" 비어 있음"); //출력
            event.preventDefault();
            } else if (!pattern_spc2.test(processing)) {
            $("#errMsg_06").show();
            $("#errMsg_06").text(" 잘못된 입력"); //출력
            event.preventDefault();
            } else { //아니면
            $("#errMsg_06").hide();//숨김
         }
      });
   });
</script>

<Script>
	function submitForm(mode) {
		if (mode == "update") {
			fsf.action = "adm_update.jsp"; 
		} else if (mode == "delete") {
			fsf.action = "adm_delete.jsp";
		}
		fsf.submit();
	}
</Script>
</head>
<center>
<body>
<%
	request.setCharacterEncoding("utf-8");//인코딩
	ReservationService reservationService = new ReservationService();
	String resv_date = request.getParameter("date");
	String sRoom = request.getParameter("room");
	int room = 0;
	if (sRoom != null) {
		room = Integer.parseInt(sRoom);
	}

	Date date = new java.sql.Date(System.currentTimeMillis()); // 현재시간 얻기(sql date 타입) ---> '2020-07-14' 형식으로 얻음

	
	String write_date = reservationService.selectReservation(resv_date, room).get(0).getWrite_date();
	if( write_date == null ) {
		write_date = date.toString();
	}
	
	String name = reservationService.selectReservation(resv_date, room).get(0).getName();
	if (name == null) {
		name = "";
	}
	String addr = reservationService.selectReservation(resv_date, room).get(0).getAddr();
	if(addr == null) {
		addr = "";
	}
	String telnum = reservationService.selectReservation(resv_date, room).get(0).getTelnum();	
	if(telnum == null) {
		telnum = "";
	}
	String inname = reservationService.selectReservation(resv_date, room).get(0).getInname();
	if(inname == null) {
		inname = "";
	}
	String comment = reservationService.selectReservation(resv_date, room).get(0).getComment();
		if(comment == null) {
		comment = "";
	}
%>
<h2 style="font-family: 'Noto Serif KR', serif;"> 예약 수정 </h2>
<form method="post" autocomplete="off" name=fsf>
<table class="table table-bordered" style="width:35%; background-color:#ffffff" border=1 align="center" cellpadding=1 cellspacing=1>
	<tr>
		<td align=center><b>성명</b></td>
		<td align=left><input type="text" placeholder="이름" name="name" id="name" value='<%= name %>' size=44 style="background-color:transparent;"><span class="error" id="errMsg_01" style="font-size: 1em"></span></td>
	</tr>
	<tr>
		<td align=center><b>예약일자</b></td>
		<td align=left>
<%
			if (resv_date != null) {
%> 
				<input type="text" style="background-color:transparent;" value=<%= resv_date%> name="date" id="date" readonly> → <input type="date" style="background-color:transparent;" name="date2" id="date2"><span class="error" id="errMsg_05" style="font-size: 1em"></span> 
		</td>
	</tr>
	<tr>
		<td align=center><b>예약방</b></td>
		<td align=left>
<%
			if (sRoom != null) {
				if (room == 1) {
%>
					VIP룸<input type=hidden name="room" id="room" value=1> → 
					<select id="room2" name="room2" style="background-color:transparent;">
						<option value="1">VIP 룸</option>
						<option value="2">일반 룸</option>
						<option value="3">합리적인 룸</option>
					</select>
<%
				} else if (room == 2) {
 %>
 					일반룸<input type=hidden name="room" id="room" value=2> → 
 					<select id="room2" name="room2" style="background-color:transparent;">
						<option value="1">VIP 룸</option>
						<option value="2">일반 룸</option>
						<option value="3">합리적인 룸</option>
					</select> 
<%
				} else if (room == 3) {
 %>
 					합리적인룸<input type=hidden id="room" name="room" value=3> → 
 					<select id="room2" name="room2" style="background-color:transparent;">
						<option value="1">VIP 룸</option>
						<option value="2">일반 룸</option>
						<option value="3">합리적인 룸</option>
					</select>
<%
				}
 			} 
		}
 %>
	</tr>
	<tr>
		<td align=center><b>주소</b></td>
		<td align=left><input type="text" placeholder="주소" size=44 name="addr" id="addr" value='<%= addr %>' style="background-color:transparent;"><span class="error" id="errMsg_04" style="font-size: 1em"></td>
	</tr>
	<tr>
		<td align=center><b>전화번호</b></td>
		<td align=left><input type="text" placeholder="01X-XXXX-XXXX" size=44 name="telnum" id="tel" value='<%= telnum %>' style="background-color:transparent;"><span class="error" id="errMsg_03" style="font-size: 1em"></span></td>
	</tr>
	<tr>
		<td align=center><b>입금자명</b></td>
		<td align=left><input type="text" placeholder="입금자 명" size=44 name="inname" id="inname" value='<%= inname %>' style="background-color:transparent;"><span class="error" id="errMsg_02" style="font-size: 1em"></span></td>
	</tr>
	<tr>
		<td align=center><b>남기실 말</b></td>
		<td align=left><input type="text" placeholder="남기실 말" size=44 name="comment" value='<%= comment %>' style="background-color:transparent;"></td>
	</tr>
	<tr>
		<td align=center><b>신청 일자</b></td>
		<td align=left><input type="text" placeholder="신청 일자" size=44 name="write_date" value='<%= write_date %>' style="background-color:transparent;"></td>
	</tr>
	<tr>
		<td align=center><b>진행 상황</b></td>
		<td align=left><input type="text" placeholder="1.예약완료 2.입금완료 3.환불요청 4.환불승인" size=44 name="processing" id="processing" style="background-color:transparent;"><span class="error" id="errMsg_06" style="font-size: 1em"></span></td>
	</tr>
	<tr>
		<td align=center><input class="btn btn-default" type="button" value="관리자 페이지" Onclick="location.href='adm_allview.jsp'"></td>
		<td align=right><button class="btn btn-default" type="submit" id="submit" OnClick="submitForm('update')">수정</button>
		<button class="btn btn-default" type="submit" id="submit" OnClick="submitForm('delete')">삭제</button></td>
	</tr>
</table>
</form>
</body>
 </center>
</html>