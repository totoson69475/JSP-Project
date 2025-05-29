<%@page import="Model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Professor_Lecture_UpdLoad</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");

String isDaytime = request.getParameter("isDaytime");
int yearLevel = Integer.parseInt(request.getParameter("yearLevel"));
String subjectName = request.getParameter("subjectName");
String courseType = request.getParameter("courseType");
int credit = Integer.parseInt(request.getParameter("credit"));
String profName = request.getParameter("profName");
String time = request.getParameter("time");
String roomName = request.getParameter("roomName");
int maxStudents = Integer.parseInt(request.getParameter("maxStudents"));
int currentStudents = Integer.parseInt(request.getParameter("currentStudents"));
int subjectId = Integer.parseInt(request.getParameter("subjectId"));
int roomId = Integer.parseInt(request.getParameter("roomId"));
int profId = Integer.parseInt(request.getParameter("profId"));

SubjectDTO update =  new SubjectDTO();
update.setIsDaytime(isDaytime);
update.setYearLevel(yearLevel);  
update.setSubjectName(subjectName);
update.setCourseType(courseType);
update.setCredit(credit);  
update.setProfName(profName);  
update.setTime(time);  
update.setRoomName(roomName); 
update.setMaxStudents(maxStudents);
update.setCurrentStudents(currentStudents);
update.setRoomId(roomId);
update.setSubjectId(subjectId);
update.setProfId(profId);

SubjectDAO subjectDAO = SubjectDAO.getInstance();
int su = subjectDAO.UpdLecture(update);
if (su > 0) {
    out.println("<script>alert('강의가 성공적으로 수정되었습니다!'); location.href='../Professor_Main.jsp';</script>");
} else {
    out.println("<script>alert('강의 수정에 실패했습니다.'); history.back();</script>");
}

%>
</body>
</html>