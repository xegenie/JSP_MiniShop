<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
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
	<title>장바구니 페이지</title>
<%
	User user = (User) session.getAttribute("loginUser");

	List<Product> cart = (List<Product>) session.getAttribute("cart");

	List<Product> userCart = (List<Product>) session.getAttribute("userCart");
	
	String cartId; 
	if ( user != null ) {
		cartId = user.getId();
	} else {
		cartId = "guest";
	}
%>


	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>
<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">장바구니 목록 입니다.</p>
		</div>
	</div>
	
	<!-- 장바구니 영역 -->
	<div class="container order">
	<!-- 장바구니 목록 -->
	<table class="table table-striped table-hover table-bordered text-center align-middle">
	    <thead>
	        <tr class="table-primary">
	            <th>상품</th>
	            <th>가격</th>
	            <th>수량</th>
	            <th>소계</th>
	            <th>비고</th>
	        </tr>
	    </thead>
	    <tbody>
	        <c:set var="totalPrice" value="0" />
<%
	boolean userExists = (user != null && !user.toString().isEmpty());
	List<Product> cartList = userExists ? userCart : cart; // userCart 또는 cart를 선택합니다.
	int totalPrice = 0; // 총 가격 초기화
	List<Integer> quantities = new ArrayList<>();
	
	if (cartList != null) {
		for (Product list : cartList) {
%>
		    <tr>
		        <td><%= list.getName() %></td>            
		        <td><%= list.getUnitPrice() %></td>            
		        <td><%= list.getQuantity() %></td>
		        <td><%= list.getUnitPrice() * list.getQuantity() %></td>
		        <td>
	                <button type="button" class="btn btn-primary deletebtn" onclick="deleteFromCart('<%= list.getProductId() %>')">삭제</button>
		        </td>
		    </tr>
<%		
        	totalPrice += list.getUnitPrice() * list.getQuantity(); // 총 가격 계산
        	quantities.add(list.getQuantity());
    	}
	}
	session.setAttribute("totalPrice", totalPrice);
	System.out.println("Quantities before saving: " + quantities);
	session.setAttribute("quantities", quantities);
%>
	    </tbody>
	    <tfoot>
<%
    if (totalPrice != 0) {
%>
	        <tr>
	            <td></td>
	            <td></td>
	            <td>총액</td>
	            <td><%= totalPrice %></td>
	            <td></td>
	        </tr>
<%
    } else {
%>
	        <tr>
	            <td colspan="5" style="text-align: center;">등록된 상품이 없습니다.</td>
	        </tr>
<%
    }
%>

   		</tfoot>
	</table>

	
		<!-- 버튼 영역 -->
		<div class="d-flex justify-content-between align-items-center p-3">
			<a href="deleteCart.jsp" class="btn btn-lg btn-danger ">전체삭제</a>

			<button type="submit" class="btn btn-lg btn-primary" onclick="order()">주문하기</button>
		</div>
	</div>
	
<footer class="container p-5">
	<p>copyright Shop</p>
</footer>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<!-- <script src="../static/js/validation.js"></script> -->			<!-- 상대경로 -->
	<!-- 절대경로 -->
<script src="/Shop/static/js/validation.js"></script>



	
<script>
	// 장바구니 상품 개수 및 총 가격
	let cartId = "<%= cartId %>";
	let cartCount = <%= (cartList != null ? cartList.size() : 0) %>; // 장바구니에 있는 상품 개수
	let cartSum = <%= totalPrice %>; // 총 가격을 JSP에서 가져옴

	function order() {
	    if (cartCount == 0) {
	        alert('장바구니에 담긴 상품이 없습니다.');
	        return; // 장바구니가 비어있으면 함수 종료
	    }

	    // 주문 확인 메시지
	    let msg = '총 ' + cartCount + '개의 상품을 주문합니다. \n총 주문금액 : ' + cartSum;
	    let check = confirm(msg); // 확인 대화 상자 표시

	    // 사용자가 확인을 선택한 경우
	    if (check) {
	        // 사용자가 확인을 선택하면 리디렉션
	        window.location.href = 'ship.jsp?cartId=<%= cartId %>'; // cartId에 해당하는 페이지로 이동
	    }
	    // 취소한 경우 아무런 동작을 하지 않음
	}
	    
	
	// 삭제
    function deleteFromCart(productId) {
        // 삭제 확인 메시지 표시
        const isConfirmed = confirm("이 상품을 장바구니에서 삭제하시겠습니까?");
        
        if (isConfirmed) {
            // form 데이터를 생성하여 POST 요청 처리
            const form = document.createElement("form");
            form.method = "post";
            form.action = "deleteFromCart.jsp";

            // productId를 hidden input으로 추가
            const input = document.createElement("input");
            input.type = "hidden";
            input.name = "productId";
            input.value = productId;
            form.appendChild(input);

            // form을 body에 추가하고 submit하여 서버로 전송
            document.body.appendChild(form);
            form.submit();
        }
    }

</script>

	
</body>

	<style>
		.deletebtn {
			background-color: rgb(236, 48, 48);
			border: 1px solid rgb(236, 48, 48);
		}
		.deletebtn:hover,
		.deletebtn:active {
			background-color: rgb(192, 36, 36) !important;
			border: 1px solid rgb(192, 36, 36) !important;
		}
	</style>
</html>