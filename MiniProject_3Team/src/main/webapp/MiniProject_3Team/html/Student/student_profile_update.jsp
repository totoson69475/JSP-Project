<%@page import="Model.StudentDAO"%>
<%@page import="Model.StudentDTO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student_profile_update</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8"); // 적용 안하면 한글 깨짐
	
	// 이름, 기타, 생일, 전화번호, 주소, 이메일
	String vName, vEtc, vBirthDate, vPhone, vAddr, vEmail;
	// 학번
	int vId;
	
	vId = Integer.parseInt(request.getParameter("hakbun"));
	vName = request.getParameter("name");
	vEtc = request.getParameter("etc");
	vBirthDate = request.getParameter("birthDate");
	vPhone = request.getParameter("phoneNumber");
	vAddr = request.getParameter("address");
	vEmail = request.getParameter("email");
	
	// String을 java.sql.Date로 변환
	java.sql.Date birthDate = java.sql.Date.valueOf(vBirthDate);
	
	StudentDTO studentDTO = new StudentDTO(vId, vName, birthDate, vPhone, vAddr, vEmail, vEtc);
	StudentDAO studentDAO = StudentDAO.getInstance();
	StudentDTO dto = studentDAO.studentUpd(studentDTO);
	
	if(dto != null){
	    HttpSession studentSession = request.getSession();
	    studentSession.setAttribute("userDTO", dto);
	%>
	<script>
		history.back();
	</script>
	<% 
	    /* RequestDispatcher dispatcher = request.getRequestDispatcher("../Student_Main.jsp");
	    dispatcher.forward(request, response); */
	} else {
	    response.sendRedirect("./index.jsp?error=loginFailed");
	}

%>

</body>
</html>