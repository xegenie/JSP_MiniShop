<%@page import="shop.dto.User"%>
<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>성공 페이지</title>
    <jsp:include page="/layout/meta.jsp" /> 
    <jsp:include page="/layout/link.jsp" />
</head>
<body>
    <%
        String root = request.getContextPath();
    
        // msg가 0일 때 로그인 성공 메시지 출력
        if ("0".equals(request.getParameter("msg"))) {
    
    	String id = (String) session.getAttribute("loginId");
    	
    	UserRepository userDAO = new UserRepository();
    	User user = userDAO.getUserById(id);
		String username = user.getName();    	// 회원 이름
    %>
        <div class="px-4 py-5 my-5 text-center d-flex flex-column gap-5 align-items-center">
            <h1 class="display-5 fw-bold text-body-emphasis">로그인 성공</h1>
            <h2>'<%= username %>'님 환영합니다!</h2>
            <a href="<%= root %>/index.jsp" class="btn btn-primary btn-lg" style="width: 204.41px;">메인 페이지로 이동</a>
        </div>
    <%
        }
        
        // msg가 1일 때 회원가입 완료 메시지 출력
        if ("1".equals(request.getParameter("msg"))) {
    %>
        <div class="px-4 py-5 my-5 text-center d-flex flex-column gap-5 align-items-center">
            <h1 class="display-5 fw-bold text-body-emphasis">회원가입 완료</h1>
            <h2>환영합니다! 성공적으로 회원가입하셨습니다.</h2>
            <a href="login.jsp" class="btn btn-primary btn-lg">로그인 화면으로 이동</a>
        </div>
    <%
        }
    %>
    
    
    <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" />
</body>
</html>
