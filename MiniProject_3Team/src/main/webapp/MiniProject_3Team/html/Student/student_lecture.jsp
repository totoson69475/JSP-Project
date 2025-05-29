<%@page import="Model.EnrollmentDAO"%>
<%@page import="Model.ClassroomDAO"%>
<%@page import="Model.ProfessorDAO"%>
<%@page import="Model.DepartmentDAO"%>
<%@page import="Model.StudentDTO"%>
<%@page import="Model.SubjectDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.SubjectDAO"%>
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
    <title>학생 수강 신청</title>
    <link rel = "stylesheet" href="../css/studentCss.css">
    <script src = "../JS/studentJS.js"></script>
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
		        adjustTextareaHeight();
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
	 
	    function adjustTextareaHeight() {
	        const $textarea = document.getElementById('textArea');
	        console.log("높이조절 시작");
	        $textarea.style.height = 'auto'; // 높이 초기화
	        const scrollHeight = $textarea.scrollHeight;
	        $textarea.style.height = scrollHeight + 'px';
	        console.log($textarea.scrollHeight);
	    }
		
    </script>
</head>
<body>
	<%
		String prevCourseType = request.getParameter("CourseType");
		String prevYearLevel = request.getParameter("yearLevel");
		String prevIsDaytime = request.getParameter("isDaytime");
		String prevQuery = request.getParameter("subjectName");
		if (prevQuery == null) prevQuery = "";
	%>
    <div id = "wrap">
        <form method="get" action="./Student/student_lecture.jsp"> 
            <!-- 검색 조건 분기(수정필요) -->
            <select name = "CourseType">
                <option value = "" <%= ("".equals(prevCourseType)) ? "selected" : "" %>>전공/교양</option>
                <option value = "전필" <%= ("전필".equals(prevCourseType)) ? "selected" : "" %>>전필</option>
                <option value = "전선" <%= ("전선".equals(prevCourseType)) ? "selected" : "" %>>전선</option>
                <option value = "교필" <%= ("교필".equals(prevCourseType)) ? "selected" : "" %>>교필</option>
                <option value = "교선" <%= ("교선".equals(prevCourseType)) ? "selected" : "" %>>교선</option>
            </select>
            <select name = "yearLevel">
            	<option value = "0" <%= ("0".equals(prevYearLevel)) ? "selected" : "" %>>학년 선택</option>
                <option value = "1" <%= ("1".equals(prevYearLevel)) ? "selected" : "" %>>1</option>
                <option value = "2" <%= ("2".equals(prevYearLevel)) ? "selected" : "" %>>2</option>
                <option value = "3" <%= ("3".equals(prevYearLevel)) ? "selected" : "" %>>3</option>
                <option value = "4" <%= ("4".equals(prevYearLevel)) ? "selected" : "" %>>4</option>
            </select>
            <select name = "isDaytime">
                <option value = "" <%= ("".equals(prevIsDaytime)) ? "selected" : "" %>>주간/야간</option>
                <option value = "Y" <%= ("Y".equals(prevIsDaytime)) ? "selected" : "" %>>주간</option>
                <option value = "N" <%= ("N".equals(prevIsDaytime)) ? "selected" : "" %>>야간</option>
            </select>
            <br><br>
            <!-- 검색 -->
            <input type="text" name="subjectName" placeholder="교과목명 입력" class = "inputSearch" value=<%= prevQuery%>>
            <input type = "submit" onclick ="" value = "검색" class = "buttonSearch">
        </form>
        <br>
        <table class="studentTable" border = "1px">
            <thead>
                <tr>
                    <td style="width: 50px">No</td>
                    <td style="width: 70px">주야</td>
                    <td style="width: 50px">학년</td>
                    <td style="width: 250px;">교과목명</td>
                    <td>이수 구분</td>
                    <td style="width: 50px">학점</td>
                    <td>담당 교수</td>
                    <td>강의 시간</td>
                    <td style="width: 150px">강의실</td>
                    <td style="width: 80px">인원제한</td>
                    <td style="width: 80px">수강인원</td>
                    <td style="width: 50px">신청</td>
                </tr>
            </thead>
            <%
            	//세션 잘 가져오는지 확인용
	            if (studentDTO != null) {
	                System.out.println("studentDTO 세션에서 정상적으로 가져옴: " + studentDTO.getStudent_name());
	            } else {
	                System.out.println("studentDTO가 세션에 없음 (null)");
	            }
            
            	EnrollmentDAO enrollmentDAO = EnrollmentDAO.getInstance();
           
            	//교수번호로 교수 이름 찾기
            	ProfessorDAO professorDAO = ProfessorDAO.getInstance();
        		String profName = "";
        		
            	//강의실 번호로 강의실 이름 찾기
            	ClassroomDAO classroomDAO = ClassroomDAO.getInstance();
            	String classroomName = "";
            	
            	//초기화
            	ArrayList<SubjectDTO> subjectList = new ArrayList<>();
            	
            	// 페이징용 변수들
            	int currentPage = 1;
        	    int pageSize = 2;
        	    int totalRecords = 0;
                int totalPages = 0;
                
        	    String pageParam = request.getParameter("page");
        	    if (pageParam != null) {
        	    	currentPage = Integer.parseInt(pageParam);
        	    }
        	    
            	
            	if(studentDTO != null){
            		int stuId = studentDTO.getStudent_id();
            		SubjectDAO subjectDAO = SubjectDAO.getInstance();
            		
            		//ArrayList<SubjectDTO> subjectList = subjectDAO.subFind();
            		
            		totalRecords = subjectDAO.getStudentTotalRecordCount();
	        		totalPages = (int) Math.ceil((double) totalRecords / pageSize);
    			
    			    // 검색 조건 파라미터 수집
    			    String subjectName = request.getParameter("subjectName");
    			    String courseType = request.getParameter("CourseType");
    			    String yearLevelStr = request.getParameter("yearLevel");
    			    String isDaytime = request.getParameter("isDaytime");
    			    
    			    Integer yearLevel = (yearLevelStr != null && !yearLevelStr.equals("")) ? Integer.parseInt(yearLevelStr) : null;
    			
    			    // 검색 조건이 하나라도 있으면 검색 실행
    			    if (subjectName != null || isDaytime != null || yearLevelStr != null || courseType != null) {
    			    	subjectList = subjectDAO.subFind(subjectName, courseType, yearLevel, isDaytime);
    			    } else {
    			        // 조건 없으면 전체 강의
    			    	subjectList = subjectDAO.subFind(currentPage, pageSize);
    			    }
            	}
            	
            	
            	//no를 위한 증가 번호 선언
            	int cnt = (currentPage - 1) * pageSize + 1;
            	
            	String dayTime = "";
				for(SubjectDTO dto : subjectList){
					if(dto.getIs_daytime().equals("Y")){
						dayTime = "주간";
					} else { dayTime = "야간";}
					profName = professorDAO.getProfName(dto.getProf_id());
					classroomName = classroomDAO.getClassroomName(dto.getRoom_id());
					String isEnrolled = enrollmentDAO.findIsEnrolled(studentDTO.getStudent_id(), dto.getSubject_id());	//수강여부 받아옴("Y" / "N")
					int current_student = enrollmentDAO.findSubStudent(dto.getSubject_id());	//과목별 수강 인원 정보 가져옴
			%>
            <tr>
                <td style="width: 50px" id = "no"><%= cnt %></td>
                <td style="width: 70px"><%=dayTime %></td>
                <td style="width: 50px"><%=dto.getYear_level() %></td>
                <td style="width: 250px;" id = "lectureName"><%=dto.getSubject_name()%></td>
                <td><%=dto.getCourse_type() %></td>
                <td style="width: 50px"><%=dto.getCredit() %></td>
                <td><%=profName %></td>
                <td><%=dto.getTime()%></td>
                <td style="width: 150px"><%=classroomName%></td>
                <td style="width: 80px"><%=dto.getMax_students() %></td>
                <td style="width: 80px"><%=dto.getCurrent_students() %></td>
                <td style="width: 50px">
			    	<form action="./Student/enrollment.jsp" method="post" id="enrollmentForm">
					    <input type="hidden" id="subject_id" name="subject_id" value="<%=dto.getSubject_id()%>">
					    <input type="hidden" id="subject_name" name="subject_name" value="<%=dto.getSubject_name()%>">
					    <input type="hidden" id="student_id" name="student_id" value="<%=studentDTO.getStudent_id() %>">
					    <input type="hidden" id="is_enrolled" name="is_enrolled" value="<%=isEnrolled%>">
					    
					    <button type="button" onclick="apply(event)">신청</button>
					</form>

                </td>
            </tr>
            <%
            		cnt++;
				}
			%>
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
                <a href="./Student/student_lecture.jsp?page=<%= prevPage %>" class="page-nav">&laquo;</a>
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
                <a href="./Student/student_lecture.jsp?page=<%= i %>" class="paging"><%= i %></a>
            <%
                }
            }

            // 다음 10단위로 이동
            if (nextPage <= totalPages) {
            %>
                <a href="./Student/student_lecture.jsp?page=<%= nextPage %>" class="page-nav">&raquo;</a>
            <%
            } else {
            %>
                <span class="page-nav disabled">&raquo;</span>
            <%
            }
            %>
        </div>
    </div>
</body> 
</html>