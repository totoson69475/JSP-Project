<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="Model.AttendanceDTO"%>
<%@page import="Model.AttendanceDAO"%>
<%@page import="Model.GradeDAO"%>
<%@page import="Model.GradeDTO"%>
<%@page import="Model.ClassroomDAO"%>
<%@page import="Model.ProfessorDAO"%>
<%@page import="Model.EnrollmentDAO"%>
<%@page import="Model.SubjectDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.SubjectDAO"%>
<%@page import="Model.StudentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	request.setCharacterEncoding("utf-8");
	HttpSession studentSession = request.getSession();
	StudentDTO studentDTO = (studentSession != null) ? (StudentDTO) studentSession.getAttribute("userDTO") : null;	
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학생 출결 조회</title>
    <link rel = "stylesheet" href="../css/studentCss.css">
    <!-- <script src = "../JS/studentJS.js"></script> -->
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
		                $("#includeDIV").html(response);
		            },
		            error: function(xhr, status, error){
		                console.log("AJAX 요청 실패:", error);
		            }
		        });
		    }
		});
    </script>
</head>
<body>
	<%
		String prevYearLevel = request.getParameter("yearLevel");
		String prevQuery = request.getParameter("subjectName");
		if (prevQuery == null) prevQuery = "";
	%>
    <div id = "wrap">
        <form method="get" action="./Student/student_attendance.jsp"> 
            <!-- 검색 조건 분기 -->
            <select name = "yearLevel">
            	<option value = "0" <%= ("0".equals(prevYearLevel)) ? "selected" : "" %>>학년 선택</option>
                <option value = "1" <%= ("1".equals(prevYearLevel)) ? "selected" : "" %>>1</option>
                <option value = "2" <%= ("2".equals(prevYearLevel)) ? "selected" : "" %>>2</option>
                <option value = "3" <%= ("3".equals(prevYearLevel)) ? "selected" : "" %>>3</option>
                <option value = "4" <%= ("4".equals(prevYearLevel)) ? "selected" : "" %>>4</option>
            </select>
            <br><br>
            <!-- 검색 -->
            <input type="text" name="subjectName" placeholder="교과목명 입력" class = "inputSearch" value=<%= prevQuery%>>
            <input type = "submit" onclick ="" value = "검색" class = "buttonSearch">
        </form>
        <br>
        과목별 출결 상태<br>
        <table class="studentTable" border="1px">
		    <thead>
		        <tr>
		            <td style="width: 50px">No</td>
		            <td style="width: 70px">학년도</td>
		            <td style="width: 50px">학년</td>
		            <td style="width: 250px;">교과목명</td>
		            <td style="width: 60px">총 주차</td>
		            <td style="width: 70px">현재 주차</td>
		            <td style="width: 50px">출석</td>
		            <td style="width: 50px">지각</td>
		            <td style="width: 50px">결석</td>
		            <td style="width: 50px">조퇴</td>
		            <td style="width: 100px">상세보기</td>
		        </tr>
		    </thead>
		    <%
			  //세션 잘 가져오는지 확인용
			    if (studentDTO != null) {
			        System.out.println("studentDTO 세션에서 정상적으로 가져옴: " + studentDTO.getStudent_name());
			    } else {
			        System.out.println("studentDTO가 세션에 없음 (null)");
			    }
	
			    SubjectDAO subjectDAO = SubjectDAO.getInstance();
			    //과목번호 가져오기
			    int subject_id = subjectDAO.subIdFind(studentDTO.getStudent_id());
				
				GradeDAO gradeDAO = GradeDAO.getInstance();
				AttendanceDAO attendanceDAO = AttendanceDAO.getInstance();
				EnrollmentDAO enrollmentDAO = EnrollmentDAO.getInstance();
				
				//ArrayList<GradeDTO> gradeDTO = gradeDAO.findGrade(studentDTO.getStudent_id());
				
				//초기화
				ArrayList<SubjectDTO> subjectList = new ArrayList<>();
				
				// 페이징용 변수들
	        	int currentPage = 1;
	    	    int pageSize = 1;
	    	    int totalRecords = 0;
	            int totalPages = 0;
	            
	            String pageParam = request.getParameter("page");
        	    if (pageParam != null) {
        	    	currentPage = Integer.parseInt(pageParam);
        	    }
				
				if(studentDTO != null){
            		int stuId = studentDTO.getStudent_id();
            		
            		totalRecords = subjectDAO.getStudentTotalEnrolledRecordCount(studentDTO.getStudent_id());
	        		totalPages = (int) Math.ceil((double) totalRecords / pageSize);
    			
    			    // 검색 조건 파라미터 수집
    			    String subjectName = request.getParameter("subjectName");
    			    String yearLevelStr = request.getParameter("yearLevel");
    			    
    			    Integer yearLevel = (yearLevelStr != null && !yearLevelStr.equals("")) ? Integer.parseInt(yearLevelStr) : null;
    			
    			    // 검색 조건이 하나라도 있으면 검색 실행
    			    if (subjectName != null || yearLevelStr != null) {
    			    	subjectList = subjectDAO.subFind(studentDTO.getStudent_id(), subjectName, yearLevel);
    			    } else {
    			        // 조건 없으면 전체 강의
    			    	subjectList = subjectDAO.subFind(studentDTO.getStudent_id(),currentPage, pageSize);
    			    }
            	}
				
		        int cnt = (currentPage - 1) * pageSize + 1;
		        for (SubjectDTO dto : subjectList) {
		            int subId = dto.getSubject_id();
		         	// 현재 학생이 해당 과목에서 기록된 출석 정보를 모두 가져옴
		            ArrayList<AttendanceDTO> attendanceList = attendanceDAO.findAttendance(studentDTO.getStudent_id(), subId);
		
		            int currentWeek = 0;			//현재 주차
		            int attendanceCount = 0;		//'출석' 횟수
		            int lateCount = 0;				//'지각' 횟수
		            int absentCount = 0;			//'결석' 횟수
		            int earlyLeaveCount = 0;		//'조퇴' 횟수
		
		            Set<Integer> weekSet = new HashSet<>(); // 중복되지 않는 주차 번호를 저장할 집합
		
		            for (AttendanceDTO att : attendanceList) {
		                if (att.getSubject_id() == subId) {
		                    weekSet.add(att.getWeek_id());
		
		                    String status = att.getAttendance_status_name();
		                    switch (status) {
		                        case "출석": attendanceCount++; break;
		                        case "지각": lateCount++; break;
		                        case "결석": absentCount++; break;
		                        case "조퇴": earlyLeaveCount++; break;
		                    }
		                }
		            }
		
		            //currentWeek = weekSet.size();
		            currentWeek = attendanceCount + lateCount + absentCount + earlyLeaveCount;
		            
		    %>
		    <tr>
		        <td><%= cnt++ %></td>
		        <td>2025</td>
		        <td><%= dto.getYear_level() %></td>
		        <td><%= dto.getSubject_name() %></td>
		        <td>15</td> 
		        <td><%= currentWeek %></td>
		        <td><%= attendanceCount %></td>
		        <td><%= lateCount %></td>
		        <td><%= absentCount %></td>
		        <td><%= earlyLeaveCount %></td>
		        <td>
		            <input type="hidden" name="subject_id" value="<%=dto.getSubject_id()%>">
		            <button type="button" onclick="detailAttendance(this)">상세보기</button>
		        </td>
		    </tr>
		    <% } %>
		</table>
		<!-- 페이징 네비게이션 -->
        <div style="text-align: center; margin-top: 20px;">
            <%
            int pageGroupSize = 10;
            int prevPage = ((currentPage - 1) / pageGroupSize) * pageGroupSize;
            int nextPage = prevPage + pageGroupSize + 1;

            // 이전 10단위로 이동
            if (prevPage > 0) {
            %>
                <a href="./Student/student_attendance.jsp?page=<%= prevPage %>" class="page-nav">&laquo;</a>
            <%
            } else {
            %>
                <span class="page-nav disabled">&laquo;</span>
            <%
            }

            // 페이지 번호 출력
            for (int i = prevPage + 1; i <= prevPage + pageGroupSize && i <= totalPages; i++) {
                if (i == currentPage) {
            %>
                <span class="span"><%= i %></span>
            <%
                } else {
            %>
                <a href="./Student/student_attendance.jsp?page=<%= i %>" class="paging"><%= i %></a>
            <%
                }
            }

            // 다음 10단위로 이동
            if (nextPage <= totalPages) {
            %>
                <a href="./Student/student_attendance.jsp?page=<%= nextPage %>" class="page-nav">&raquo;</a>
            <%
            } else {
            %>
                <span class="page-nav disabled">&raquo;</span>
            <%
            }
            %>
        </div>
		
		
        <br><br> &lt;상세 출석&gt;<br>
        
        <%-- 과목 리스트 돌면서 상세 출석 표 생성 --%>
		<% for(SubjectDTO subject : subjectList) {
		     int subId = subject.getSubject_id();
		     ArrayList<AttendanceDTO> attendanceList = attendanceDAO.findAttendance(studentDTO.getStudent_id(), subId);
		%>
		<div class="attendanceRow" data-subject-id="<%=subId%>" style="display: none;">
	        <div id="detail_<%=subId%>" style="">
			    <h3><%=subject.getSubject_name()%></h3>
			    <table class="studentTable" border="1">
			        <tr>
			            <% for (int i = 1; i <= 15; i++) { %>
			                <td><%=i%>주차</td>
			            <% } %>
			            <td>이의신청</td>
			        </tr>
			        <tr>
			            <%
			                // 해당 과목의 주차별 출석 데이터 맵 만들기(주차(key): 출석 상태(value))
			                Map<Integer, String> attendanceMap = new HashMap<>();
			                for (AttendanceDTO att : attendanceList) {
			                	if (att.getSubject_id() == subId) {
			                        int week = att.getWeek_id();
			                        String status = att.getAttendance_status_name(); // 예: 출석, 지각, 결석 등
			                        attendanceMap.put(week, status);
			                    }
			                }
			            %>
			             	<!-- 과목명 숨기기 (이의신청용 식별 값) -->
    						<td id="attendanceLecture" style="display:none;"><%=subject.getSubject_name()%></td>    
    					<%
							
			                
			                for (int i = 1; i <= 15; i++) {
			                	 // getOrDefault: i 주차 정보가 존재하면 그 값을, 없으면 "-" 반환
			                    String mark = attendanceMap.getOrDefault(i, "-"); 
			            %>
			                <td><%=mark%></td>
			            <% } %>
			            <td><button onclick="attendanceDissent(event)">이의신청</button></td>
			        </tr>
			    </table>
			</div>
		</div>
		<% } %>
    </div>
</body> 
</html>