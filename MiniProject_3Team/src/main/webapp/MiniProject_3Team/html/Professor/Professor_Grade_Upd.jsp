<%@ page import="Model.GradeDAO" %>
<%@ page import="Model.GradeDTO2" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grade Update</title>
    <link rel="stylesheet" href="../css/Professor.css">
</head>
<body>
    <div id="wrap">
        <div class="search-container">
            <%
                int studentId = Integer.parseInt(request.getParameter("studentId"));
            	int profId = Integer.parseInt(request.getParameter("profId"));
            	int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                
                // GradeDAO에서 해당 학번에 대한 정보 조회
                GradeDAO gradeDAO = GradeDAO.getInstance();
                GradeDTO2 grade = gradeDAO.gradeUpd(studentId, subjectId);  // 학번에 해당하는 데이터를 조회
                
                if (grade == null) {
                    out.print("학생 정보를 찾을 수 없습니다.");
                } else {
            %>
            <form action="./../html/Professor/Professor_Grade_UpdLoad.jsp" method="get">
                <table id="Professor_table" style="width: 1100px;">
                    <tr class="label">
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
                    <tr>
                        <td><%= grade.getSubjectName() %></td>
                        <td><%= grade.getStudentId() %></td>
                        <td><%= grade.getStudentName() %></td>
                        <td><%= grade.getDeptName() %></td>
                        <td><%= grade.getMajorType() %></td>
                        <td><%= grade.getPhone() %></td>
                        <td><%= grade.getEmail() %></td>
                        <td><input type="text" name="newScore" value="<%= grade.getScore() %>" class="shortTD"></td>
                    	<td>
		                    <input type="hidden" name="studentId" value="<%= grade.getStudentId() %>">
		                    <input type="hidden" name="profId" value="<%= grade.getProfId() %>">
		                    <input type="hidden" name="subjectId" value="<%= subjectId %>">
		                    <button type="submit" style="width: 40px;">변경</button>
                    	</td>
                    </tr>
                </table>
              </form>  
            <%
                }
            %>
        </div>
    </div>
</body>
</html>
