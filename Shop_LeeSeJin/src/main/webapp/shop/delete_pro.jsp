<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 상품 삭제 처리 - 삭제 후, 상품 편집으로 이동 -->
<%
	ProductRepository productDAO = new ProductRepository();
	
	String productId = request.getParameter("pNo");
	
	productDAO.delete(productId);
%>
<script>
	alert('삭제 완료!');
	location.href='editProducts.jsp';
</script>