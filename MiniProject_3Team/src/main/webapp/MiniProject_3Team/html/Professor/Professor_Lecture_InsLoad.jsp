<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DBSetting.*"%>
<%@page import="Model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Professor_Lecture_InsLoad</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");

String isDaytime = request.getParameter("isDaytime");
int yearLevel = Integer.parseInt(request.getParameter("yearLevel"));
String subjectName = request.getParameter("subjectName");
String courseType = request.getParameter("courseType");
String credit = request.getParameter("credit");
int profId = Integer.parseInt(request.getParameter("profId"));
String professorName = request.getParameter("profName"); 
String time = request.getParameter("time");
int roomId = Integer.parseInt(request.getParameter("roomId"));
String roomName = request.getParameter("roomName");
int maxStudents = Integer.parseInt(request.getParameter("maxStudents"));
int currentStudents = Integer.parseInt(request.getParameter("currentStudents"));


LectureDTO newLecture =  new LectureDTO();
newLecture.setIsDaytime(isDaytime);
newLecture.setYearLevel(yearLevel);  
newLecture.setSubjectName(subjectName);
newLecture.setCourseType(courseType);
newLecture.setCredit(Integer.parseInt(credit));  
newLecture.setProfId(profId);
newLecture.setProfName(professorName);  
newLecture.setTime(time);  
newLecture.setRoomName(roomName); 
newLecture.setMaxStudents(maxStudents);
newLecture.setCurrentStudents(currentStudents);
newLecture.setRoomId(roomId);

LectureDAO lectureDAO = LectureDAO.getInstance();
int su = lectureDAO.InsLecture(newLecture);

if (su > 0) {
    out.println("강의가 성공적으로 생성되었습니다!");
}else {
    out.println("강의 생성에 실패했습니다.");
}
response.sendRedirect("../Professor_Main.jsp");

%>
</body>
</html>