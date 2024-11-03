<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 로그인된 사용자의 경우
    User user = (User)session.getAttribute("loginUser");

    if (user != null) {
        session.removeAttribute("userCart"); // 로그인된 사용자 장바구니 삭제
    }
    // 비회원
    else {
        session.removeAttribute("cart"); // 비회원 장바구니 삭제
    }

    // 사용자가 장바구니가 비워졌다는 알림을 보여주기
    out.println("<script>alert('장바구니가 비워졌습니다.'); location.href='cart.jsp';</script>");
%>
