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
<script src="../JS/studentJS.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
//form 제출 시 페이지 새로고침 없이 AJAX로 처리
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
	<%
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	BoardDAO boardDAO = BoardDAO.getInstance();
	BoardDTO boardDTO = boardDAO.getBoardByBoardNum(boardNum);
	ProfessorDAO professorDAO = ProfessorDAO.getInstance();
	HttpSession professorSession = request.getSession();
	ProfessorDTO professorDTO = (professorSession != null) ? (ProfessorDTO) professorSession.getAttribute("userDTO") : null;
	
	%>
	<div id="wrap">
	    <%
	        if (professorDTO != null && professorDTO.getProf_id() == boardDTO.getWriter_prof_id()) {
	    %>
	    <div id="buttonDIV" style="float:right">
	        <input type="button" class="buttonSearch" style="width: 80px; margin:5px 0px 5px 5px; font-size: 18px;"
	        onclick="loadContent('./Professor/Professor_Board_Upd.jsp?boardNum=<%=boardDTO.getBoard_num()%>')"
	        value="수정">
	        <input type="button" class="buttonSearch" style="width: 80px; margin:5px 0px 5px 5px; font-size: 18px;"
	        onclick="loadContent('./Professor/Professor_Board_Del.jsp?boardNum=<%=boardDTO.getBoard_num()%>')"
	         value="삭제">
	    </div>
	    <% } %>
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
						onclick="loadContent('./Professor/Professor_Board_View.jsp?boardNum=<%=boardDTO.getBoard_num()%>')"><%=boardDTO.getBoard_title()%></a></td>
					<td style="width: 150px;"><%=professorDAO.getProfName(boardDTO.getWriter_prof_id())%></td>
					<td style="width: 250px;"><%=boardDTO.getBoard_regtime()%></td>
					<td style="width: 150px;"><%=boardDTO.getBoard_views()%></td>
				</tr>
				<tr>
					<td colspan="5">
					<textarea id="textArea" 
					style="width:1113px; height:600px; border: none;" readonly;><%= boardDTO.getBoard_content() %>
					</textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>