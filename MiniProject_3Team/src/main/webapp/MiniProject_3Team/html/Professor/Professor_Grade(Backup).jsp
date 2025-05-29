<%@page import="Model.LectureDTO"%>
<%@page import="java.util.List"%>
<%@page import="Model.LectureDAO"%>
<%@page import="Model.ProfessorDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grade</title>
    <link rel="stylesheet" href="../css/Professor.css">
</head>
<body>
    <div id="wrap">
        <div class="search-container">
            <div>
                <select id="grade">
                    <option value="학년선택" selected disabled>학년 선택</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                </select>
                <select id="day">
                    <option value="주간/야간" selected disabled>주간/야간</option>
                    <option value="주간">주간</option>
                    <option value="야간">야간</option>
                </select>
            </div>
            <div class="search-group">
                <input type="text" placeholder="교과목명 입력">
                <button class="btn">검색하기</button>
            </div>
            
        <%
		request.setCharacterEncoding("utf-8");
		HttpSession professorSession = request.getSession();
		ProfessorDTO professorDTO = (professorSession != null) ? (ProfessorDTO) professorSession.getAttribute("userDTO") : null;
				
		if (professorDTO != null) {
			int professorId = professorDTO.getProf_id();
			        
			// LectureDAO 인스턴스 생성 및 강의 목록 가져오기
			LectureDAO lectureDAO = LectureDAO.getInstance();
			List<LectureDTO> lectures = lectureDAO.attSel(professorId);  
		%>
		
	        <!-- 첫 번째 테이블 -->
	        <table id="Professor_table">
	            <tr class="label">
	                <td class="shortTD">No</td>
	                <td class="shortTD">주.야</td>
	                <td class="shortTD">학년</td>
	                <td>교과목명</td>
	                <td class="middleTD">이수구분</td>
	                <td class="shortTD">학점</td>
	                <td class="middleTD">담당교수</td>
	                <td>강의시간</td>
	                <td>강의실</td>
	                <td class="middleTD">인원제한</td>
	                <td class="middleTD">수강인원</td>
	                <td></td>
	            </tr>
	            <%
	            int count = 1;  // 강의 번호
	        	for (LectureDTO lecture : lectures) {  // 강의 목록을 테이블에 출력
	            %>
	            <tr>
	                <td><%= count++ %></td>
	                <td><%= lecture.getIsDaytime() %></td>
	                <td><%= lecture.getYearLevel() %></td>
	                <td><%= lecture.getSubjectName() %></td>
	                <td><%= lecture.getCourseType() %></td>
	                <td><%= lecture.getCredit() %></td>
	                <td><%= lecture.getProfName() %></td>
	                <td><%= lecture.getTime() %></td>
	                <td><%= lecture.getRoomName() %></td>
	                <td><%= lecture.getMaxStudents() %></td>
	                <td><%= lecture.getCurrentStudents() %></td>
	                <td>
	                <form action="" method="get">
		                <input type="hidden" name="subjectId" value="<%= lecture.getSubjectId() %>">
		                <input type="hidden" name="roomId" value="<%= lecture.getRoomId() %>">
		                <input type="hidden" name="profId" value="<%= lecture.getProfId() %>">
		                <button type="button">관리</button>
		                
	                </form>
	                </td>
		        </tr>
		        <%
		            }
	   			 }
		        %>
	            
	        </table>

        <br>

        <table id="Professor_table">
            <tr class="label">
                <td>No</td>
                <td>학년</td>
                <td>교과목명</td>
                <td>학생명</td>
                <td>점수</td>
                <td colspan="7"></td>
            </tr>
            <tr>
                <td>1</td>
                <td>3</td>
                <td>Java</td>
                <td>김학생</td>
                <td><input type="text" class="score"></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><button>성적변경</button></td>
            </tr>
            <tr>
                <td>2</td>
                <td>1</td>
                <td>CSS</td>
                <td>최학생</td>
                <td><input type="text" class="score"></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><button>성적변경</button></td>
            </tr>
        </table>
    	</div>
    </div>
</body>
</html>
