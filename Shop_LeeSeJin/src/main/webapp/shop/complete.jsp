<%@page import="shop.dao.ProductRepository"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductIORepository"%>
<%@page import="shop.dto.Order"%>
<%@page import="shop.dao.OrderRepository"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문 완료 페이지</title>
	
<jsp:include page="/layout/meta.jsp" />
<jsp:include page="/layout/link.jsp" />

<%
	String root = request.getContextPath();	

	String shipName = request.getParameter("shipName");
	String date = request.getParameter("date");
	String country = request.getParameter("country");
	String zipCode = request.getParameter("zipCode");
	String address = request.getParameter("address");
	String phone = request.getParameter("phone");
	String orderPw = request.getParameter("orderPw"); // 비회원일 경우 입력되는 비밀번호
	
	// 필수 값 체크 (예시)
	if (shipName == null || date == null || country == null || zipCode == null || address == null) {
	    out.println("<script>alert('모든 필드를 입력해 주세요.'); history.back();</script>");
	    return;
	}
	
	// DB 저장 또는 주문 처리 로직 추가
	Order order = new Order();
	order.setShipName(shipName);
	order.setDate(date);
	order.setCountry(country);
	order.setZipCode(zipCode);
	order.setAddress(address);
	order.setPhone(phone);
	order.setOrderPw(orderPw);
	
	OrderRepository orderDAO = new OrderRepository();
	orderDAO.insert(order);
	
    psmt.setString(1, product.getProductId()); // 상품 ID
    psmt.setObject(2, product.getOrderNo()); // 주문 번호 (nullable)
    psmt.setInt(3, product.getAmount()); // 입출고량
    psmt.setString(4, product.getType()); // 입출고 타입
    psmt.setString(5, product.getUserId()); // 사용자 ID (nullable)
    
    ProductRepository productDAO = ProductRepository();
    Product product = productDAO.list(shipName);
    product.setProductId(productId)
    
	ProductIORepository productioDAO = new ProductIORepository();
	productioDAO.insert(product);
%>

</head>
<body>
<jsp:include page="/layout/header.jsp" />

<div class="px-4 py-5 my-5 text-center d-flex flex-column gap-5 align-items-center">
	<h1 class="display-5 fw-bold text-body-emphasis">주문 완료</h1>
	<h2>주문이 정상적으로 완료되었습니다.</h2>
</div>

<%
	int orderNo = orderDAO.lastOrderNo();
%>

<div class="container shop">
	<div class="d-flex border-bottom py-2" >
		<div class="d-flex justify-content-between" style="width: 150px;"><span>주문번호</span><span>:</span></div>
		<span style="width: 542px; text-align: center;"><%= orderNo %></span>
	</div>
	<div class="d-flex border-bottom py-2" >
		<div class="d-flex justify-content-between" style="width: 150px;"><span>배송지</span><span>:</span></div>
		<span style="width: 542px; text-align: center;"><%= order.getAddress() %></span>
	</div>
	<div class="d-flex justify-content-center my-5">
		<button type="button" class="btn btn-primary" onclick="location.href='<%= root %>/user/order.jsp'">주문내역</button>
	</div>
</div>

</body>
</html>