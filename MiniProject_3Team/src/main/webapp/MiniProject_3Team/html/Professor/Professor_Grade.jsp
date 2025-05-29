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
		});
    </script>
</head>
<body>
	<%
	String prevYearLevel = request.getParameter("yearLevel");
	String pervIsDaytime = request.getParameter("isDaytime");
	String prevQuery = request.getParameter("subjectName");
	if (prevQuery == null) prevQuery = "";
	%>
    <div id="wrap">
        <div class="search-container">
            <form method="get" action="./Professor/Professor_Grade.jsp">
            <div>
                <select name="yearLevel" id="grade">
                    <option value="" <%= ("".equals(prevYearLevel)) ? "selected" : "" %>>학년 선택</option>
                    <option value="1" <%= ("1".equals(prevYearLevel)) ? "selected" : "" %>>1</option>
                    <option value="2" <%= ("2".equals(prevYearLevel)) ? "selected" : "" %>>2</option>
                    <option value="3" <%= ("3".equals(prevYearLevel)) ? "selected" : "" %>>3</option>
                    <option value="4" <%= ("4".equals(prevYearLevel)) ? "selected" : "" %>>4</option>
                </select>
                <select name="isDaytime" id="day">
                    <option value="" <%= ("".equals(pervIsDaytime)) ? "selected" : "" %>>주간/야간</option>
                    <option value="Y" <%= ("Y".equals(pervIsDaytime)) ? "selected" : "" %>>주간</option>
                    <option value="N" <%= ("N".equals(pervIsDaytime)) ? "selected" : "" %>>야간</option>
                </select>
            </div>
            <div class="search-group">
                <input name="subjectName" type="text" placeholder="교과목명 입력" value=<%= prevQuery%>>
                <button class="btn">검색하기</button>
            </div>
            </form>
         </div>

        <%
        request.setCharacterEncoding("utf-8");
		HttpSession professorSession = request.getSession();
		ProfessorDTO professorDTO = (professorSession != null) ? (ProfessorDTO) professorSession.getAttribute("userDTO") : null;
		
		int currentPage = 1;
	    int pageSize = 1;
	    int totalRecords = 0;
        int totalPages = 0;
        
        String pageParam = request.getParameter("page");
	    if (pageParam != null) {
	    	currentPage = Integer.parseInt(pageParam);
	    }
		
		List<SubjectDTO> lectures = new ArrayList<>();
		
		if (professorDTO != null) {
		    int profId = professorDTO.getProf_id();
		    SubjectDAO subjectDAO = SubjectDAO.getInstance();
		    
		    totalRecords = subjectDAO.getTotalRecordCount(profId);
	        totalPages = (int) Math.ceil((double) totalRecords / pageSize);
		
		    // 검색 조건 수집
		    String subjectName = request.getParameter("subjectName");
		    String isDaytime = request.getParameter("isDaytime");
		    String yearLevelStr = request.getParameter("yearLevel");
		    Integer yearLevel = (yearLevelStr != null && !yearLevelStr.equals("")) ? Integer.parseInt(yearLevelStr) : null;
		
		    // 조건 하나라도 있으면 검색
		    if (subjectName != null || isDaytime != null || yearLevelStr != null) {
		        lectures = subjectDAO.searchLecture(profId, isDaytime, yearLevel, subjectName);
		    } else {
		    	lectures = subjectDAO.attSel(profId, currentPage, pageSize);
		    }
		} 
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
	                <td class="middleTD">최대<br>수강인원</td>
	                <td class="middleTD">현재<br>수강인원</td>
	                <td></td>
	            </tr>
	            <%
	            int count = (currentPage - 1) * pageSize + 1;  // 강의 번호
	        	for (SubjectDTO lecture : lectures) {  // 강의 목록을 테이블에 출력
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
	          		<form action="./Professor/Professor_Grade_Select.jsp" method="get">
		                <input type="hidden" name="subjectId" value="<%= lecture.getSubjectId() %>">
		                <%-- <input type="hidden" name="roomId" value="<%= lecture.getRoomId() %>"> --%>
		                <input type="hidden" name="profId" value="<%= lecture.getProfId() %>">
		                <button type="submit">성적관리</button>
	                </form>
	                </td>
		        </tr>
		        <%
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
	                <a href="./Professor/Professor_Grade.jsp?page=<%= prevPage %>" class="page-nav">&laquo;</a>
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
	                <a href="./Professor/Professor_Grade.jsp?page=<%= i %>" class="paging"><%= i %></a>
	            <%
	                }
	            }
	
	            // 다음 10단위로 이동
	            if (nextPage <= totalPages) {
	            %>
	                <a href="./Professor/Professor_Grade.jsp?page=<%= nextPage %>" class="page-nav">&raquo;</a>
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
