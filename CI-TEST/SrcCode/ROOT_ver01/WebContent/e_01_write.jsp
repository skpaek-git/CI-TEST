<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> <!-- html에서 한글처리 -->
<%@page contentType="text/html; charset=utf-8" %>  <!-- jsp에서 한글처리 -->
<%@page import="com.oreilly.servlet.multipart.*" %>
<%@page import="com.oreilly.servlet.*" %>
<%@page import="java.io.*, java.util.*, RE.*"%> <!--JAVA import -->

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
	GongjiService gongjiService = new GongjiService(); 
	Gongji gongji_newNo = new Gongji(); // 새 글 객체
	
	MultipartRequest multi = null;
	String uploadPath = application.getRealPath("/upload");
	
	String fileName = "";
	String imageName = "";
	String fileName2 = "";
	String imageName2 = "";
	String sid = (request.getParameter("id")); // id를 받아와서 String으로 저장
	
		
		multi = new MultipartRequest(request, uploadPath, 5 * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());
		fileName = multi.getFilesystemName("file1");
		imageName = multi.getFilesystemName("image1");
		fileName2 = multi.getFilesystemName("file2");
		imageName2 = multi.getFilesystemName("image2");
	
	// 신규 추가/수정처리
		if (multi.getParameter("id").equals("insert")) { // 번호
		gongji_newNo.setTitle(multi.getParameter("title")); // 제목
		gongji_newNo.setContent(multi.getParameter("content")); // 내용
		gongji_newNo.setUpload(fileName); // 파일
		gongji_newNo.setImage(imageName); // 이미지파일
		gongjiService.insert(gongji_newNo); // 작성
		} else { // 업데이트일 경우
		gongji_newNo.setId(Integer.parseInt(multi.getParameter("id"))); // id 받기
		gongji_newNo.setTitle(multi.getParameter("title")); // 제목 받기
		gongji_newNo.setContent(multi.getParameter("content")); // 내용 받기
		gongji_newNo.setUpload(fileName2);
		gongji_newNo.setImage(imageName2);
		gongjiService.update(gongji_newNo); // 새 글 업데이트
		}
	 
	List<Gongji> gongjiList = gongjiService.selectAll(); // 전체 공지 리스트 얻기
	
%>
</head>

<script>
	location.href="e_01.jsp";
</script>
<body link="black" vlink="black">
<% 
%>
<h1><p align="center">작성 완료</p></h1>
	<table width=720px border=1 align="center">
		<tr>
			<th width=50px>번호</th><th>제목</th><th width=100px>등록일</th><th width=50px>조회수</th>
		</tr>
<%
		for(Gongji gongji: gongjiList) { // gongiList 출력
			int id = gongji.getId();
			String title = gongji.getTitle();
			String date = gongji.getDate();
			int view = gongji.getViewCnt();
%>				
		<tr>
			<td align="center"><%=id%></td>
			<td><%=title%></td>
			<td align="center"><%=date%></td>
			<td align="center"><%=view%></td>
		</tr>					
<% 				
		}
%>
	</table>
	<table width=720px align="center">
		<tr>
			<td width=720px align="right"><input type="button" value="목록" onclick="location.href='e_01.jsp'"></td> <!-- 게시판목록으로 이동 -->
		</tr>
	</table>
</body>
</html>
