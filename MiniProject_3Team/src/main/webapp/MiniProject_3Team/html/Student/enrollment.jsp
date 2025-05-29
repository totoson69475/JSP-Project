<%@page import="Model.AttendanceDAO"%>
<%@page import="Model.GradeDAO"%>
<%@page import="Model.SubjectDAO"%>
<%@page import="Model.EnrollmentDAO"%>
<%@page import="Model.EnrollmentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>enrollment.jsp</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8"); // 적용 안하면 한글 깨짐
	int enrolled_id, student_id, subject_id;
	String is_enrolled;
	//enrolled_id = Integer.parseInt(request.getParameter("enrolled_id"));
	student_id = Integer.parseInt(request.getParameter("student_id"));
	subject_id = Integer.parseInt(request.getParameter("subject_id"));
	//is_enrolled = request.getParameter("is_enrolled");
	SubjectDAO subject = SubjectDAO.getInstance();
	GradeDAO grade = GradeDAO.getInstance();
	EnrollmentDTO enrollmentDTO = new EnrollmentDTO(student_id, subject_id); 
			
	EnrollmentDAO enrollmentDAO = EnrollmentDAO.getInstance();
	AttendanceDAO attendanceDAO = AttendanceDAO.getInstance();
	int su = enrollmentDAO.subjectEnrolled(enrollmentDTO);
	
	if(su != 0) {	//수강 과목 추가 완료
		subject.incrementCurrentStudent(subject_id);
		grade.createGrade(student_id, subject_id, subject.findProfessor(subject_id));
		for(int i = 1; i < 16; i++) {
			attendanceDAO.createAttendance(student_id, subject_id, i, subject.findProfessor(subject_id));
		}
		response.sendRedirect("../Student_Main.jsp?page=student_lecture");
	} else {		//수강 과목 추가 실패
		out.print("수강 추가 실패");
		//response.sendRedirect("./index.jsp?error=loginFailed");
	}
	
%>
</body>
</html>