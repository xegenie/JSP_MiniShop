<%@page import="shop.dto.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--  장바구니 등록 처리 - 등록 후, 뒤로 이동 -->
<%
    String productId = request.getParameter("pNo");

    ProductRepository productDAO = new ProductRepository();
    Product product = productDAO.getProductById(productId);

    User user = (User) session.getAttribute("loginUser");
    // 회원일 경우
    if (user != null) {
    	List<Product> userCart = (List<Product>) session.getAttribute("userCart");
        if (userCart == null) {
        	userCart = new ArrayList<>();
        }
        
        boolean productExists = false;

        // 장바구니에 이미 상품이 있는지 확인
        for (Product cartItem : userCart) {
            if (cartItem.getProductId().equals(product.getProductId())) { // 상품 ID로 비교
                cartItem.setQuantity(cartItem.getQuantity() + 1); // 수량 증가
                productExists = true;
                break;
            }
        }

        // 장바구니에 상품이 없으면 새로 추가
        if (!productExists) {
            product.setQuantity(1); // 새로운 상품 추가 시 초기 수량 설정
            userCart.add(product);
        }

        // 장바구니를 세션에 저장
        
        session.setAttribute("userCart", userCart); // 비회원 장바구니 저장
        
    } else {
	    // 비회원일 경우 (세션에 로그인 정보가 없음)
	    List<Product> cart = (List<Product>) session.getAttribute("cart");
	    if (cart == null) {
	        cart = new ArrayList<>(); // 비회원 장바구니가 없으면 새로 초기화
	    }
	    
	    boolean productExists = false;

        // 장바구니에 이미 상품이 있는지 확인
        for (Product cartItem : cart) {
            if (cartItem.getProductId().equals(product.getProductId())) { // 상품 ID로 비교
                cartItem.setQuantity(cartItem.getQuantity() + 1); // 수량 증가
                productExists = true;
                break;
            }
        }

        // 장바구니에 상품이 없으면 새로 추가
        if (!productExists) {
            product.setQuantity(1); // 새로운 상품 추가 시 초기 수량 설정
            cart.add(product);
        }

        // 장바구니를 세션에 저장
        
        session.setAttribute("cart", cart); // 비회원 장바구니 저장
    }
    

    // 이전 페이지 URL 확인
    String referer = request.getHeader("Referer");
    String redirectPage;

    // 이전 페이지가 product.jsp 인 경우
    if (referer != null && referer.contains("product.jsp")) {
        redirectPage = "product.jsp";
    } 
    else {
        redirectPage = "products.jsp";
    } 

    // 알림 메시지 및 리다이렉트
    out.println("<script>alert('장바구니에 상품이 추가되었습니다.'); location.href='" + redirectPage + "';</script>");
%>
