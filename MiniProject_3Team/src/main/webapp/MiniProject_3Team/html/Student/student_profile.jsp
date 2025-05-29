<%@page import="Model.DepartmentDAO"%>
<%@page import="Model.ProfessorDAO"%>
<%@page import="Model.StudentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	request.setCharacterEncoding("utf-8");
	HttpSession studentSession = request.getSession();
	StudentDTO studentDTO = (studentSession != null) ? (StudentDTO) studentSession.getAttribute("userDTO") : null;
	
	DepartmentDAO departmentDAO = DepartmentDAO.getInstance();
	String deptName = departmentDAO.getDepartmentName(studentDTO.getDept_id());
	
	ProfessorDAO professorDAO = ProfessorDAO.getInstance();
	String profName = professorDAO.getProfName(studentDTO.getProf_id());
	
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학생 개인정보 조회/수정</title>
    <link rel = "stylesheet" href="../css/studentProfileCss.css">
    <script src = "../JS/studentJS.js"></script>
</head>
<body>
    <div id = "wrap">
        <table class = "outTable" 
        align = "center">
            <tr>
                <td class = "outTd">
                    <!-- <button type="button" onclick="loadData()">불러오기</button> -->
	                <form id="profileForm" action="./Student/student_profile_update.jsp" method="post">
		                <button type="submit" onclick="saveData()" class = "buttonSave">저장하기</button>
		                    <table align = "center">
		                        <tr>
		                            <td rowspan="5" width = "150px">
		                                <img id="profileImage" src="" alt="이미지 없음" 
		                                style="display: none; width: 100%; height: 100%; object-fit: cover;"
		                                onclick="document.getElementById('imageInput').click();"> <!-- 이미지가 있더라도 기존 이미지 눌렀을 시 수정 가능 -->
		                                <button id="imageBtn" onclick="document.getElementById('imageInput').click();" style="display: block; width: 100%; height: 100%;">이미지 추가</button>
		                                <input type="file" id="imageInput" style="display: none;" onchange="loadImage(event)">
		                            </td>
		                            <td width = "100px" class = "text-center">학번<span class = "required">*</span></td>
		                            <td class = "text-left">
		                                <input type = "text" id = "hakbun" name = "hakbun" class = "input-field" 
		                                style="background-color: lightgray;" value = "<%=studentDTO.getStudent_id()%>" readonly>
		                            </td>
		                        </tr>
		                        <tr>
		                            <td class = "text-center">학과<span class = "required">*</span></td>
		                            <td class = "text-left">
		                                <input type = "text" id = "major" name = "major"  class = "input-field" 
		                                style="background-color: lightgray;" value="<%=deptName%>" readonly>
		                            </td>
		                        </tr>
		                        <tr>
		                            <td class = "text-center">이름<span class = "required">*</span></td>
		                            <td class = "text-left">
		                                <input type = "text" id = "name" name = "name" class = "input-field" value="<%=studentDTO.getStudent_name()%>"></td>
		                        </tr>
		                        <tr>
		                            <td class = "text-center">과정<span class = "required">*</span></td>
		                            <td class = "text-left">
		                                <input type = "text" id = "course" name = "course" class = "input-field" 
		                                style="background-color: lightgray;" value="<%=studentDTO.getMajor_type()%>" readonly></td>
		                        </tr>
		                        <tr>
		                            <td class = "text-center">기타</td>
		                            <td class = "text-left">
		                                <input type = "text" id = "etc" name = "etc" class = "input-field" value="<%=studentDTO.getEtc()%>">
		                            </td>
		                        </tr>
		                    </table>
		                    <br>
		                    <table align = "center">
		                        <tr>
		                            <td width = "150px" class = "text-center">생년월일<span class = "required">*</span></td>
		                            <td class = "text-left">
		                                <input type = "text" id = "birthDate" name = "birthDate" class = "input-field" value="<%=studentDTO.getBirthdate()%>">
		                            </td>
		                        </tr>
		                        <tr>
		                            <td class = "text-center">전화번호<span class = "required">*</span></td>
		                            <td class = "text-left">
		                                <input type = "text" id = "phoneNumber" name = "phoneNumber" class = "input-field" value="<%=studentDTO.getPhone()%>">
		                            </td>
		                        </tr>
		                        <tr>
		                            <td class = "text-center">주소<span class = "required">*</span></td>
		                            <td class = "text-left">
		                                <input type = "text" id = "address" name = "address" class = "input-field" value="<%=studentDTO.getAddress()%>">
		                            </td>
		                        </tr>
		                        <tr>
		                            <td class = "text-center">E-mail</td>
		                            <td class = "text-left">
		                                <input type = "text" id = "email" name = "email" class = "input-field" value="<%=studentDTO.getEmail()%>">
		                            </td>
		                        </tr>
		                        <tr>
		                            <td class = "text-center">지도교수<span class = "required">*</span></td>
		                            <td class = "text-left">
		                                <input type = "text" id = "advisor" name = "advisor" class = "input-field" 
		                                style="background-color: lightgray;" value="<%=profName%>" readonly>
		                            </td>
		                        </tr>
		                    </table>
		            	<span class = "required" style="color: black; float: right;"> *은 필수 입력칸 입니다. </span>
                    </form>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>