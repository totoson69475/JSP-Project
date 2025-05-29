<%@page import="Model.StudentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StudentMain</title>
    <link rel="stylesheet" href="../css/studentMain.css">
    <script src = "../JS/studentJS.js"></script>
    <script src="../JS/MainJS.js"></script>
</head>
<%
	request.setCharacterEncoding("utf-8");
	HttpSession studentSession = request.getSession();
	StudentDTO studentDTO = (studentSession != null) ? (StudentDTO) studentSession.getAttribute("userDTO") : null;
	
	
%>

<body>
    <div id="wrapper">
        <div id="sideMenuBar">
            <table>
                <tr>
                    <td><img src="../img/LoginImgFolder/indukLogo.svg" alt="로고 Or 아이콘"></td>
                </tr>
                <tr class="menu" onclick="loadPage('./Student/student_lecture.jsp', '수강 신청')">
                    <td>수강 신청</td>
                </tr>
                <tr class="menu" onclick="loadPage('./Student/student_grade.jsp', '성적 조회')">
                    <td>성적 조회</td>
                </tr>
                <tr class="menu" onclick="loadPage('./Student/student_attendance.jsp', '출결 조회')">
                    <td>출결 조회</td>
                </tr>
                <tr class="menu" onclick="loadPage('./Student/student_profile.jsp', '개인 정보 조회')">
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
                        	<div id="helloUserText">안녕하세요 <%=studentDTO.getStudent_name()%>님</div>
                        	<div><img id="logoutImg" src="../img/logout.png" onclick="location.href='Logout.jsp'"></div>
                        </td>
                    </tr>
                </table>
            </header>
            <div id="includeDIV">
            <%-- <jsp:include page="<%=content%>"/> --%>
            </div>
            <!-- <iframe id="contentFrame" name="content" src="./Student/student_lecture.jsp"></iframe> -->
        </section>
    </div>
</body>
</html>