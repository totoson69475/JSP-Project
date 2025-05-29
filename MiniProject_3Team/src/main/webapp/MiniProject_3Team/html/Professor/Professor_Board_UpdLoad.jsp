<%@page import="Model.BoardDAO"%>
<%@page import="java.time.LocalDate"%>
<%@page import="Model.ProfessorDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	
		HttpSession professorSession = request.getSession();
		ProfessorDTO professorDTO = (professorSession != null) ? (ProfessorDTO) professorSession.getAttribute("userDTO") : null;
	
		String board_title = request.getParameter("titleInput");
		String board_content = request.getParameter("contentInput");
		int boardNum = Integer.parseInt(request.getParameter("boardNum"));
		
		String currentTime = LocalDate.now().toString();
		java.sql.Date currentDate = java.sql.Date.valueOf(currentTime);
		
		BoardDAO boardDAO = BoardDAO.getInstance();
		int su = boardDAO.updateBoard(boardNum, board_title, board_content, currentDate);
		if(su != 0) {
	%>
	<script>
		alert('공지사항 수정 성공!');
		location.href = "../Professor_Main.jsp";
	</script>
	<%
		}else {
	%>
	<script>
		alert('공지사항 수정 실패!');
	</script>
	<%
		}
	%>
</body>
</html>