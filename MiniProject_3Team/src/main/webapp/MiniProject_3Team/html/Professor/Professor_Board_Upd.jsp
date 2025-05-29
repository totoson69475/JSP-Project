<%@page import="Model.ProfessorDTO"%>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	.boardButton {
		margin: 10px;
		width: 80px;
		height: 40px;
		cursor: pointer;
	}
</style>
<script>
	 	// form 제출 시 페이지 새로고침 없이 AJAX로 처리
	    $(document).ready(function(){
		    $("form").submit(function(event){
		        event.preventDefault();
		        loadContent($(this).attr("action"), $(this).serialize());
		    });
		
		    $(".paging, .page-nav").click(function(e){
		        e.preventDefault();
		        const targetUrl = $(this).attr("href");
		        loadContent(targetUrl, null);
		    });
		
		    function loadContent(url, data) {
		        $.ajax({
		            url: url,
		            type: "GET",
		            data: data,
		            success: function(response){
		                $("#wrap").html(response);
		            },
		            error: function(xhr, status, error){
		                console.log("AJAX 요청 실패:", error);
		            }
		        });
		    }
		    
		    $('#titleInput').keydown(function(e) {
		    	if (e.key === 'Enter' || e.keyCode === 13 || e.which === 13) {
		            e.preventDefault();
		            e.stopPropagation();
		        }
		    })
		});
	 	
	 
    </script>
</head>
<body>
	<div id="wrap">
	<%
		int boardNum = Integer.parseInt(request.getParameter("boardNum"));
		BoardDAO boardDAO = BoardDAO.getInstance();
		BoardDTO boardDTO = boardDAO.getBoardByBoardNum(boardNum);
		ProfessorDAO professorDAO = ProfessorDAO.getInstance();
		HttpSession professorSession = request.getSession();
		ProfessorDTO professorDTO = (professorSession != null) ? (ProfessorDTO) professorSession.getAttribute("userDTO") : null;
	%>
	<h2>공지사항 수정</h2>
	<form action="./Professor/Professor_Board_UpdLoad.jsp?boardNum=<%= boardNum%>" method="post">
		<table class="studentTable" border="1px">
				<thead>
					<tr>
						<td style="width: 150px">제목</td>
						<td>
							<input type="text" style="width: 985px; height: 29px;" name="titleInput" id="titleInput"
							value="<%= boardDTO.getBoard_title()%>"/>
						</td>
					</tr>
					<tr>
						<td style="width: 150px">내용</td>
						<td>
							<textarea style="width: 985px; height: 600px;" name="contentInput" id="contentInput"><%= boardDTO.getBoard_content() %></textarea>
						</td>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			<div style="display: flex; flex-direction: row; justify-content: center;">
				<input type="submit" class="boardButton" value="확인"/>
				<input type="button" class="boardButton" value="취소"/>
			</div>
	</form>
	</div>
</body>
</html>