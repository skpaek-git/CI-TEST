<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*,RE.*"%>
<%@ page import= "java.text.SimpleDateFormat, java.util.*, java.util.Calendar.*"%>
<%@page import="java.net.URLEncoder"%> 
<%@page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Petit+Formal+Script&family=Song+Myung&display=swap" rel="stylesheet">
<style>
body {
	background-image: url("./배경화면.jpg");
	background-repeat:no-repeat;
	background-size: cover;
}
</style>
</head>
<center>
<body>
<img src="./서울리조트.jpg" border=0 id=mainImage alt="YsjImage" style="width:800px; heigth:600px;">
<script>
	var myImage=document.getElementById("mainImage");
	var imageArray=["./서울리조트.jpg", "./서울리조트2.jpg", "./서울리조트3.jpg", "./서울리조트4.jpg", "./서울리조트5.jpg", "./서울리조트6.jpg"];
	var imageIndex=0;
	
	function changeImage(){
		myImage.setAttribute("src",imageArray[imageIndex]);
		imageIndex++;
		if(imageIndex>=imageArray.length){
			imageIndex=0;
		}
	}
	setInterval(changeImage,2000);
</script>
<br><br>
<span style="font-family: 'Petit Formal Script', cursive; font-size:100">WelCome!! Seoul Resort</span><br>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분 ss초");
	Calendar c = Calendar.getInstance();
%>
<%
Cookie[] cookies = request.getCookies(); // cookies를 받아와 배열에 저장
	if(cookies != null) { // cookies가 null이 아니라면
		for(int i = 0; i < cookies.length; i++)	{ // 배열 cookies의 길이만큼 반복하는 동안
			Cookie thisCookie = cookies[i]; // cookies의 i번째 값을 thisCookie에 담는다
			if ("name".equals(thisCookie.getName())) { // 만약 name과 thisCookie의 이름이 같다면
				out.println("최근 방문일은 (" + URLDecoder.decode(thisCookie.getValue(),"UTF-8") + ") 입니다. <br>"); // 형태로 출력(URLDecoder:  인코딩된 결과를 디코딩 하는 역할)
			}
		}
	} else { // cookies가 null이라면
		out.println("<h3>최근 방문일은 (" + sdf.format(c.getTime()) + ") 입니다.</h3><br>"); // 형태로 출력
	}
	if (cookies != null) { // cookies가 null이 아니라면
	for (int i = 0; i < cookies.length; i++)	{ // 배열 cookies의 길이 만큼 반복하는동안
		Cookie thisCookie = cookies[i]; // 배열 cookies의 i번째 값을 thisCookie에 담는다
		if ("name".equals(thisCookie.getName())) { // 만약 name과 thisCookie의 이름이 같다면
			thisCookie.setMaxAge(0); // 유효기간 0으로 설정 -> 지워짐
			response.addCookie(thisCookie); // 쿠키를 세팅
			}
		}
	}
	String myName = URLEncoder.encode(sdf.format(c.getTime()),"utf-8"); // SimpledateFormat을 utf-8로 웹 인코딩하여 myName로 선언 
	Cookie cookieName = new Cookie("name", myName);  // myNamed을 cookieName에 저장
	cookieName.setMaxAge(-1); // 브라우저 켜있을때 까지
	response.addCookie(cookieName);  // RESPONSE 객체에 보내야 사용가능함
%>


</center>
</body>
</html>