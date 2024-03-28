<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*, RE.*"%>

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
	table { border-collapse: collapse; 
	}
	td { border : 0px solid #444444;
	}
	th {
	background-color: #bbdefb;
	text-align: center;
	}
body {
	background-image: url("./배경화면.jpg");
	background-repeat:no-repeat;
	background-size: cover;
	}
</style>
<meta charset="utf-8">
</head>
<body link="black" vlink="black">
<%
	request.setCharacterEncoding("utf-8"); // 한글 안깨지도록 utf-8 설정
	ReGongjiService gongjiService = new ReGongjiService(); 
	
	int count = 10; // 한페이지 내 카운트 수
	if(request.getParameter("count") != null){
		count= Integer.parseInt(request.getParameter("count"));
	}
	int startId = 0; // 각 페이지의 테이블이 시작 레코드 값 초기화
	int endRow = 0; // 각 페이지의 끝 레코드 값 초기화
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) { // pageNum이 null이면
		pageNum = "1"; // 1로 받아온다
	}
	int currentPage = Integer.parseInt(pageNum); // pageNum을 int로 변환한값을 currentPage로 변환
%>
	<table width=720px align="center">
		<tr>
			<td align="center"><h1 style="font-family: 'Noto Serif KR', serif;">이용후기</h1></td>
		</tr>
	</table>
	<table class="table table-striped" style="width:50%" border=1 align="center" cellpadding=1 cellspacing=1>
		<tr>
			<th width=50px>번호</th><th>제목</th><th width=100px>파일 업로드</th><th width=50px>조회수</th><th width=100px>등록일</th>
		</tr>
<%
	startId = (currentPage - 1) * count; /* 현재 페이지 - 1에 1페이지 당 행의 개수를 곱하고 1을 더하면 페이지의 첫 행값*/
	List<ReGongji> gongjiList = gongjiService.selectLimit(startId, count); // 전체 공지 리스트 얻기
		for(ReGongji gongji: gongjiList) {
			int id = gongji.getId();
			String title = gongji.getTitle();
			String date = gongji.getDate();
			int view = gongji.getViewCnt();
			int reLevel = gongji.getReLevel();
			String upload = gongji.getUpload();
			String image = gongji.getImage();
		
			
			StringBuilder sb = new StringBuilder(); 	
			for(int i = 0; i < reLevel; i++) {
				sb.append("-");
			}
			sb.append(">");
			String reMark = sb.toString();
%>				
		<tr>
			<td align="center" style="background-color:#ffffff"><%=id%></td>
<% 				
		if(reLevel == 0) { // 댓글 수준 0이면 그냥 출력
%>			
			<td width=350 style="background-color:#ffffff"><a href="e_02_view.jsp?id=<%=id%>"><%=title%></a></td>
<% 			
		} else { // 아니면 댓굴 수준 만큼 화살표 출력
%>			
			<td width=350 style="background-color:#ffffff"><a href="e_02_view.jsp?id=<%=id%>"><%=reMark%>[댓글]<%=title%>[New!]</a></td>
<% 			
		}
		if(upload.length() != 0) {
%>			<td align="center" style="background-color:#ffffff"><img src ="./upload.png" width=20 height=20></td>
<% 
		} else {
%>			
		<td align="center" style="background-color:#ffffff"><%=upload%></td>
<%		
		}
%>
			<td align="center" style="background-color:#ffffff"><%=view%></td>
			<td align="center" style="background-color:#ffffff"><%=date%></td>
		</tr>					
<% 				
	}
%>
	</table>
	<table width=50% align="center">
		<tr>
<%		
		if(loginOK == null) { // loginOK가 NULL이 아니면(관리자일때)
%>
			<td align="right" width=50%><input class="btn btn-default" type="button" value="신규" onclick="location.href='e_02_insert.jsp'"></td>
<%
		}
%>
		</tr>
	</table>
		
<%
	int totalcnt = gongjiService.countID(); // select all 불러온 사이즈

	if (totalcnt > 0) { // 총 라인수가 0보다 크면
	int pagecount = totalcnt / count + (totalcnt%count==0?0:1); // 총 페이지 수
	int pageblock = 10; // 기호 사이에 들어갈 페이지 개수
	int startPage = ((int) (currentPage / pageblock) - (currentPage % pageblock == 0 ? 1 : 0)) * pageblock + 1; // 시작페이지
	int endPage = startPage + pageblock - 1;  // ◀◀ 사이에 들어갈 페이지중 가장 마지막 페이지
	if (endPage > pagecount) { // endpage가/ 총페이지 보다 크면
        endPage = pagecount;  // 총페이지 저장
    }
	int nPage = startPage - pageblock; // ◀◀에 연결될 페이지 넘버
	if (nPage == -9) { 
        nPage = 1; // 1로 저장
	}
%>
<nav aria-label="Page navigation" align="center">
  <ul class="pagination">
    <li>
      <a href="http://localhost:8088/resort/e_02.jsp?pageNum=1&count=<%=count%>" aria-label="Previous">
        <span aria-hidden="true">◀◀</span>
        </a>
    </li>
    <li><a href="http://localhost:8088/resort/e_02.jsp?pageNum=<%=nPage%>&count=<%=count%>" aria-label="Previous">
    	<span aria-hidden="true">◀</span>
    	</a>
    </li>
    <%         
        for(int i = startPage; i <= endPage; i++) {  /* i페이지에 연결될 url*/
    %>
    <li><a href="http://localhost:8088/resort/e_02.jsp?pageNum=<%=i%>&count=<%=count%>"><%= i %></a></li>
     <%
        }           
        if(endPage < pagecount) {  /* ▶ 에 연결될 페이지 */
    %>
    <li>
      <a href="http://localhost:8088/resort/e_02.jsp?pageNum=<%=startPage+pageblock%>&count=<%=count%>" aria-label="Next">
        <span aria-hidden="true">▶</span>
      </a>
    </li>
    <%      
        }
    %>
    <li>
      <a href="http://localhost:8088/resort/e_02.jsp?pageNum=<%=pagecount%>&count=<%=count%>" aria-label="Next">
        <span aria-hidden="true">▶▶</span>
      </a>
    </li>
  </ul>
</nav>
<%
	}
%>
	<%
	List<ReGongji> gongjis = new ArrayList<>();
		gongjis = gongjiService.selectAll();
	%>
	<form method="post" action="e_02_index.jsp">
	<table align=center width=500>
	<tr>
		<td align=center><select name="field" class="form-control" style="width:100">
			<option style=text-align=center; value="제목">제목</option> 
			<option style=text-align=center; value="내용">내용</option>
			</select>
		</td>
		<td>
		<td><input type="text" class="form-control" size=50 name="text"></td> <!-- 기호 번호는 숫자만 입력가능하도록 처리 -->
		<td><button class="btn btn-default" type="submit" name="search">검색</button></td>
		</tr>
	</table>
</form>
</body>
</html>