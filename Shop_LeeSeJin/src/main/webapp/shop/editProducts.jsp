<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
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
	<title>상품 편집 페이지</title>
	<%
		String root = request.getContextPath();
	
		ProductRepository productDAO = new ProductRepository();
		
		String keyword = request.getParameter("keyword");
		
		List<Product> productList = null; 
		
		if (keyword != null && !keyword.trim().isEmpty()) {
			productList = productDAO.list(keyword);
		} else {
			productList = productDAO.list();
		}
		request.setAttribute("productList", productList);
		
		
	%>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
	<link rel="stylesheet" href="<%= root %>/static/css/editProducts.css">
	<script src="https://kit.fontawesome.com/6aaa685e44.js"></script>
</head>
<body>
<jsp:include page="/layout/header.jsp" />
<div class="container text-center mt-5 d-flex flex-column gap-2">
	<h1 class="fw-bold">상품 편집</h1>
	<p>쇼핑몰 상품 목록 입니다.</p>
	<div class="btnlist d-grid gap-2 d-sm-flex justify-content-sm-center">
		<button type="button" onclick="location.href='add.jsp'" class="btn btn-primary">상품 등록</button>
		<button type="button" onclick="location.href='products.jsp'" class="btn btn-primary">상품 목록</button>
	</div>
</div>
<div class="container mt-2 mb-5">
	<div class="row gy-4 mt-5">
        <c:forEach var="list" items="${ productList }">
            <div class="col-md-6 col-xl-4 col-xxl-3">
                <div class="card p-4 d-flex flex-column justify-content-between" style="height: 400px;">
                    <img alt="" src="<%= root %>${ list.file }">
                    <p class="fw-bold fs-5">${ list.name }</p>
                    <p>${ list.description }</p>
                    <i class="fa-solid fa-won-sign d-flex justify-content-end">&nbsp;
                        <script>document.write((${list.unitPrice}).toLocaleString('ko-KR'));</script> 원
                    </i>
                    <div class="pt-3 d-flex justify-content-end align-items-center column-gap-2">
                        <a href="cart.jsp">
                            <button class="update btn btn-outline-primary">수정</button>
                        </a>
                        <a href="product.jsp?pNo=${ list.productId }">
                            <button class="delete btn btn-outline-primary">삭제</button>
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
	</div>
</div>
</body>
</html>