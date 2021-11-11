<%@page import="java.sql.Date"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*,RE.*"%>
<%@ page import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*" %>

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
	request.setCharacterEncoding("utf-8"); // 한글 깨짐방지
	
	ReGongjiService gongjiService = new ReGongjiService();
	Date date = new java.sql.Date(System.currentTimeMillis()); // // 현재시간 얻기(sql date 타입) 'yyyy-MM-dd' 형식으로 얻음
	
	int rootId = Integer.parseInt(request.getParameter("rootId")); // 원글 번호
	int reLevel = Integer.parseInt(request.getParameter("reLevel")); // 댓글 수준 받기
	int reCnt = Integer.parseInt(request.getParameter("reCnt")); // 댓글 내 순서 받기 
	reCnt = gongjiService.selectReSort(rootId, reCnt, reLevel);
	// int reCnt = gongjiService.getReCnt(rootId, reLevel + 1);
%>

</head>
<body link="black" vlink="black">
<h1><p align="center" style="font-family: 'Noto Serif KR', serif;">댓글 입력</p></h1>
	<!-- 번호, 제목, 일자, 내용 출력 -->
	<form name="frm" method="post" action="e_02_write.jsp" onsubmit="return check();" enctype="multipart/form-data">
		<table class="table table-bordered" style="width:50%; background-color:#ffffff" border=1 align="center" cellpadding=1 cellspacing=1>
			<tr>
				<td align=center>번호</td>
				<td>댓글(insert)<input type="hidden" name="id" value="reinsert"></td>	
			</tr>	
			<tr>
				<td align=center>제목</td>
				<td><input type="text" name="title" size=90	 maxlength=90 style="background-color:transparent;"></td>	
			</tr>	
			<tr>
				<td align=center>일자</td>
				<td><%=date%></td>	
			</tr>	
			<tr>
				<td align=center>내용</td>
				<td><textarea name="content" cols="92" rows="20" style="background-color:transparent;"></textarea></td>	
			</tr>		
			<tr>
				<td align=center>원글</td>
				<td><%=rootId%><input type="hidden" name="rootId" value="<%=rootId%>"></td>	
			</tr>
			<tr>
				<td align=center>댓글수준</td>
				<td><%=reLevel + 1%><input type="hidden" name="reLevel" value="<%=reLevel + 1%>"></td>
			</tr>	
			<tr>
				<td align=center>댓글내 순서</td>
				<td><%=reCnt%><input type="hidden" name="reCnt" value="<%=reCnt%>"></td>	
			</tr>
		</table>
		<table width=50% align=center>
			<tr>
				<td width=50% align="right"><input class="btn btn-default" type="button" value="취소" onclick="location.href='e_02.jsp'"><button align="right" class="btn btn-default" type="submit">쓰기</button></td>
				
			</tr>
		</table>
	</form>
</body>
</html>