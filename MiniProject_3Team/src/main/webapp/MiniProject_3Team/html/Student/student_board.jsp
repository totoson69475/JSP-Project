<%@page import="Model.ProfessorDAO"%>
<%@page import="Model.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.StudentDTO"%>
<%@page import="Model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학생 공지사항</title>
<link rel="stylesheet" href="../css/studentCss.css">
<script src="../JS/studentJS.js"></script>
<script>
	// form 제출 시 페이지 새로고침 없이 AJAX로 처리
	$(document).ready(function() {
		$("form").submit(function(event) {
			event.preventDefault();
			loadContent($(this).attr("action"), $(this).serialize());
		});

		$(".paging, .page-nav").click(function(e) {
			e.preventDefault();
			const targetUrl = $(this).attr("href");
			loadContent(targetUrl, null);
		});

		function loadContent(url, data) {
			$.ajax({
				url : url,
				type : "GET",
				data : data,
				success : function(response) {
					$("#includeDIV").html(response);
				},
				error : function(xhr, status, error) {
					console.log("AJAX 요청 실패:", error);
				}
			});
		}
	});
</script>
<style>
	a {
		cursor:pointer;
	}
	
	a:hover {
		color:purple;
	}
</style>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	HttpSession studentSession = request.getSession();
	StudentDTO studentDTO = (studentSession != null) ? (StudentDTO) studentSession.getAttribute("userDTO") : null;
	%>
	<div id="wrap">
		<h2>공지사항</h2>
		<hr>
		<!-- 검색 -->
		<input type="text" name="subjectName" placeholder="제목 입력"
			class="inputSearch" value=> <input type="submit" onclick=""
			value="검색" class="buttonSearch">
		<br>
		<br>
		<form method="get" action="">
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
					<%
					BoardDAO boardDAO = BoardDAO.getInstance();
					ProfessorDAO professorDAO = ProfessorDAO.getInstance();
					ArrayList<BoardDTO> boardList = boardDAO.getAllBoard();

					//세션 잘 가져오는지 확인용
					if (studentDTO != null) {
						System.out.println("studentDTO 세션에서 정상적으로 가져옴: " + studentDTO.getStudent_name());
					} else {
						System.out.println("studentDTO가 세션에 없음 (null)");
					}

					for (BoardDTO board : boardList) {
					%>
					<tr>
						<td style="width: 50px"><%=board.getBoard_num()%></td>
						<td style="width: 535px;"><a
							onclick="loadContent('./Student/student_board_view.jsp?boardNum=<%=board.getBoard_num()%>')"><%=board.getBoard_title()%></a></td>
						<td style="width: 150px;"><%=professorDAO.getProfName(board.getWriter_prof_id())%></td>
						<td style="width: 250px;"><%=board.getBoard_regtime()%></td>
						<td style="width: 150px;"><%=board.getBoard_views()%></td>
					</tr>

					<%
					}
					%>
				</tbody>
			</table>
		</form>
	</div>

</body>
</html>