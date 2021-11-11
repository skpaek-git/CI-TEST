<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> <!-- html에서 한글처리 -->
<%@page contentType="text/html; charset=utf-8" %>  <!-- jsp에서 한글처리 -->
<%@page import="com.oreilly.servlet.multipart.*" %>
<%@page import="com.oreilly.servlet.*" %>
<%@page import="java.io.*, java.util.*, RE.*"%> <!--JAVA import -->
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
	
	// submit 함수 정의 다중 form이용위함
	function submitForm(mode) {
		if (mode == "write")
			fsf.action = "e_01_write.jsp"; 
			fsf.enctype = "multipart/form-data";
	}
	// 에러처리 함수 정의
	function check() {
		var noTitle = /^[ㄱ-ㅎ|가-힣|ㅏ-ㅣ|a-z|\s|A-Z|0-9|]*$/; // 한글, 영문, 숫자 체크 정규
		var blank = /^\s+|\s+$/g; // 공백 체크 정규표현식

		var title = document.fsf.title.value; // name 입력값 얻기
		var content = document.fsf.content.value; // content 입력값 얻기
		
		if(title.replace(blank, '') == "") {
		    alert("[에러]제목을 입력하세요 ");
		    return false;
		}
	
		if(!noTitle.test(title)) {
			alert("[에러]제목을 다시 입력하세요");
			document.fsf.title.select();
			return false;
		}

		if(title.length > 30) {
			alert("[에러]제목은 30자 이내로 작성하세요");
			document.fsf.title.select();
			return false;
		}
		
		if(content.replace(blank, '') == "") {
		    alert("[에러]내용을 입력하세요");
		    document.fsf.title.select();
		    return false;
		}
	}	
</script>
<%
	request.setCharacterEncoding("utf-8"); // 한글 깨짐방지 utf-8 설정
	GongjiService gongjiService = new GongjiService(); // gongjiSerive 객체 생성
	String sid = (request.getParameter("id")); // id를 받아와서 String으로 저장
	Gongji gongji = gongjiService.selectOne(Integer.parseInt(sid));
	
	int id = gongji.getId(); // 번호
	String title = gongji.getTitle(); // 제목
	String content = gongji.getContent(); // 내용
	String file = gongji.getUpload();
	String image = gongji.getImage();
	Date date = new java.sql.Date(System.currentTimeMillis()); // 현재시간 얻기(sql date 타입) ---> '2020-07-14' 형식으로 얻음
%>

</head>
<body link="black" vlink="black">
<h1><p align="center" style="font-family: 'Noto Serif KR', serif;">수정</p></h1>
	<form name="fsf" method="post" onsubmit="return check();">
		<table class="table table-bordered" style="width:50%; background-color:#ffffff" border=1 align="center" cellpadding=1 cellspacing=1>
			<tr>
				<td align=center width=150>번호</td>
				<td><input type="text" name="id" size=88 maxlength=90 value="<%=id%>" style="background-color:transparent;" readonly></td>	
			</tr>	
			<tr>
				<td align=center>제목</td>
				<td><input type="text" name="title" size=88 maxlength=90 value="<%=title%>" style="background-color:transparent;"></td>	
			</tr>	
			<tr>
				<td align=center>일자</td>
				<td><%=date %></td>	
			</tr>	
			<tr>
				<td align=center>내용</td>
				<td><textarea name="content" cols="90" rows="20" style="background-color:transparent;"><%=content%></textarea></td>	
			</tr>
			<tr>
				<td align=center>파일 업로드</td>
				<td><input type="file" name="file2"><%=file %></td>	
			</tr>
			<tr>
				<td align=center>이미지 업로드</td>
				<td><input type="file" name="image2"><%=image %></td>	
			</tr>				
		</table>
		<table width=50% align="center">
			<tr>
				<td width=50% align="right"><input class="btn btn-default" type="button" value="취소" onclick="location.href='e_01.jsp'"><button class="btn btn-default" type="submit" onclick="submitForm('write')">쓰기</button></td>
			</tr>
		</table>
	</form>
</body>
</html>