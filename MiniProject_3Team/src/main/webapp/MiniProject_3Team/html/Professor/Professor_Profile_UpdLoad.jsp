<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Professor_Profile_UpdLoad</title>
</head>
<body>
<%
    // 세션에서 교수 정보 가져오기
    request.setCharacterEncoding("UTF-8");
    HttpSession professorSession = request.getSession();
    
    int profId = Integer.parseInt(request.getParameter("prof_id"));
    int deptId = Integer.parseInt(request.getParameter("dept_id"));
    String name  = request.getParameter("prof_name");
    String etc   = request.getParameter("etc");
    String bdStr = request.getParameter("birthdate");
    String phone = request.getParameter("phone");
    String addr  = request.getParameter("address");
    String email = request.getParameter("email");
	
    // 생일 데이터 변경
    java.sql.Date sqlBirth = null;
    if (bdStr != null && !bdStr.isEmpty()) {
        try {
            if (bdStr.length() == 8) {
                bdStr = bdStr.substring(0, 4) + "-" + bdStr.substring(4, 6) + "-" + bdStr.substring(6, 8);
            }
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dateBD = sdf.parse(bdStr);
            sqlBirth = new java.sql.Date(dateBD.getTime());
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    // DAO 호출하여 업데이트된 교수 정보 받기
    ProfessorDAO dao = ProfessorDAO.getInstance();
    ProfessorDTO updated = dao.proUpd(profId, deptId, name, etc, sqlBirth, phone, addr, email);
    
    if (updated != null) {
        // 세션에 갱신된 교수 정보 저장
        professorSession.setAttribute("userDTO", updated);
        out.println("교수 정보가 성공적으로 업데이트되었습니다.");
    %>
    <script>
		history.back();
	</script>
    <% 
    } else {
        out.println("교수 정보 업데이트에 실패했습니다.");
    }
%>
</body>
</html>
