<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="./css/index.css">
</head>

<body onload="errorChk()">
    <div id="LoginDiv">
    <form id="loginForm" action="" method="post">
        <table>
            <colgroup></colgroup>

            <thead>
                <tr>
                    <td colspan="2" width="300px" height="200px" align="center"><img
                            src="./img/LoginImgFolder/indukLogo.svg"></td>
                </tr>
            </thead>

            <tbody>
                <tr>
                    <td colspan="2"><input type="text" name="id" placeholder="학번 또는 아이디"></td>
                </tr>

                <tr>
                    <td colspan="2"><input type="password" name="pwd" placeholder="비밀번호"></td>
                </tr>

                <tr id="LoginTypeSelect">
                    <td><input type="button" class="button active" value="학생" id="studentButton"
                            onclick="selectButton('studentButton')"></td>
                    <td><input type="button" class="button" value="교수" id="professorButton"
                            onclick="selectButton('professorButton')"></td>
                </tr>
            </tbody>

            <tfoot>
                <tr>
                    <td colspan="2"><input type="submit" class="button" value="로그인" id="loginButton" onclick="login()">
                    </td>
                </tr>
            </tfoot>
        </table>
	</form>
    </div>
</body>
<script>
        let activeButton = 'student';
        const studentButton = document.getElementById('studentButton');
        const professorButton = document.getElementById('professorButton');
        const loginForm = document.getElementById('loginForm');
        function selectButton(type) {
            if (type === 'studentButton') {
                if (activeButton !== 'student') {
                    studentButton.classList.add('active');
                    professorButton.classList.remove('active');
                    activeButton = 'student';
                }
            }
            else if (type === 'professorButton') {
                if (activeButton !== 'professor') {
                    professorButton.classList.add('active');
                    studentButton.classList.remove('active');
                    activeButton = 'professor';
                }
            }
        }

        function login() {
            if (activeButton == 'student') {
    	    	loginForm.action = './Student_Login.jsp';
            }
            if (activeButton == 'professor') {
            	loginForm.action = './Professor_Login.jsp';
            }
        }
        
        function errorChk() {
        	<%String error = request.getParameter("error");%>
        	let error = '<%=error != null ? error : ""%>';
    		if(error) alert('ID 혹은 Password가 틀립니다!');
        }
</script>
</html>