<%@page import="Model.DepartmentDAO"%>
<%@page import="Model.ProfessorDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%
	request.setCharacterEncoding("utf-8");
	HttpSession studentSession = request.getSession();
	ProfessorDTO professorDTO = (studentSession != null) ? (ProfessorDTO) studentSession.getAttribute("userDTO") : null;
	
	/* String content = request.getParameter("category");
	if(content != null) {
		
	} else {
		content = "./Professor/Professor_Lecutre.jsp";
	} */
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ProfessorMain</title>
    <link rel="stylesheet" href="../css/studentMain.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../JS/MainJS.js"></script>
    <script>
        $(document).ready(function() {
            // 페이지 로드 시 자동으로 첫 페이지 로드
            loadPage("./Professor/Professor_Lecture.jsp", "수강 관리");
        });

        // 페이지를 동적으로 로드하는 함수
        function loadPage(pageUrl, title) {
            $("#sectionHeader #title").text(title);  // 페이지 제목 변경
            $("#includeDIV").load(pageUrl);  // 해당 URL을 포함된 div에 로드
        }
        
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
    <div id="wrapper">
        <div id="sideMenuBar">
            <table>
                <tr>
                    <td><img src="../img/LoginImgFolder/indukLogo.svg" alt="로고 Or 아이콘"></td>
                </tr>
                <tr class="menu" onclick="loadPage('./Professor/Professor_Board.jsp', '공지 사항')">
                    <td>공지 사항</td>
                </tr>
                <tr class="menu" onclick="loadPage('./Professor/Professor_Lecture.jsp', '강의 관리')">
                    <td>강의 관리</td>
                </tr>
                <tr class="menu" onclick="loadPage('./Professor/Professor_Grade.jsp', '성적 관리')">
                    <td>성적 관리</td>
                </tr>
                <tr class="menu" onclick="loadPage('./Professor/Professor_Attendance.jsp', '출결 관리')">
                    <td>출결 관리</td>
                </tr>
                <tr class="menu" onclick="loadPage('./Professor/Professor_Profile.jsp', '개인 정보 조회')">
                    <td>개인 정보 조회</td>
                </tr>
            </table>
        </div>
        <section id="contentDIV">
            <header id="sectionHeader">
                <table>
                    <tr id="tabBarSpace">
                    </tr>
                    <tr id="userNameSpace">
                    	<td id="helloUserTD">
                        	<div id="helloUserText">안녕하세요 <%=professorDTO.getProf_name() %>님</div>
                        	<div><img id="logoutImg" src="../img/logout.png" onclick="location.href='Logout.jsp'"></div>
                        </td>
                    </tr>
                </table>
            </header>
            <div id="includeDIV">
            	<script>loadPage('./Professor/Professor_Lecture.jsp', '강의 관리')</script>
            </div>
            <!-- <iframe id="contentFrame" name="content" src="./Professor/Professor_Lecutre.jsp"></iframe> -->
        </section>
    </div>
</body>
</html>