<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
	<link rel="stylesheet" href="static/css/index.css">
</head>
<body>   
	
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">메인화면</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
			<div class="d-grid gap-2 d-sm-flex justify-content-sm-center gap-3">
				<div
					class="choose d-flex justify-content-beween column-gap-2 align-items-center">
					<button type="button" class="product rounded-3"
						onclick="location.href='shop/products.jsp'">상품목록</button>

					<c:choose>
						<c:when test="${not empty sessionScope.loginUser}">
							<button type="button" class="logout rounded-3"
								onclick="location.href='user/logout.jsp'">로그아웃</button>
						</c:when>

						<c:otherwise>
							<button type="button" class="login rounded-3"
								onclick="location.href='user/login.jsp'">로그인</button>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>





