<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*, java.util.*, Model.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    int subjectId = 0;
    int profId = 0;
    String message = "";
    String redirectUrl = "./Professor_Lecture.jsp";

    try {
        if (request.getParameter("subjectId") != null) {
            subjectId = Integer.parseInt(request.getParameter("subjectId"));
        }

        if (request.getParameter("profId") != null) {
            profId = Integer.parseInt(request.getParameter("profId"));
        }

        // 삭제 처리
        if (subjectId != 0) {
            SubjectDAO subjectDAO = SubjectDAO.getInstance();
            int result = subjectDAO.DelSubject(subjectId, profId);

            if (result > 0) {
                message = "강의가 성공적으로 삭제되었습니다.";
            } else {
                message = "강의 삭제에 실패했습니다.";
            }
        } else {
            message = "올바르지 않은 요청입니다.";
        }

    } catch (Exception e) {
        e.printStackTrace();
        message = "오류 발생: " + e.getMessage();
    }

    // 알림 및 리다이렉트 처리
%>

<script>
    alert("<%= message %>");
    history.back();
</script>
