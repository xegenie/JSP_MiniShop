<%@page import="shop.dto.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    try {
        String productId = request.getParameter("pNo");
        ProductRepository productDAO = new ProductRepository();
        Product product = productDAO.getProductById(productId);

        // 상품이 존재하지 않을 경우
        if (product == null) {
            out.println("<script>alert('해당 상품이 존재하지 않습니다.'); location.href='products.jsp';</script>");
            return;
        }

        // 품절 상품 체크
        if (product.getUnitsInStock() == 0) {
            out.println("<script>alert('품절 상품입니다.'); location.href='products.jsp';</script>");
            return;
        }

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
                if (cartItem.getProductId().equals(product.getProductId())) {
                    cartItem.setQuantity(cartItem.getQuantity() + 1);
                    productExists = true;
                    break;
                }
            }

            // 장바구니에 상품이 없으면 새로 추가
            if (!productExists) {
                product.setQuantity(1);
                userCart.add(product);
            }

            session.setAttribute("userCart", userCart);
        } else {
            // 비회원일 경우
            List<Product> cart = (List<Product>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            boolean productExists = false;

            // 장바구니에 이미 상품이 있는지 확인
            for (Product cartItem : cart) {
                if (cartItem.getProductId().equals(product.getProductId())) {
                    cartItem.setQuantity(cartItem.getQuantity() + 1);
                    productExists = true;
                    break;
                }
            }

            // 장바구니에 상품이 없으면 새로 추가
            if (!productExists) {
                product.setQuantity(1);
                cart.add(product);
            }

            session.setAttribute("cart", cart);
        }

        // 알림 메시지 및 리다이렉트
        out.println("<script>alert('장바구니에 상품이 추가되었습니다.'); location.href='cart.jsp';</script>");
    } catch (Exception e) {
        out.println("<script>alert('문제가 발생했습니다. 다시 시도해주세요.'); location.href='products.jsp';</script>");
    }
%>
