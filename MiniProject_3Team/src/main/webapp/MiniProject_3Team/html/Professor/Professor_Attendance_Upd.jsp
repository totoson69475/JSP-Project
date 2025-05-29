<%@page import="Model.AttendanceStatusDAO"%>
<%@page import="Model.AttendanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ page import="java.util.*, java.io.*" %>
	<%
		AttendanceDAO attendanceDAO = AttendanceDAO.getInstance();
		AttendanceStatusDAO attendanceStatusDAO = AttendanceStatusDAO.getInstance();
		int subjectId = Integer.parseInt(request.getParameter("subjectId"));
	    // 학생 ID 배열 받기
	    String[] studentIds = request.getParameterValues("studentId[]");
	    
	    if (studentIds != null) {
	        for (String studentId : studentIds) {
	            out.println("학생 ID: " + studentId + "<br>");
	            // 각 학생별로 주차별 출석 상태를 읽기
	            for (int week = 1; week <= 15; week++) {
	                String paramName = "attendance_status[" + studentId + "][" + week + "]";
	                String attendanceStatus = request.getParameter(paramName);
	                out.println("학생 " + studentId + " - " + week + "주차: " + attendanceStatus + "<br>");
	                int attendanceStatusId = attendanceStatusDAO.getAttendanceStatusIdByName(attendanceStatus);
	                attendanceDAO.attendanceUpdate(attendanceStatusId, Integer.parseInt(studentId), subjectId, week);
	            }
	            out.println("<hr>");
	        }
	    %>
	        <script>
	        	alert("출석 수정 완료!");
	        	loadPage('./Professor/Professor_Attendance.jsp', '강의 관리')
	        </script>>
	<% 
	    } else {
	        out.println("전송된 학생 데이터가 없습니다.");
	    }
	%>
</body>
</html>