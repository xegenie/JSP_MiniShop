<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.OrderRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();

	// 비회원인 경우
	String orderPhone = request.getParameter("phone");
	String orderPw = request.getParameter("orderPw");
	
	// 주문내역
	OrderRepository orderDAO = new OrderRepository();
	List<Product> orderList = orderDAO.list(orderPhone, orderPw); 

	// 비회원 주문 내역 세션에 등록 처리
	session.setAttribute("orderList", orderList);
	
	response.sendRedirect(root + "/user/order.jsp");

%>