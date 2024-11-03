<%@page import="shop.dto.User"%>
<%@ page import="shop.dto.Product, java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
	// 선택한 항목만 딜리트
	
	User user = (User) session.getAttribute("loginUser");
    String productId = request.getParameter("productId");
	
	if ( user == null ) {
	    List<Product> cart = (List<Product>) session.getAttribute("cart");
	
	    if (cart != null && productId != null) {
	        cart.removeIf(product -> String.valueOf(product.getProductId()).equals(productId));
	    }
    } else {
	    List<Product> userCart = (List<Product>) session.getAttribute("userCart");
	
	    if (userCart != null && productId != null) {
	    	userCart.removeIf(product -> String.valueOf(product.getProductId()).equals(productId));
	    }
    }
    // 장바구니 페이지로 리디렉션
    out.println("<script>");
    out.println("alert('선택한 상품이 삭제되었습니다.');");
    out.println("location.href='cart.jsp';");
    out.println("</script>");
%>
