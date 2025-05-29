<%@page import="Model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
int boardNum = Integer.parseInt(request.getParameter("boardNum"));

if (boardNum != -1) {
	try {
		BoardDAO boardDAO = BoardDAO.getInstance();
		int su = boardDAO.deleteBoard(boardNum);
		if (su != 0) {
%>
공지사항 삭제 성공!
<script type="text/javascript">
	alert('공지사항 삭제 성공!');
	location.href = "../Professor_Main.jsp";
</script>
<%
response.sendRedirect("../Professor/Professor_Board.jsp");
} else {
%>
공지사항 삭제 실패...
<script type="text/javascript">
	alert('공지사항 삭제 실패!');
</script>
<%
}
} catch (Exception e) {

}
}
%>




