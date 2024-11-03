<%@page import="java.net.URLEncoder"%>
<%@page import="shop.dto.Product"%>
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
	<title>상품 수정 페이지</title>
<%
	String root = request.getContextPath();

	String productId = request.getParameter("pNo");
	
	ProductRepository productDAO = new ProductRepository();
	
	Product product = productDAO.getProductById(productId);
	
%>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<jsp:include page="/layout/header.jsp" />
<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">상품 수정</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
		</div>
	</div>
	
	<!-- 상품 수정 입력 화면 -->
	<div class="container shop">
		<form name="product" action="./update_pro.jsp" onsubmit="return checkProduct()" method="post" enctype="multipart/form-data">
		    <c:set var="item" value="<%= product %>" />
		    
		    <div class="input-group row">
		        <label class="input-group-text col-md-2" id="">상품 이미지</label>
		        <input type="file" class="form-control" name="file" id="fileInput">
		    </div>
		    <div class="input-group mb-3 row">
	        	<label class="input-group-text col-md-2" id="">기존 파일</label>
	        	<span class="form-control text-muted" id="fileName" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${item.file}</span> <!-- 기존 파일 이름 표시 -->
		        <input type="hidden" name="existingFile" value="${item.file}">
		    </div>	
		    
		    <div class="input-group mb-3 row">
		        <label class="input-group-text col-md-2" id="">상품 코드</label>
		        <input type="text" class="form-control col-md-10" name="productId" value="${ item.productId }">
		    </div>
		    
		    <div class="input-group mb-3 row">
		        <label class="input-group-text col-md-2" id="">상품명</label>
		        <input type="text" class="form-control col-md-10" name="name" value="${ item.name }">
		    </div>
		    
		    <div class="input-group mb-3 row">
		        <label class="input-group-text col-md-2" id="">가격</label>
		        <input type="number" class="form-control col-md-10" name="unitPrice" value="${ item.unitPrice }">
		    </div>
		    
		    <div class="input-group mb-3 row">
		        <label class="input-group-text w-100" id="">상세 정보</label>
		        <textarea class="form-control" name="description" style="height: 200px !important;">${ item.description }</textarea>
		    </div>
		    
		    <div class="input-group mb-3 row">
		        <label class="input-group-text col-md-2" id="">제조사</label>
		        <input type="text" class="form-control col-md-10" name="manufacturer" value="${ item.manufacturer }">
		    </div>
		    
		    <div class="input-group mb-3 row">
		        <label class="input-group-text col-md-2" id="">분류</label>
		        <input type="text" class="form-control col-md-10" name="category" value="${ item.category }">
		    </div>
		    
		    <div class="input-group mb-3 row">
		        <label class="input-group-text col-md-2" id="">재고 수</label>
		        <input type="number" class="form-control col-md-10" name="unitsInStock" value="${ item.unitsInStock }">
		    </div>
		    
		    <div class="input-group mb-3 row">
		        <div class="col-md-2 p-0">
		            <label class="input-group-text" id="">상태</label>
		        </div>
		        <div class="col-md-10 d-flex align-items-center">
		            <div class="radio-box d-flex">
		                <div class="radio-item mx-5">
		                    <input type="radio" class="form-check-input" name="condition" value="NEW" id="condition-new" <c:if test="${item.condition == 'NEW'}">checked</c:if>> 
		                    <label for="condition-new">신규 제품</label>
		                </div>
		                
		                <div class="radio-item mx-5">
		                    <input type="radio" class="form-check-input" name="condition" value="OLD" id="condition-old" <c:if test="${item.condition == 'OLD'}">checked</c:if>> 
		                    <label for="condition-old">중고 제품</label>
		                </div>
		                
		                <div class="radio-item mx-5">
		                    <input type="radio" class="form-check-input" name="condition" value="RE" id="condition-re" <c:if test="${item.condition == 'RE'}">checked</c:if>> 
		                    <label for="condition-re">재생 제품</label>
		                </div>
		            </div>
		        </div>
		    </div>
		    
		    <div class="d-flex justify-content-between mt-5 mb-5">
		        <a href="./products.jsp" class="btn btn-lg btn-secondary">목록</a>
		        <input type="submit" class="btn btn-lg btn-primary" value="수정" />
		    </div>
		</form>
	</div>
	
	<footer class="container p-5">
	<p>copyright Shop</p>
</footer>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<!-- 상대경로 -->
<script src="../static/js/validation.js"></script>
<!-- 절대경로 -->
<!-- <script src="/Shop/static/js/validation.js"></script> -->
	
	
</body>
</html>
