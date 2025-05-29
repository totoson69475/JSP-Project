<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grade</title>
    <link rel="stylesheet" href="../css/Professor.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        // form 제출 시 페이지 새로고침 없이 AJAX로 처리
        $(document).ready(function(){
            $("form").submit(function(event){
                event.preventDefault(); // form 기본 제출 동작 방지
                
                var formData = $(this).serialize(); // form 데이터 직렬화
                
                // AJAX 요청 보내기
                $.ajax({
                    url: $(this).attr("action"), // form action 값
                    type: "GET", // 요청 방식
                    data: formData, // 전송할 데이터
                    success: function(response){
                        // 성공적으로 데이터를 받았을 때 해당 div에 내용 삽입
                        $("#includeDIV").html(response);
                    },
                    error: function(xhr, status, error){
                        console.log("AJAX 요청 실패:", error);
                    }
                });
            });
        });
    </script>
</head>
<body>
		<%
		request.setCharacterEncoding("utf-8");
		int profId = Integer.parseInt(request.getParameter("profId"));
		int subjectId = Integer.parseInt(request.getParameter("subjectId"));
		
		HttpSession professorSession = request.getSession();
		ProfessorDTO professorDTO = (professorSession != null) ? (ProfessorDTO) professorSession.getAttribute("userDTO") : null;
		
		GradeDAO gradeDAO = GradeDAO.getInstance();
		List<GradeDTO2> grades = new ArrayList<>(); 
		
		if (professorDTO != null) {
		    SubjectDAO subjectDAO = SubjectDAO.getInstance();
		
		    // 검색 조건 파라미터 수집
		    String NumOrName = request.getParameter("NumOrName");
		    String query = request.getParameter("query");
		    
		    // 검색 조건이 하나라도 있으면 검색 실행
		    if (NumOrName != null || query != null) {
		    	grades = gradeDAO.searchGrade(profId, subjectId, NumOrName, query);
		    } else {
		        // 조건 없으면 전체 성적
		        grades = gradeDAO.gradeSel(profId, subjectId);
		    }
		 String prevNumOrName = request.getParameter("NumOrName");
		 String prevQuery = request.getParameter("query");
		 if (prevQuery == null) prevQuery = "";
		%>
    <div id="wrap">
        <div class="search-container">
        <form method="get" action="./Professor/Professor_Grade_Select.jsp">
        <input type="hidden" name="subjectId" value="<%= subjectId %>">
        <input type="hidden" name="profId" value="<%= profId %>">
            <div>
                <select id="grade" name="NumOrName">
                    <option value="" <%= ("".equals(prevNumOrName)) ? "selected" : "" %>>학번/이름 검색</option>
                    <option value="g.student_id" <%= ("g.student_id".equals(prevNumOrName)) ? "selected" : "" %>>학번 검색</option>
                    <option value="s.student_name" <%= ("s.student_name".equals(prevNumOrName)) ? "selected" : "" %>>이름 검색</option>
                </select>
                <input name="query" style="height:35px;" type="text" placeholder="학번 OR 이름 입력" value="<%=prevQuery%>">
                <button class="btn" type="submit">검색하기</button>
            </div>
         </form>
        <table id="Professor_table">
            <tr class="label">
                <td class="shortTD">No</td>
                <td>교과목명</td>
                <td style="width:110px;">학번</td>
                <td style="width:110px;">이름</td>
                <td>학과</td>
                <td style="width: 80px;">전공과정</td>
                <td style="width:140px;">연락처</td>
                <td>이메일</td>
                <td class="shortTD">성적</td>
                <td style="width: 40px;"></td>
            </tr>
            <%
            int count = 1;
            for(GradeDTO2 grade : grades){
            %>
            <tr>
                <td><%= count++ %></td>
                <td><%= grade.getSubjectName() %></td>
	            <td><%= grade.getStudentId() %></td>
	            <td><%= grade.getStudentName() %></td>
	            <td><%= grade.getDeptName() %></td>
	            <td><%= grade.getMajorType() %></td>
	            <td><%= grade.getPhone() %></td>
	            <td><%= grade.getEmail() %></td>
	            <td><%= grade.getScore() %></td>
                <td>
                <form action="./Professor/Professor_Grade_Upd.jsp" method="get">
                <input type="hidden" name="studentId" value="<%= grade.getStudentId() %>">
                <input type="hidden" name="profId" value="<%= grade.getProfId() %>">
                <input type="hidden" name="subjectId" value="<%= grade.getSubjectId() %>">
                <button type="submit" style="width:38px;">수정</button>
                </form>
                </td>
            </tr>
            <%
            }
		}
            %>
        </table>
    	</div>
    </div>
</body>
</html>
