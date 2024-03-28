<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.text.SimpleDateFormat, java.util.*, java.util.Calendar.*"%>
<%@ page import="RE.*"%>
<html> 
<head>
<title>예약하기</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@900&family=Rowdies:wght@300&display=swap')
</style>
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
      $("#submit").click(function(event){//add가 클릭했을 때
         var name   = $("#name").val();//name은 #name의 값
         var nameLen    = name.length;
         var pattern_spc = /[가-힣a-zA-Z]/; // 특수문자
         if(nameLen < 1){//글자수가 0이면(비어있다면)
            $("#errMsg_01").show();
            $("#errMsg_01").text(" 비어 있음"); //출력
            event.preventDefault();
         } else if(nameLen == 1){//글자수가 1글자면
             $("#errMsg_01").show();
             $("#errMsg_01").text(" 잘못된 이름"); //출력
             event.preventDefault();
         } else if (!pattern_spc.test(name)) {
            $("#errMsg_01").show();
            $("#errMsg_01").text(" 특수문자 오류"); //출력
            event.preventDefault();
            } else {//아니면
            $("#errMsg_01").hide();//숨김
         }


         var inname   = $("#inname").val();//name은 #inname의 값
         var innameLen    = inname.length;
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
         
         var tel   = $("#tel").val();//tel은 #telnum의 값
         var telLen    = tel.length;
         if(telLen < 1){//글자수가 0이면
            $("#errMsg_03").show();
            $("#errMsg_03").text(" 비어 있음"); //출력
            event.preventDefault();
         } else if (!/01[016789]-[0-9]{1}[0-9]{2,3}-[0-9]{4}$/.test(tel)) { // 휴대전화 정규표현식
            $("#errMsg_03").show();
            $("#errMsg_03").text(" 잘못된 입력"); //출력
            event.preventDefault();
            } else {//아니면
            $("#errMsg_03").hide();//숨김
         }
         
         var addr   = $("#addr").val();//addr은 #addr의 값
         var addrLen    = addr.length;
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
         
         var date   = $("#date").val();//date은 #date의 값
         var dateLen    = date.length;
         if(dateLen < 1){//글자수가 0이면
            $("#errMsg_05").show();
            $("#errMsg_05").text(" 비어 있음"); //출력
            event.preventDefault();
            } else {//아니면
            $("#errMsg_05").hide();//숨김
         }
      });
   });
</script>
</head>
<center>
<body>
<%
request.setCharacterEncoding("utf-8");//인코딩	
String resv_date = request.getParameter("date");
String sRoom = request.getParameter("room");
int room = 0;
if (sRoom != null) {
	room = Integer.parseInt(sRoom);
}
%>
<h2 style="font-family: 'Noto Serif KR', serif;"> 예약 하기 </h2>
<form method="post" action="d_02_write.jsp" autocomplete="off">
<table class="table table-bordered" style="width:500px; background-color:#ffffff" border=1 align="center" cellpadding=1 cellspacing=1>
	<tr>
		<td width=200 align=center><b>성명</b></td>
		<td width=400><input type="text" placeholder="이름" name="name" id="name"><span class="error" id="errMsg_01" style="font-size: 1em"></span></td>
	</tr>
	<tr>
		<td width=200 align=center><b>예약일자</b></td>
		<td width=400>
<%
			if (resv_date != null) {
%> 
				<input type="text" value=<%= resv_date%> name="date" readonly>
<%
			} else {
%> 				<input type="date" placeholder="예약일자" name="date" id="date"><span class="error" id="errMsg_05" style="font-size: 1em"></span> 
<%
			}
%>
		</td>
	</tr>
	<tr>
		<td width=100 align=center><b>예약방</b></td>
		<td width=500>
<%
			if (sRoom != null) {
				if (room == 1) {
%>
					VIP룸<input type=hidden name="room" value=1> <%
				} else if (room == 2) {
 %>
 					일반룸<input type=hidden name="room" value=2> <%
				} else if (room == 3) {
 %>
 					합리적인룸<input type=hidden name="room" value=3> <%
				}
 			} else {
 %> 
				<select name="room" class="form-control">
					<option value="1">VIP 룸</option>
					<option value="2">일반 룸</option>
					<option value="3">합리적인 룸</option>
				</select>
<%
			}
 %>
	</tr>
	<tr>
		<td width=200 align=center><b>주소</b></td>
		<td width=400><input type="text" placeholder="주소" name="addr" id="addr"><span class="error" id="errMsg_04" style="font-size: 1em"></td>
	</tr>
	<tr>
		<td width=200 align=center><b>전화번호</b></td>
		<td width=400><input type="text" placeholder="01X-XXXX-XXXX" name="telnum" id="tel"><span class="error" id="errMsg_03" style="font-size: 1em"></span></td>
	</tr>
	<tr>
		<td width=200 align=center><b>입금자명</b></td>
		<td width=400><input type="text" placeholder="입금자 명" name="inname" id="inname"><span class="error" id="errMsg_02" style="font-size: 1em"></span></td>
	</tr>
	<tr>
		<td width=200 align=center><b>남기실 말</b></td>
		<td width=400><input type="text" placeholder="남기실 말" name="comment"></td>
	</tr>
	<tr>
		<td colspan=2 width=700 align=right><button class="btn btn-default" type= "submit" id="submit">예약</button></td>
	</tr>
</table>
</form>
</body>
 </center>
</html>