<%@page import="java.util.List"%>
<%@page import="Model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lecutre</title>
    <link rel="stylesheet" href="../css/Professor.css">
    <script>
    </script>
</head>
<body>
    <div id="wrap">
		<%
		request.setCharacterEncoding("utf-8");
		HttpSession professorSession = request.getSession();
		ProfessorDTO professorDTO = (professorSession != null) ? (ProfessorDTO) professorSession.getAttribute("userDTO") : null;
		
		int subjectId = Integer.parseInt(request.getParameter("subjectId"));
		int roomId    = Integer.parseInt(request.getParameter("roomId"));
		int profId    = Integer.parseInt(request.getParameter("profId"));
		System.out.print(subjectId);
		
		if (subjectId != 0) {
            // LectureDAO를 사용하여 subjectId로 강의 정보 조회
            LectureDAO lectureDAO = LectureDAO.getInstance();
            LectureDTO lecture = lectureDAO.getSubjectId(subjectId);
            //List<LectureDTO> lectures = LectureDAO.getInstance().attSel(profId);
            List<LectureDTO> rooms = LectureDAO.getInstance().allRooms();
		
		%>
		<form method="get">
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
	                <td></td>
	            </tr>
	            <%
	            %>
	            <tr id="lectureUpdTR">
	            	<input type="hidden" name="subjectId" value="<%= lecture.getSubjectId() %>">
	            	<input type="hidden" name="profId" value="<%= lecture.getProfId() %>">
            
	                <td>
	                	<select name="isDaytime">
	                		<option value="Y" <%= ("Y".equals(lecture.getIsDaytime())) ? "selected" : "" %>>주간</option>
		                	<option value="N" <%= ("N".equals(lecture.getIsDaytime())) ? "selected" : "" %>>야간</option>
	                	</select> 
	                </td>
	                <td>
	                	<select name="yearLevel">
	                		<option value = "1" <%= (Integer.valueOf(lecture.getYearLevel()) == 1) ? "selected" : "" %>>1학년</option>
	                		<option value = "2" <%= (Integer.valueOf(lecture.getYearLevel()) == 2) ? "selected" : "" %>>2학년</option>
	                		<option value = "3" <%= (Integer.valueOf(lecture.getYearLevel()) == 3) ? "selected" : "" %>>3학년</option>
	                		<option value = "4" <%= (Integer.valueOf(lecture.getYearLevel()) == 4) ? "selected" : "" %>>4학년</option>
	                		<option value = "5" <%= (Integer.valueOf(lecture.getYearLevel()) == 5) ? "selected" : "" %>>전공심화</option>
		                </select>
	                </td>
	                <td><input type="text" name="subjectName" value="<%= lecture.getSubjectName()%>"></td>
	                <td>
	                	<select name="courseType">
	                		<option value="전필" <%= ("전필".equals(lecture.getCourseType())) ? "selected" : "" %>>전필</option>
	                		<option value="전선" <%= ("전선".equals(lecture.getCourseType())) ? "selected" : "" %>>전선</option>
	                		<option value="교필" <%= ("교필".equals(lecture.getCourseType())) ? "selected" : "" %>>교필</option>
	                		<option value="교선" <%= ("교선".equals(lecture.getCourseType())) ? "selected" : "" %>>교선</option>
	                	</select>
	                </td>
	                <td><input type="text" name="credit" value="<%= lecture.getCredit() %>"></td>
	                <td><input type="text" name="profName" value="<%= lecture.getProfName() %>" readonly></td>
	                <td><input type="text" name="time" value="<%= lecture.getTime() %>"></td>
	                <td>
	                <select name="roomId" id="roomId" required>
			              <option value="">선택</option>
			              <% for(LectureDTO lec : rooms) { %>
			                <option value="<%=lec.getRoomId()%>" <%=(lecture.getRoomId() == lec.getRoomId()) ? "selected" : ""%>>
			                  <%=lec.getRoomName()%>
			                </option>
			              <% } %>
			            </select>
			            <!-- 선택된 이름을 함께 보내기 위한 hidden -->
			            <input type="hidden" name="roomName" id="roomName">
	                </td>
	                <td><input type="text" name="maxStudents" value="<%= lecture.getMaxStudents() %>"></td>
	                <td><input type="text" name="currentStudents" value="<%= lecture.getCurrentStudents() %>"></td>
	                <td>
	                	<button type="submit" formaction="./Professor/Professor_Lecture_UpdLoad.jsp">수정</button>
	                	<button type="submit" formaction="./Professor/Professor_Lecture_Del.jsp">삭제</button>
	                </td>
		        </tr>
		        <%
		            }
		        %>
	        </table>
	        
	     </form>
    </div>
</body>
</html>
