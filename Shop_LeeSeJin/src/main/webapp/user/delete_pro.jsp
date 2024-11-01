<%@page import="shop.dto.User"%>
<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String root = request.getContextPath();	

	User user = (User) session.getAttribute("loginUser");	

    UserRepository userDAO = new UserRepository();
    int result = 0;
	result = userDAO.delete(user.getId());

	if (result > 0) {
%>
	<script>
		alert('탈퇴 완료!');
		location.href="logout.jsp";
	</script>
<%
	} else {
%>
	<script>
		alert('탈퇴 실패, 다시 시도해 주십시오.');
		location.href="update.jsp";
	</script>
<%
	}
%>
