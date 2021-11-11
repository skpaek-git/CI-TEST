<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.text.SimpleDateFormat, java.util.*, java.util.Calendar.*"%>
<%@page import="RE.*"%>
<%
	// JSP Calendar:--
// Created by Jason Benassi
// jbenassi@lime-light.com
// http://www.wakeboardutah.com
// 7-2002
%>

<%
	// Global Vars
int action = 0; // incoming request for moving calendar up(1) down(0) for month
int currYear = 0; // if it is not retrieved from incoming URL (month=) then it is set to current year
int currMonth = 0; // same as year
int currYear2 = 0; // if it is not retrieved from incoming URL (month=) then it is set to current year
int currMonth2 = 0; // same as year
String boxSize = "100"; // how big to make the box for the calendar

//build 2 calendars

Calendar c = Calendar.getInstance();
Calendar cal = Calendar.getInstance();
Calendar ca = Calendar.getInstance();
Calendar ca2 = Calendar.getInstance();

if (request.getParameter("action") == null) // Check to see if we should set the year and month to the current
{
	currMonth = c.get(c.MONTH);
	currYear = c.get(c.YEAR);
	currMonth2 = c.get(c.MONTH);
	currYear2 = c.get(c.YEAR);
	cal.set(currYear, currMonth, 1);
	ca.set(currYear2, currMonth2, 1);
}

else {
	if (!(request.getParameter("action") == null)) // Hove the calendar up or down in this if block
	{
		currMonth = Integer.parseInt(request.getParameter("month"));
		currMonth2 = Integer.parseInt(request.getParameter("month"));
		currYear = Integer.parseInt(request.getParameter("year"));
		currYear2 = Integer.parseInt(request.getParameter("year"));

		if (Integer.parseInt(request.getParameter("action")) == 1) {
	cal.set(currYear, currMonth, 1);
	ca.set(currYear2, currMonth2, 1);
	cal.add(cal.MONTH, 1);
	ca.add(ca.MONTH, 1);
	currMonth = cal.get(cal.MONTH);
	currYear = cal.get(cal.YEAR);
	currMonth2 = ca.get(ca.MONTH);
	currYear2 = ca.get(ca.YEAR);
		} else {
	cal.set(currYear, currMonth, 1);
	ca.set(currYear2, currMonth2, 1);
	cal.add(cal.MONTH, -1);
	ca.add(ca.MONTH, -1);
	currMonth = cal.get(cal.MONTH);
	currYear = cal.get(cal.YEAR);
	currMonth2 = ca.get(ca.MONTH);
	currYear2 = ca.get(ca.YEAR);
		}
	}
}
%>
<%!
	public boolean isDate(int m, int d, int y) {// This method is used to check for a VALID date
		m -= 1;
		Calendar c = Calendar.getInstance();
		c.setLenient(false);

		try {
			c.set(y, m, d);
			Date dt = c.getTime();
		} catch (IllegalArgumentException e) {
			return false;

		}
		return true;
	}%>
<%!
	public String getDateName(int monthNumber) {// This method is used to quickly return the proper name of a month
		String strReturn = "";
		switch (monthNumber) {
			case 0 :
				strReturn = "1월";
				break;
			case 1 :
				strReturn = "2월";
				break;
			case 2 :
				strReturn = "3월";
				break;
			case 3 :
				strReturn = "4월";
				break;
			case 4 :
				strReturn = "5월";
				break;
			case 5 :
				strReturn = "6월";
				break;
			case 6 :
				strReturn = "7월";
				break;
			case 7 :
				strReturn = "8월";
				break;
			case 8 :
				strReturn = "9월";
				break;
			case 9 :
				strReturn = "10월";
				break;
			case 10 :
				strReturn = "11월";
				break;
			case 11 :
				strReturn = "12월";
				break;
		}
		return strReturn;
	}%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@900&family=Rowdies:wght@300&display=swap')
</style>
<style type="text/css">
 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: black; text-decoration: underline;}
 body {
	background-image: url("./배경화면.jpg");
	background-repeat:no-repeat;
	background-size: cover;
	}
</style>
<script>
	function submit(val, room) {
		document.getElementsByName('date')[0].value = val;
		document.getElementsByName('room')[0].value = room;
		document.getElementById('form').submit();
	}
</script>
</head>
<body>
	<table border='0' width='883' celpadding='0' cellspacing='0' align=center>
		<tr>
			<td width='250' align='right' valign='middle'><a href="d_01.jsp?month=<%=currMonth%>&year=<%=currYear%>&action=0"><font size="5">◀</font></a></td>
			<td width='360' align='center' valign='middle'><b><font size="5" style="font-family: 'Noto Serif KR', serif;"><%= cal.get(cal.YEAR) + "년 " + getDateName(cal.get(cal.MONTH)) %></font></b></td>
			<td width='273' align='left' valign='middle'><a href="d_01.jsp?month=<%=currMonth%>&year=<%=currYear%>&action=1"><font size="5">▶</font></a></td>
		</tr>
	</table>
	<form method=post id="form" action="d_02.jsp">
		<input type="hidden" name="date"> <input type="hidden"
			name="room">
		<table border="0" width="520" bordercolorlight="#C0C0C0"
			bordercolordark="#808080" style="border-collapse: collapse"
			bordercolor="#111111" cellpadding="0" cellspacing="0" align=center>
			<td width="100%">
				<table border="2" width="883" bordercolorlight="#C0C0C0"
					bordercolordark="#000000" style="border-collapse: collapse"
					bordercolor="#000000" cellpadding="0" cellspacing="0"
					bgcolor="#dfdcd8">
					<tr>
						<td width="<%=boxSize%>" align="center" nowrap
							bordercolor="#666666" bgcolor="#666666"><font
							color="red"><b>일</b></font></td>
						<td width="<%=boxSize%>" align="center" nowrap
							bordercolor="#666666" bgcolor="#666666"><font
							color="#FFFFFF"><b>월</b></font></td>
						<td width="<%=boxSize%>" align="center" nowrap
							bordercolor="#666666" bgcolor="#666666"><font
							color="#FFFFFF"><b>화</b></font></td>
						<td width="<%=boxSize%>" align="center" nowrap
							bordercolor="#666666" bgcolor="#666666"><font
							color="#FFFFFF"><b>수</b></font></td>
						<td width="<%=boxSize%>" align="center" nowrap
							bordercolor="#666666" bgcolor="#666666"><font
							color="#FFFFFF"><b>목</b></font></td>
						<td width="<%=boxSize%>" align="center" nowrap
							bordercolor="#666666" bgcolor="#666666"><font
							color="#FFFFFF"><b>금</b></font></td>
						<td width="<%=boxSize%>" align="center" nowrap
							bordercolor="#666666" bgcolor="#666666"><font
							color="red"><b>토</b></font></td>
					</tr>
<%
	ReservationService reservationService = new ReservationService();
		int currDay;
		String todayColor;
		int count = 1;
		int dispDay = 1;
		int order = 0;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String[][] resv_arr = new String[5][30];
		String name1 = "";
		String name2 = "";
		String name3 = "";

	for (int w = 1; w < 7; w++) {
%>
	<tr>
<%
	for (int d = 1; d < 8; d++) {
		if (!(count >= cal.get(c.DAY_OF_WEEK))) {
%>
		<td width="<%=boxSize%>" height="<%=boxSize%>" valign="top" align="center">&nbsp;</td>
<%
			count += 1;
		} else {
		if (isDate(currMonth + 1, dispDay, currYear)) { // use the isDate method
			if (dispDay == c.get(c.DAY_OF_MONTH) && c.get(c.MONTH) == cal.get(cal.MONTH) && c.get(c.YEAR) == cal.get(cal.YEAR)) { // Here we check to see if the current day is today
				todayColor = "#ffff99";
				order++;
				} else {
					todayColor = "#ffffff";
				}
		if (c.get(c.MONTH) == cal.get(cal.MONTH) && order > 0 && order < 31) {
%>
		<td bgcolor="<%=todayColor%>" width="<%=boxSize%>" align="center" height="<%=boxSize%>" valign="top"><b><%=dispDay%></b><br><br>
<%
			resv_arr[0][order - 1] = sdf.format(ca2.getTime());
			name1 = reservationService.selectReservation(resv_arr[0][order - 1], 1).get(0).getName();
			name2 = reservationService.selectReservation(resv_arr[0][order - 1], 2).get(0).getName();
			name3 = reservationService.selectReservation(resv_arr[0][order - 1], 3).get(0).getName();
 			if (name1 == null) {
%>
 				 <a href="#"  align="center" onclick="submit('<%=resv_arr[0][order - 1]%>', 1)">VIP룸</a><br>
<%
			} else {
%>
				 <font color="#0000ff"><%=name1.replace(name1.substring(1,2), "*")%></font><br> 
<%
}
 			if (name2 == null) {
%>
 				 <a href="#" onclick="submit('<%=resv_arr[0][order - 1]%>', 2)">일반룸</a><br>
<%
			} else {
%>
				 <font color="#0000ff"><%=name2.replace(name2.substring(1,2), "*")%></font><br> 
<%
}
			if (name3 == null) {
%>
				<a href="#" onclick="submit('<%=resv_arr[0][order - 1]%>', 3)">합리적인룸</a><br>
<%
			} else {
%>
				 <font color="#0000ff"><%=name3.replace(name3.substring(1,2), "*")%></font><br> 
<%
			}
 		order++;
 		ca2.add(ca2.DATE, +1);
 		} else if (c.get(c.MONTH) + 1 == cal.get(cal.MONTH) && order < 30 - (c.getActualMaximum(c.DAY_OF_MONTH) - c.get(c.DAY_OF_MONTH) + 1)) {
 %>
			<td bgcolor="<%=todayColor%>" width="<%=boxSize%>" align="center" height="<%=boxSize%>" valign="top"><b><%=dispDay%></b><br><br> 
<%
 			int order2 = order + (c.getActualMaximum(c.DAY_OF_MONTH) - c.get(c.DAY_OF_MONTH) + 1);
 			resv_arr[0][order2] = sdf.format(ca.getTime());
 			name1 = reservationService.selectReservation(resv_arr[0][order2], 1).get(0).getName();
 			name2 = reservationService.selectReservation(resv_arr[0][order2], 2).get(0).getName();
 			name3 = reservationService.selectReservation(resv_arr[0][order2], 3).get(0).getName();
 			if (name1 == null) {
%>
 				<a href="#" onclick="submit('<%=resv_arr[0][order2]%>', 1)">VIP룸</a><br>
<%
			} else {
%>
				 <font color="#0000ff"><%=name1.replace(name1.substring(1,2), "*")%></font><br> 
<%
}
			if (name2 == null) {
%>
  				<a href="#" onclick="submit('<%=resv_arr[0][order2]%>', 1)">일반룸</a><br>
<%
			} else {
%>
				<font color="#0000ff"><%=name2.replace(name2.substring(1,2), "*")%></font><br> 
<%						
}
			if (name3 == null) {
%>	
				 <a href="#" onclick="submit('<%=resv_arr[0][order2]%>', 1)">합리적인룸</a><br>
<%
			} else {
%>
				<font color="#0000ff"><%=name3.replace(name3.substring(1,2), "*")%></font><br> 
<%
			}
 				order++;
 				ca.add(ca.DATE, +1);
			} else {
%>
			<td bgcolor="<%=todayColor%>" width="<%=boxSize%>" align="center" height="<%=boxSize%>" valign="top"><b><%=dispDay%></b><br></td>
<%
			}
			count += 1;
			dispDay += 1;
			} else {
%>
				<td width="<%=boxSize%>" align="center" height="<%=boxSize%>" valign="top">&nbsp;</td>
<%
			}
		}
	}
%>
</tr>
<%
}
%>
</table>
</form>
			</td>
		</table>
</body>
</html>