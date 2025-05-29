<%@page import="java.util.List"%>
<%@page import="Model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lecutre_Ins</title>
    <link rel="stylesheet" href="../css/Professor.css">
    <style>
    	input[type="text"]{
    		width: 80px;
    		text-align: center;
    	}
    </style>
    <script>
    </script>
</head>
<body>
	<form action="./Professor/Professor_Lecture_InsLoad.jsp" method="get">
	    <div id="wrap">
	        <div class="search-container">
	        	<button class="btn" style="margin-left: 1025px;">강의생성</button>
	        </div>
			<%
			request.setCharacterEncoding("utf-8");
			HttpSession professorSession = request.getSession();
			ProfessorDTO professorDTO = (professorSession != null) ? (ProfessorDTO) professorSession.getAttribute("userDTO") : null;
			
			int profId = professorDTO.getProf_id();
			String professorName = professorDTO.getProf_name();
			//List<LectureDTO> lectures = LectureDAO.getInstance().attSel(profId);
			List<LectureDTO> rooms = LectureDAO.getInstance().allRooms();
			%>
			
		        <!-- 첫 번째 테이블 -->
		        <table id="Professor_table">
		            <tr class="label">
		                <td>주.야</td>
		                <td>학년</td>
		                <td>교과목명</td>
		                <td>이수구분</td>
		                <td>학점</td>
		                <td>담당교수</td>
		                <td>강의시간</td>
		                <td>강의실</td>
		                <td>최대수강인원</td>
		                <td>현재수강인원</td>
		            </tr>
		            <tr>
		                <td>
		                	<select name="isDaytime">
		                		<option value="Y">주간</option>
		                		<option value="N">야간</option>
		                	</select>
		                </td>
		                <td>
		                	<select name="yearLevel">
		                		<option value = "1">1학년</option>
		                		<option value = "2">2학년</option>
		                		<option value = "3">3학년</option>
		                		<option value = "4">4학년</option>
		                		<option value = "5">전공심화</option>
		                	</select>
		                </td>
		                <td><input type="text" name="subjectName"></td>
		                <td>
		                	<select name="courseType">
		                		<option value="전필">전필</option>
		                		<option value="전선">전선</option>
		                		<option value="교필">교필</option>
		                		<option value="교선">교선</option>
		                	</select>
		                </td>
		                <td><input type="text" name="credit"></td>
		                <td>
		                <input type="hidden" name="profId" value="<%=profId%>">
		                <input type="text" name="profName" value="<%=professorName %>" readonly>
		                </td>
		                <td><input type="text" name="time"></td>
		                <td>
		                 <select name="roomId" id="roomId" required>
			              <option value="">선택</option>
			              <% for(LectureDTO lec : rooms) { %>
			                <option value="<%=lec.getRoomId()%>">
			                  <%=lec.getRoomName()%>
			                </option>
			              <% } %>
			            </select>
			            <!-- 선택된 이름을 함께 보내기 위한 hidden -->
			            <input type="hidden" name="roomName" id="roomName">
		                </td>
		                <td><input type="text" name="maxStudents"></td>
		                <td><input type="text" name="currentStudents"></td>
			        </tr>
		        </table>
    		</div>
    </form>
</body>
</html>
