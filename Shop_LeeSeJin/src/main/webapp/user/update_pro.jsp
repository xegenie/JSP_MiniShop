<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 파라미터 값 가져오기
String id = request.getParameter("id");
String pw = request.getParameter("pw");
String pwConfirm = request.getParameter("pw_confirm"); // 비밀번호 확인 필드 추가
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

// 비밀번호 확인 검사 추가
if (!pw.equals(pwConfirm)) {
%>
<script>
    alert('비밀번호가 일치하지 않습니다.');
    history.back(); // 다시 수정 페이지로 이동
</script>
<%
} else {
    int result = userDAO.update(user);
    
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
}
%>
