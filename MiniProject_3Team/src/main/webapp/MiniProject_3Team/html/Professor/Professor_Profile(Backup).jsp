<%@page import="Model.DepartmentDAO"%>
<%@page import="Model.ProfessorDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%
	request.setCharacterEncoding("utf-8");
	HttpSession professorSession = request.getSession();
	ProfessorDTO professorDTO = (professorSession != null) ? (ProfessorDTO) professorSession.getAttribute("userDTO") : null;
	DepartmentDAO departmentDAO = DepartmentDAO.getInstance();
	String deptName = departmentDAO.getDepartmentName(professorDTO.getDept_id());
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <style>
        /* 전체 스타일 */
        * {
            box-sizing: border-box;
        }

        #wrap {
            /* width: 1340px; */
            width: 100%;
            max-width: 1121px;
            margin: auto;
            text-align: left;
            position: relative; /* 버튼의 절대 위치 기준 */
            padding-top: 70px; /* 버튼과 표 사이 간격 확보 */
        }

        #Professor_table {
            border-collapse: collapse;
            width: 100%;
            margin: 0 auto;
            border: 1px solid black;
            position: relative;
            background-color: rgb(247, 246, 222);
        }

        #Professor_table td {
            padding: 8px;
            border: 1px solid black;
        }

        button {
            width: 100px;
            height: 50px;
            font-size: medium;
            position: absolute; /* 절대 위치 설정 */
            top: 10px; /* 버튼을 wrap 기준 위쪽에 배치 */
            right: 70px; /* 표의 오른쪽 끝에 배치 */
            background-color: rgb(214, 237, 245);
            font-weight: bold;
            cursor: pointer;
        }

        button:hover{
            background-color: steelblue;
        }

        /* 학번, 학과, 이름, 기타의 셀 크기 조정 */
        #Professor_table td.small-cell {
            width: 80px;  /* 너비 설정 */
            text-align: center; 
            font-weight: bold;
        }

        /* 생년월일, 전화번호, 주소, 이메일의 텍스트만 가운데 정렬 */
        #Professor_table td.center-text {
            text-align: center;
            font-weight: bold;
        }

        /* 이미지 크기 조정 */
        #Professor_table img {
            width: 300px;  
            height: auto; 
            display: block;
        }

        #Professor_table td[rowspan] {
            width: 300px;  
        }
    </style>
    <script>
        function save() {
            alert("프로필이 저장되었습니다."); // 알림창 표시
        }
    </script>
</head>
<body>
    <div id="wrap">
        <button onclick="save()">저장하기</button>
        <table id="Professor_table">
            <tr>
                <td rowspan="4"><img src="../img/professor.png"></td>
                <td class="small-cell">교번</td>
                <td><%=professorDTO.getProf_id() %></td>
            </tr>
            <tr>
                <td class="small-cell">학과</td>
                <td><%=deptName %></td>
            </tr>
            <tr>
                <td class="small-cell">이름</td>
                <td><%=professorDTO.getProf_name() %></td>
            </tr>
            <tr>
                <td class="small-cell">기타</td>
                <td><%=professorDTO.getEtc() %></td>
            </tr>
            <tr>
                <td class="center-text">생년월일</td>
                <td colspan="2"><%=professorDTO.getBirthdate() %></td>
            </tr>
            <tr>
                <td class="center-text">전화번호</td>
                <td colspan="2"><%=professorDTO.getPhone() %></td>
            </tr>
            <tr>
                <td class="center-text">주소</td>
                <td colspan="2"><%=professorDTO.getAddress() %></td>
            </tr>
            <tr>
                <td class="center-text">이메일</td>
                <td colspan="2"><%=professorDTO.getEmail() %></td>
            </tr>
        </table>
    </div>
    
</body>
</html>