<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 파라미터 값 가져오기
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	
	// 생일을 하나의 String으로 결합
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String birth = year + "-" + month + "-" + day;
	
	// 이메일을 하나의 String으로 결합
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String email = email1 + "@" + email2;
	
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	
	 // 회원정보 수정
    UserRepository userDAO = new UserRepository();
	
	User user = new User();
	user.setId(id);
	user.setPassword(pw);
	user.setName(name);
	user.setGender(gender);
	user.setBirth(birth);
	user.setMail(email);
	user.setPhone(phone);
	user.setAddress(address);
	
    int result = 0;
    result = userDAO.update(user);
    
	if (result > 0) {
%>
	<script>
	  		alert('회원정보 수정 성공!');
	 		location.href="index.jsp";
	</script>
<%
	} else {
        response.sendRedirect("update.jsp");
	}
%>
