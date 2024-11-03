<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.User"%>
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
	<title>주문 페이지</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
	
<%
	String root = request.getContextPath();
	String cartId = request.getParameter("cartId");
	
	if (cartId == null) {
	    out.println("<script>alert('다시 시도해 주세요.'); location.href='products.jsp';</script>");
	    return;
	}
	
	if (cartId.equals("guest")) {
		List<Product> cart = (List<Product>) session.getAttribute("cart");
	} else {
		List<Product> cart = (List<Product>) session.getAttribute("userCart");
	}
	
	String shipName = request.getParameter("shipName");
	String date = request.getParameter("date"); 
	String country = request.getParameter("country"); 
	String zipCode = request.getParameter("zipCode"); 
	String address = request.getParameter("address"); 
	String phone = request.getParameter("phone"); 
%>

</head>
<body style="height: 1200px;">
<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 mt-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">주문 정보</h1>
	</div>
	
	<div class="container shop">
	<form action="./complete.jsp?cartId=<%= cartId %>" method="post">
    	<div class="col-mb-6 mb-3">
            <div class="input-group mb-3">
                 <label class="input-group-text" style="width: 150px;">성명</label>
                 <input type="text" class="form-control" name="shipName" value="<%= shipName %>" readonly>
            </div>
            <div class="input-group mb-3">
                 <label class="input-group-text" style="width: 150px;">배송일</label>
                 <input type="date" class="form-control" name="date" value="<%= date %>" readonly>
            </div>
            <div class="input-group mb-3">
                 <label class="input-group-text" style="width: 150px;">국가명</label>
                 <input type="text" class="form-control" name="country" value="<%= country %>" readonly>
            </div>
            <div class="input-group mb-3">
                 <label class="input-group-text" style="width: 150px;">우편번호</label>
                 <input type="text" class="form-control" name="zipCode" value="<%= zipCode %>" readonly>
            </div>
            <div class="input-group mb-3">
                 <label class="input-group-text" style="width: 150px;">주소</label>
                 <input type="text" class="form-control" name="address" value="<%= address %>" readonly>
            </div>
            <div class="input-group mb-3">
                 <label class="input-group-text" style="width: 150px;">전화번호</label>
                 <input type="text" class="form-control" name="phone" value="<%= phone %>" readonly>
            </div>
            <div class="input-group mb-3">
                 <label class="input-group-text" style="width: 150px;">주문 비밀번호</label>
                 <input type="text" class="form-control rounded-3" name="orderPw" placeholder="비회원일 경우 입력" 
                 style="border: 2px solid gray;" <%= cartId.equals("guest") ? "" : "disabled" %>>
            </div>
        </div>
	
	<!-- 장바구니 목록 -->
	<table class="table table-striped table-hover table-bordered mt-4 text-center align-middle">
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

			<c:forEach var="list" items="${cart}">
			    <tr>
			        <td>${list.name}</td>
			        <td>${list.unitPrice}</td>
			        <td>${list.quantity}</td>
			        <td>${list.unitPrice * list.quantity}</td>
			        <td></td>
			    </tr>
			    <c:set var="totalPrice" value="${totalPrice + (list.unitPrice * list.quantity)}" /> <!-- 총 가격 계산 -->
			</c:forEach>
	    </tbody>
	    <tfoot>
		    <c:choose>
			    <c:when test="${totalPrice > 0}">
			        <tr>
			            <td></td>
			            <td></td>
			            <td>총액</td>
			            <td>${totalPrice}</td> <!-- 총액 표시 -->
			            <td></td>
			        </tr>
			    </c:when>
			    <c:otherwise>
			        <tr>
			            <td colspan="5" style="text-align: center;">등록된 상품이 없습니다.</td> <!-- 상품이 없을 경우 메시지 표시 -->
			        </tr>
			    </c:otherwise>
			</c:choose>
   		</tfoot>
	</table>

		<!-- 버튼 영역 -->
		<div class="d-flex justify-content-between px-1 mt-5">
	       	<div>
				<button type="button" class="btn btn-success" onclick="history.back()">이전</button>
		        <button type="button" class="btn btn-danger" onclick="location.href='<%= root %>/index.jsp'">취소</button>
	       	</div>
	        <button type="submit" class="btn btn-primary">주문완료</button>
        </div>
    </form>
	</div>

</body>
</html>