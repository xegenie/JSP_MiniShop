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
	<title>배송 정보 등록 페이지</title>
<jsp:include page="/layout/meta.jsp" />
<jsp:include page="/layout/link.jsp" />

<% 
	User user = (User) session.getAttribute("loginUser");
	String root = request.getContextPath();
	String cartId = request.getParameter("cartId");
	if (cartId == null) {
	    out.println("<script>alert('다시 시도해 주세요.'); location.href='products.jsp';</script>");
	}
%>
</head>
<body style="height: 1200px;">
<jsp:include page="/layout/header.jsp" />

<div class="container p-5 my-5 text-center">
	<h1 class="display-5 fw-bold">배송 정보</h1>
</div>

<div class="container shop text-center">
    <form action="./ship_pro.jsp?cartId=<%= cartId %>" method="post">
		<div class="mb-3 d-flex">
	        <input class="" type="checkbox" id="userinfo" onchange="toggleUserInfo(this)" <%= user != null ? "" : "disabled" %>>
	        <label for="userinfo" >&ensp;회원정보와 동일하게 (비회원 사용불가)</label>
		</div>
    	<div class="col-mb-6 mb-3">
            <div class="input-group mb-3">
                 <span class="input-group-text" style="width: 150px;">성명</span>
                 <input type="text" class="form-control" name="shipName">
            </div>
            <div class="input-group mb-3">
                 <span class="input-group-text" style="width: 150px;">배송일</span>
                 <input type="date" class="form-control" name="date">
            </div>
            <div class="input-group mb-3">
                 <span class="input-group-text" style="width: 150px;">국가명</span>
                 <input type="text" class="form-control" name="country">
            </div>
            <div class="input-group mb-3">
                 <span class="input-group-text" style="width: 150px;">우편번호</span>
                 <input type="text" class="form-control" name="zipCode">
            </div>
            <div class="input-group mb-3">
                 <span class="input-group-text" style="width: 150px;">주소</span>
                 <input type="text" class="form-control" name="address">
            </div>
            <div class="input-group mb-3">
                 <span class="input-group-text" style="width: 150px;">phone</span>
                 <input type="text" class="form-control" name="phone">
            </div>
			            
	        <div class="d-flex justify-content-between px-1 mt-5">
	        	<div>
					<button type="button" class="btn btn-success" onclick="history.back()">이전</button>
			        <button type="button" class="btn btn-danger" onclick="location.href='<%= root %>/index.jsp'">취소</button>
	        	</div>
		        <button type="submit" class="btn btn-primary">등록</button>
	        </div>
        </div>
    </form>
</div>


<script>
<% if (user != null) { %>
    function toggleUserInfo(checkbox) {
        // 사용자의 정보를 가져옵니다.
        const userInfo = {
            name: "<%= user.getName() %>",              // 이름
            address: "<%= user.getAddress() %>",        // 주소
            phone: "<%= user.getPhone() %>"             // 전화번호
        };

        // 체크박스가 선택되면 입력란에 사용자 정보 채우기
        if (checkbox.checked) {
            document.querySelector('input[name="shipName"]').value = userInfo.name;
            document.querySelector('input[name="address"]').value = userInfo.address;
            document.querySelector('input[name="phone"]').value = userInfo.phone;
        } else {
            // 체크박스가 선택 해제되면 입력란 초기화
            document.querySelector('input[name="shipName"]').value = '';
            document.querySelector('input[name="address"]').value = '';
            document.querySelector('input[name="phone"]').value = '';
        }
    }
<% } %>
</script>


</body>
</html>