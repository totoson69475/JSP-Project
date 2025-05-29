<%@page import="Model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Grade_UpdLoad</title>
</head>
<body>
<%
int studentId = Integer.parseInt(request.getParameter("studentId"));
String newScore = request.getParameter("newScore");
int profId = Integer.parseInt(request.getParameter("profId"));
int subjectId = Integer.parseInt(request.getParameter("subjectId"));

// GradeDAO 객체 생성 후 성적 업데이트 메소드 호출
GradeDAO gradeDAO = GradeDAO.getInstance();
int result = gradeDAO.gradeUpd(studentId, subjectId, newScore);

if (result > 0) {
    out.println("<script>alert('성적이 성공적으로 수정되었습니다!'); location.href='../Professor_Main.jsp';</script>");
} else {
    out.println("<script>alert('성적 수정에 실패했습니다.'); history.back();</script>");
}
%>
</body>
</html>