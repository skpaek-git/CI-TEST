<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*,RE.*"%>
<html>
<head>
<meta charset="utf-8">
</head>
<%
	GongjiService gongjiService = new GongjiService(); // gongjiService 객체 생성
	gongjiService.dropTable(); // 테이블 삭제
	gongjiService.createTable(); // 테이블 생성
%>
<body>
	<h1>데이터 만들기</h1>
<%
	for(int i = 1; i < 17; i++) {	
		int id = i; // 번호
		String titlePlusNum = String.valueOf(id); 
		gongjiService.insert("공지 사항" + titlePlusNum, "공지사항" + titlePlusNum + "의 내용"); // 제목,내용 insert		
		// gongjiService.updateRootId(); // 댓글 수준 업데이트
	}
%>
</body>
</html>