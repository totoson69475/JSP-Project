<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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
		
		GradeDAO gradeDAO = GradeDAO.getInstance();
		SubjectDAO subjectDAO = SubjectDAO.getInstance();
		AttendanceDAO attendanceDAO = AttendanceDAO.getInstance();
		List<GradeDTO2> grades = gradeDAO.gradeSel(profId, subjectId); 
		StudentDAO studentDAO = StudentDAO.getInstance();
		
		HttpSession professorSession = request.getSession();
		ProfessorDTO professorDTO = (professorSession != null) ? (ProfessorDTO) professorSession.getAttribute("userDTO") : null;
		
		Map<Integer, List<AttendanceDTO>> attendanceMap = null;
		
		if (professorDTO != null) {
		    // 검색 조건 파라미터 수집
		    String NumOrName = request.getParameter("NumOrName");
		    String query = request.getParameter("query");
		    
		    // 검색 조건이 하나라도 있으면 검색 실행
		    if (NumOrName != null || query != null) {
		    	attendanceMap = attendanceDAO.getSubjectAllStudentAttendance(subjectId, NumOrName, query);
		    } else {
		        // 조건 없으면 전체 성적
		    	attendanceMap = attendanceDAO.getSubjectAllStudentAttendance(subjectId, NumOrName, query);
		    }
		 String prevNumOrName = request.getParameter("NumOrName");
		 String prevQuery = request.getParameter("query");
		 if (prevQuery == null) prevQuery = "";
		%>
    <div id="wrap">
        <div class="search-container">
            <form method="get" action="./Professor/Professor_Attendance_Select.jsp">
	        <input type="hidden" name="subjectId" value="<%= subjectId %>">
	        <input type="hidden" name="profId" value="<%= profId %>">
	            <div>
	                <select id="grade" name="NumOrName">
	                    <option value="" <%= ("".equals(prevNumOrName)) ? "selected" : "" %>>학번/이름 검색</option>
	                    <option value="a.student_id" <%= ("a.student_id".equals(prevNumOrName)) ? "selected" : "" %>>학번 검색</option>
	                    <option value="st.student_name" <%= ("st.student_name".equals(prevNumOrName)) ? "selected" : "" %>>이름 검색</option>
	                </select>
	                <input name="query" style="height:35px;" type="text" placeholder="학번 OR 이름 입력" value="<%=prevQuery%>">
	                <button class="btn" type="submit">검색하기</button>
	            </div>
	         </form>
		<b><%= subjectDAO.findSubNameForAttendance(subjectId)%> 출석관리</b>
        <form action="./Professor/Professor_Attendance_Upd.jsp" method="post">
		    <table id="Professor_table">
		        <tr class="label">
		            <td style="width: 50px">No</td>
		            <td style="width:110px;">학번</td>
		            <td style="width:80px;">이름</td>
		            <% for(int week=1; week<=15; week++) { %>
		                <td style="width:50px"><%= week %>주차</td>
		            <% } %>
		            <td style="width:50px">수정</td>
		        </tr>
		        <% 
		            int index = 1;
		        %>
		        <% for (Integer studentId : attendanceMap.keySet()) { 
		            List<AttendanceDTO> studentAttendance = attendanceMap.get(studentId);
		            String studentName = studentDAO.getStudentNameById(studentId);
		        %>
		        <tr>
		            <td><%= index++ %></td>
		            <td>
		                <%= studentId %>
		                <input type="hidden" name="studentId[]" value="<%= studentId %>">
		                <input type="hidden" name ="subjectId" value="<%= subjectId%>">
		            </td>
		            <td><%= studentName %></td>
		            <% 
		                for (int week=1; week<=15; week++) {
		                    String attendanceStatus = "미등록";
		                    if (studentAttendance != null) {
		                        for (AttendanceDTO attendance : studentAttendance) {
		                            if (attendance.getWeek_id() == week) {
		                                attendanceStatus = attendance.getAttendance_status_name();
		                                break;
		                            }
		                        }
		                    }
		            %>
		            <td>
		                <input type="hidden" name="week_id[<%= studentId %>][<%= week %>]" value="<%= week %>">
		                <select style="width:50px;" name="attendance_status[<%= studentId %>][<%= week %>]">
		                    <option value="출석" <%= "출석".equals(attendanceStatus) ? "selected" : "" %>>출석</option>
		                    <option value="지각" <%= "지각".equals(attendanceStatus) ? "selected" : "" %>>지각</option>
		                    <option value="결석" <%= "결석".equals(attendanceStatus) ? "selected" : "" %>>결석</option>
		                    <option value="미등록" <%= "미등록".equals(attendanceStatus) ? "selected" : "" %>>미등록</option>
		                </select>
		            </td>
		            <% } %>
		            <td><button type="submit" style="width:50px;">수정</button></td>
		        </tr>
		        <% 
		        	}
		        }
		        %>
		    </table>
		</form>
    	</div>
    </div>
</body>
</html>
