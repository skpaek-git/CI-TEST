<%@page import="java.sql.Date"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*, RE.*"%>
<%@ page import="javax.servlet.*" %>


<html>
<head>
<script
   src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<!-- 부트스트랩 -->
<link
   href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
   rel="stylesheet">
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@900&family=Rowdies:wght@300&display=swap')
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
</style>
<meta charset="utf-8">
<script>
	//유효성 검사
	function check() {
		var blank = /^\s + |\s + $/g; // 공백 체크 정규식
		var noTitle = /^[ㄱ-ㅎ|가-힣|ㅏ-ㅣ|a-z|\s|A-Z|0-9|]*$/; // 한글, 영문, 숫자 체크 정규식

		var title = document.frm.title.value; // name 입력값 얻기
		var content = document.frm.content.value; // content 입력값 얻기
		
		if(title.replace(blank, '') == "") {
		    alert("[에러]제목을 입력하세요");
		    document.frm.title.select();
		    return false;
		}

		if(content.replace(blank, '') == "") {
		    alert("[에러]내용을 입력하세요");
		    document.frm.title.select();
		    return false;
		}

		if(!noTitle.test(title)) {
			alert("[에러]특수문자는 제목에 사용할 수 없습니다");
			document.frm.title.select();
			return false;
		}

		if(title.length > 30) {
			alert("[에러]제목이 너무 깁니다. 30자이내로 작성하세요");
			document.frm.title.select();
			return false;
		}
	}	
</script>

<%
	Date date = new java.sql.Date(System.currentTimeMillis()); // 현재시간 얻기(sql date 타입) ---> '2020-07-14' 형식으로 얻음
%>

</head>
<body link="black" vlink="black">
	<h1><p align="center" style="font-family: 'Noto Serif KR', serif;">이용 후기 작성</p></h1>
	<!-- 번호, 제목, 일자, 내용 출력 -->
	<form name="frm" method="post" action="e_02_write.jsp" onsubmit="return check();" enctype="multipart/form-data">
		<table class="table table-bordered" style="width:50%; background-color:#ffffff" border=1 align="center" cellpadding=1 cellspacing=1>
			<tr>
				<td width=150px align="center">번호</td>
				<td width=600px>신규(insert)<input type="hidden" name="id" value="insert"></td>	
			</tr>	
			<tr>
				<td align="center">제목</td>
				<td><input type="text" name="title" size=90 maxlength=80 style="background-color:transparent;"></td>	
			</tr>	
			<tr>
				<td align="center">일자</td>
				<td><%=date%></td>	
			</tr>	
			<tr>
				<td align="center">내용</td>
				<td><textarea name="content" cols="92" rows="20" style="background-color:transparent;"></textarea></td>	
			</tr>
			<tr>
				<td align="center">파일 업로드</td>
				<td><input type="file" name="file1"></td>	
			</tr>
			<tr>
				<td align="center">이미지</td>
				<td><input type="file" name="image1"></td>	
			</tr>			
		</table>
		<table width=50% align="center">
			<tr>
				<td width=50% align="right"><input class="btn btn-default" type="button" value="취소" onclick="location.href='e_02.jsp'"><button class="btn btn-default" type="submit">쓰기</button></td>
			</tr>
		</table>
	</form>
</body>
</html>