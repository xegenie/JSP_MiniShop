<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%
    // 요청 파라미터를 가져옵니다
    String cartId = request.getParameter("cartId");  // cartId 가져오기
	if (cartId == null) {
	    out.println("<script>alert('다시 시도해 주세요.'); location.href='products.jsp';</script>");
	    return;
	}
    
    String shipName = URLEncoder.encode(request.getParameter("shipName"), "UTF-8"); // URL 인코딩
    String date = URLEncoder.encode(request.getParameter("date"), "UTF-8"); 
    String country = URLEncoder.encode(request.getParameter("country"), "UTF-8"); 
    String zipCode = URLEncoder.encode(request.getParameter("zipCode"), "UTF-8"); 
    String address = URLEncoder.encode(request.getParameter("address"), "UTF-8"); 
    String phone = URLEncoder.encode(request.getParameter("phone"), "UTF-8"); 
    
    // 쿼리 문자열을 생성합니다
    String redirectURL = "order.jsp?cartId=" + cartId +
                         "&shipName=" + shipName + 
                         "&date=" + date + 
                         "&country=" + country + 
                         "&zipCode=" + zipCode + 
                         "&address=" + address + 
                         "&phone=" + phone;
    
    // order.jsp로 리다이렉트합니다
    response.sendRedirect(redirectURL);
%>
