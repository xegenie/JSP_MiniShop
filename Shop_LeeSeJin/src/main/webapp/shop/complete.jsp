<%@page import="shop.dto.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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

	String cartId = request.getParameter("cartId");
	List<Product> cart = new ArrayList<Product>();
	
	User user = null;
	String userId = "";
	
	if ( cartId.equals("guest") ) {
		cart = (List<Product>) session.getAttribute("cart");
	} else {
		user = (User) session.getAttribute("loginUser");
		cart = (List<Product>) session.getAttribute("userCart");
		userId = user.getId();
	}
	

	String shipName = request.getParameter("shipName");
	String zipCode = request.getParameter("zipCode");
	String country = request.getParameter("country");
	String address = request.getParameter("address");
	String date = request.getParameter("date");
	String orderPw = request.getParameter("orderPw");
	String phone = request.getParameter("phone");
	
	Integer totalPrice = (Integer) session.getAttribute("totalPrice");
// 	int totalPrice = (totalPriceObj != null) ? totalPriceObj : 0; // 오류방지
	
	List<Integer> quantity = (List<Integer>) session.getAttribute("quantities");
    // 오류 방지
//     if (quantity == null) {
//     	quantity = new ArrayList<>(); // 빈 리스트로 초기화
//     }
	
	if (shipName == null || shipName.trim().isEmpty() || 
	   	    date == null || date.trim().isEmpty() ||
	     country == null || country.trim().isEmpty() ||
	     zipCode == null || zipCode.trim().isEmpty() ||
	     address == null || address.trim().isEmpty()) {
		
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
	order.setTotalPrice(totalPrice);
	order.setOrderPw(orderPw);
	order.setUserId(userId);
	
	OrderRepository orderDAO = new OrderRepository();
	orderDAO.insert(order);
	
	int orderNo = orderDAO.lastOrderNo(); // 방금 저장한 주문 번호 가져오기
	
    // 각 상품에 대해 주문 처리
    for (int i = 0; i < cart.size(); i++) {
        Product product = cart.get(i); // 장바구니에서 상품 가져오기
        int quantityValue = (i < quantity.size()) ? quantity.get(i) : 0; // 각 상품의 수량 가져오기, 기본값 0 설정

        // Product 객체에 값 설정
        product.setProductId(product.getProductId());
        product.setOrderNo(orderNo);
        product.setAmount(quantityValue);
        product.setType("OUT"); // 입출고 타입 설정
        product.setUserId(user != null ? user.getId() : null); // 비회원일 경우 null 설정
		
        product.setUnitsInStock(product.getUnitsInStock() - quantityValue);
        // 상품 입출고 기록 저장
        ProductIORepository productioDAO = new ProductIORepository();
        productioDAO.insert(product);
        // 재고 감소
        ProductRepository productDAO = new ProductRepository();
        productDAO.update(product);
    }
	
	// 장바구니 삭제
	
	 if (user != null) {
	     session.removeAttribute("userCart"); // 로그인된 사용자 장바구니 삭제
	 }
	 // 비회원
	 else {
	     session.removeAttribute("cart"); // 비회원 장바구니 삭제
	 }
%>

</head>
<body>
<jsp:include page="/layout/header.jsp" />

<div class="px-4 py-5 my-5 text-center d-flex flex-column gap-5 align-items-center">
	<h1 class="display-5 fw-bold text-body-emphasis">주문 완료</h1>
	<h2>주문이 정상적으로 완료되었습니다.</h2>
</div>

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