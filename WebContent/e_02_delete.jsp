<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*, RE.*"%>

<html>
<head>
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
<%
	request.setCharacterEncoding("utf-8"); // 한글 안깨지도록 utf-8 설정
	ReGongjiService gongjiService = new ReGongjiService(); 
	gongjiService.delete(Integer.parseInt(request.getParameter("id"))); // 삭제
	List<ReGongji> gongjiList = gongjiService.selectAll(); // 전체 공지 리스트 얻기
%>
</head>

<script>
	location.href="e_02.jsp";
</script>
<body link="black" vlink="black">
<h1><p align="center">삭제</p></h1>
	<table width=720px border=1 align="center" >
		<tr>
			<th width=50px>번호</th><th>제목</th><th width=100px>등록일</th><th width=50px>조회수</th>
		</tr>
<%
	// 리스트 출력
		for(ReGongji gongji: gongjiList) {
	int id = gongji.getId();
	String title = gongji.getTitle();
	String date = gongji.getDate();
	int view = gongji.getViewCnt();
%>				
		<tr>
			<td align="center"><%=id%></td>
			<td align="center"><%=title%></td>
			<td align="center"><%=date%></td>
			<td align="center"><%=view%></td>
		</tr>					
<% 				
		}
%>
	</table>
	<table width=720px align="center">
		<tr>
			<td width=720px align="right"><input type="button" value="목록" onclick="location.href='e_02.jsp'"></td>
		</tr>
	</table>

</body>
</html>