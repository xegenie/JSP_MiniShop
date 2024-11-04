<%@page import="shop.dto.User"%>
<%@page import="shop.dao.ProductRepository"%>
<%@page import="shop.dto.Product"%>
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
	<title>상품 정보 페이지</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
	<script src="https://kit.fontawesome.com/6aaa685e44.js"></script>
<% 
	String root = request.getContextPath();

	String productId = request.getParameter("pNo");
	ProductRepository productDAO = new ProductRepository();	
	Product product =  productDAO.getProductById(productId);
	
	User user = (User) session.getAttribute("loginUser");
	String cartId; 
	if ( user != null ) {
		cartId = user.getId();
	} else {
		cartId = "guest";
	}
%>
</head>
<body>
	<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="container text-center mt-5 d-flex flex-column gap-2" style="height: 1200px;">

	<h1 class="fw-bold">상품 정보</h1>
	<p>Shop 쇼핑몰 입니다.</p>
	<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
		<button type="button" onclick="location.href='products.jsp'" class="btn btn-primary">상품 목록</button>
	</div>

	<div class="border row my-4 p-5">
 		<c:set var="item" value="<%= product %>" />
 		<div class="col-md-6">
     			<img src="<%= root %>/shop/img?id=${ item.productId }" class="img-fluid rounded-start p-5" alt="" style="width: 100%; max-height: 600px; object-fit: cover;">
  		</div>
   		<div class="col-md-6">
      		<div class="m-5">
		        <span class="d-flex fs-3 pb-5">${ item.name }</span>
		 		
		 		<div class="d-flex border-bottom py-2" >
		 			<div class="d-flex justify-content-between" style="width: 150px;"><span>상품 ID</span><span>:</span></div>
		 			<span style="width: 350px;">${ item.productId }</span>
		 		</div>
		 		<div class="d-flex border-bottom py-2" >
		 			<div class="d-flex justify-content-between" style="width: 150px;"><span>제조사</span><span>:</span></div>
		 			<span style="width: 350px;">${ item.manufacturer }</span>
		 		</div>
		 		<div class="d-flex border-bottom py-2" >
		 			<div class="d-flex justify-content-between" style="width: 150px;"><span>분류</span><span>:</span></div>
		 			<span style="width: 350px;">${ item.category }</span>
		 		</div>
		 		<div class="d-flex border-bottom py-2" >
		 			<div class="d-flex justify-content-between" style="width: 150px;"><span>상태</span><span>:</span></div>
		 			<span style="width: 350px;">${ item.condition }</span>
		 		</div>
		 		<div class="d-flex border-bottom py-2" >
		 			<div class="d-flex justify-content-between" style="width: 150px;"><span>재고 수</span><span>:</span></div>
		 			<span style="width: 350px;">${ item.unitsInStock }</span>
		 		</div>
		 		<div class="d-flex border-bottom py-2" >
		 			<div class="d-flex justify-content-between" style="width: 150px;"><span>가격</span><span>:</span></div>
		 			<span style="width: 350px;">
		 				<script>
		 					var unitPrice = ${ item.unitPrice };
		 					document.write((unitPrice).toLocaleString('ko-KR'));
		 				</script> 원
		 			</span>
		 		</div>
    		</div>
    		
	   		<div class="btnlist d-flex justify-content-evenly align-items-center">
                 <a href="addCart.jsp?pNo=${ item.productId }">
                     <button class="btn btn-outline-primary icon"><i class="fa-solid fa-cart-shopping"></i></button>
                 </a>
		   		<button type="button" onclick="location.href='cart.jsp'" class="btn btn-primary cartbtn">장바구니</button>
		   		<button type="button" onclick="processOrder('${ item.productId }')" class="btn btn-primary orderbtn">주문하기</button>
	   		</div>
   		</div>
	</div>
	
</div>
</body>

<script>
	function processOrder(productId) {
	    // 확인 창을 먼저 표시합니다.
	    if (confirm('장바구니로 이동하시겠습니까?')) {
	        // 사용자가 확인하면 addCart.jsp로 이동하면서 productId를 전달합니다.
	        location.href = 'cart_pro.jsp?pNo=' + productId;
	    }
	}
</script>

<style>

	.cartbtn {
	    border: 1px solid rgb(219, 116, 32);
	    background: rgb(219, 116, 32);
	    width: 140px;
	    height: 45px;
	}
	
	.cartbtn:hover {
	    background-color: rgb(190, 103, 31);
	    border: 1px solid rgb(190, 103, 31);
	}
	
	.orderbtn {
	    background-color: green;
	    border: 1px solid green;
	    width: 140px;
	    height: 45px;
	}
	
	.orderbtn:hover {
	    background-color: rgb(0, 90, 0);
	    border: 1px solid rgb(0, 90, 0);
	}
</style>

</html>