<!-- 
	회원 가입 처리
 -->
<%@page import="javax.websocket.SendResult"%>
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	User user = new User();

	// 파라미터 값 가져오기
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String pwConfirm = request.getParameter("pw_confirm");
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
	
    user.setId(id);
    user.setPassword(pw);
    user.setName(name);
    user.setGender(gender);
    user.setBirth(birth);
    user.setMail(email);
    user.setPhone(phone);
    user.setAddress(address);
	
    
    // 회원 등록
    UserRepository userDAO = new UserRepository();
    
    int check = 0;
    int insert = 0;
    
    check = userDAO.checkId(id);
    
    if (check > 0) {
%>
   	<script>
   	    alert('이미 사용 중인 아이디입니다.');
   	    location.href="join.jsp?error";
   	</script>
<%
    } else if (!pw.equals(pwConfirm)) { // 비밀번호 확인 검사
%>
   	<script>
   	    alert('비밀번호가 일치하지 않습니다.');
   	    location.href="join.jsp?error";
   	</script>
<%
    } else if (check == 0) {
   	        insert = userDAO.insert(user);
    }
    
    if ( insert > 0 ) {
    	response.sendRedirect("complete.jsp?msg=1");
    }
%>
    

    
    
    
    
    
    