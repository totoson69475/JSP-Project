<%@page import="Model.StudentDTO"%>
<%@page import="Model.StudentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	학생로그인
	<%
		request.setCharacterEncoding("utf-8");
	
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		StudentDTO dto = null;
		try {
			StudentDAO dao = StudentDAO.getInstance();
			dto = dao.stuLog(Integer.parseInt(id), pwd);
		} catch (NumberFormatException e) {
			System.out.println("잘못된 ID 입력");
		}
		
		if(dto != null){
			HttpSession studentSession = request.getSession();
			studentSession.setAttribute("userDTO", dto);
			response.sendRedirect("./html/Student_Main.jsp");
		} else {
			response.sendRedirect("./index.jsp?error=loginFailed");
		}
	%>
	
</body>
</html>