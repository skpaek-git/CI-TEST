<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*,RE.*"%>

<%	
String loginOK = null; // 초기값은 NULL
loginOK = (String) session.getAttribute("login_ok"); // login_oK 세션 생성하여 담음
%>
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
<%
	request.setCharacterEncoding("utf-8"); // 한글 깨짐방지 utf-8 설정
	ReGongjiService gongjiService = new ReGongjiService();  // 객체 생성
	String sid = (request.getParameter("id")); // id를 받아와 String으로 저장
	gongjiService.updateCount(Integer.parseInt(sid)); // 조회수 + 1
	ReGongji gongji = gongjiService.selectOne(Integer.parseInt(sid));
	
	int id = gongji.getId(); // 번호
	String title = gongji.getTitle(); // 제목 
	String date = gongji.getDate(); // 일자
	String content = gongji.getContent(); // 내용	
	int rootId = gongji.getRootId(); // 원글 번호
	int reLevel = gongji.getReLevel(); // 댓글 수준
	int reCnt = gongji.getReCnt(); // 댓글내 번호
	int view = gongji.getViewCnt(); // 조회수
	String upload = gongji.getUpload(); // 업로드
	String image = gongji.getImage();
%>
</head>
<Script>
	function submitForm(mode) {
		if (mode == "update") {
			fsf.action = "e_02_update.jsp"; 
		} else if(mode == "insertre") {
			fsf.action = "e_02_insertRe.jsp";
		} else if(mode == "delete") {
			fsf.action = "e_02_delete.jsp";
			document.fsf.submit(); // button이므로 submit 해줘야 페이지 넘어감
		}
	}
</Script>
<body link="black" vlink="black">
<h1><p align="center" style="font-family: 'Noto Serif KR', serif;">[<%=title%>]</p></h1>
	<form name="fsf" method="post" action="e_02_update.jsp">
		<table class="table table-bordered" style="width:50%; background-color:#ffffff" border=1 align="center" cellpadding=1 cellspacing=1>
			<tr>
				<td width=150px align="center">번호</td>
				<td><%=id%><input type="hidden" name="id" value="<%=id%>"></td>	
			</tr>	
			<tr>
				<td align="center">제목</td>
				<td><%=title%><input type="hidden" name="title" value="<%=title%>"></td>	
			</tr>	
			<tr>
				<td align="center">일자</td>
				<td><%=date%><input type="hidden" name="date" value="<%=date%>"></td>	
			</tr>	
			<tr>
				<td align="center">조회수</td>
				<td><%=view%><input type="hidden" name="content" value="<%=view%>"></td>	
			</tr>
			
<% 			
			if(image.length() != 0) {
%>			<tr>
			<td align="center">내용</td>
			<td><img src="./upload/<%= image %>" width=400 height=200><br><%=content%><input type="hidden" name="content" value="<%=content%>"></td>
			</tr>
<% 
			} else {
%>			<tr>
			<td align="center">내용</td>
			<td><%=content%><input type="hidden" name="content" value="<%=content%>"></td>
			</tr>	
<%
			}
%>
			<tr>
				<td align="center">원글</td>
				<td><%=rootId%><input type="hidden" name="rootId" value="<%=rootId%>"></td>	
			</tr>
			<tr>
				<td align="center">댓글수준</td>
				<td><%=reLevel%><input type="hidden" name="reLevel" value="<%=reLevel%>"></td>	
			</tr>	
			<tr>
				<td align="center">댓글내 순서</td>
				<td><%=reCnt%><input type="hidden" name="reCnt" value="<%=reCnt%>"></td>	
			</tr>
			<tr>
				<td align="center">파일 업로드</td>
				<td><a href="./upload/<%=upload%>" download><%=upload%></a></td>
			</tr>
			<tr>
				<td align="center">이미지 업로드</td>
				<td><%=image%></a></td>
			</tr>
		</table>
		<table width=50% align="center">
			<tr>
				<td width=50% align="left"><input class="btn btn-default" type="button" onclick="location.href='e_02.jsp'" value="목록"></td> <!-- 게시판목록으로 이동 -->
<%		
		if(loginOK != null) { // loginOK가 NULL이 아니면(관리자일때)
%>
				<td width=50% align="right"><button class="btn btn-default" type="submit" onclick="submitForm('update')">수정</button><button class="btn btn-default" type="submit" onclick="submitForm('delete')">삭제</button><button class="btn btn-default" type="submit" onclick="submitForm('insertre')">댓글</button></td>
<%
		}
%>
			</tr>
		</table>
	</form>
</body>
</html>