<%@page import="Model.ProfessorDAO"%>
<%@page import="Model.BoardDTO"%>
<%@page import="Model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/studentCss.css">
<script src="../JS/studentJS.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function adjustTextareaHeight() {
        const $textarea = document.getElementById('textArea');
        console.log("높이조절 시작");
        $textarea.style.height = 'auto'; // 높이 초기화
        const scrollHeight = $textarea.scrollHeight;
        $textarea.style.height = scrollHeight + 'px';
        console.log($textarea.scrollHeight);
    }
	
    adjustTextareaHeight();
</script>
</head>
<body>
	<%
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	BoardDAO boardDAO = BoardDAO.getInstance();
	BoardDTO boardDTO = boardDAO.getBoardByBoardNum(boardNum);
	ProfessorDAO professorDAO = ProfessorDAO.getInstance();
	%>
	<div id="wrap">
		<table class="studentTable" border="1px">
			<thead>
				<tr>
					<td style="width: 50px">No</td>
					<td style="width: 535px;">제목</td>
					<td style="width: 150px;">작성자</td>
					<td style="width: 250px;">작성일</td>
					<td style="width: 150px;">조회수</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width: 50px"><%=boardDTO.getBoard_num()%></td>
					<td style="width: 535px;"><a
						onclick="loadContent('./Student/student_board_view.jsp?boardNum=<%=boardDTO.getBoard_num()%>')"><%=boardDTO.getBoard_title()%></a></td>
					<td style="width: 150px;"><%=professorDAO.getProfName(boardDTO.getWriter_prof_id())%></td>
					<td style="width: 250px;"><%=boardDTO.getBoard_regtime()%></td>
					<td style="width: 150px;"><%=boardDTO.getBoard_views()%></td>
				</tr>
				<tr>
					<td colspan="5">
					<textarea id="textArea" 
					style="width:1113px; height:600px; border: none;" readonly><%= boardDTO.getBoard_content() %>
					</textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>