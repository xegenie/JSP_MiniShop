<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 성공</title>
    <jsp:include page="/layout/meta.jsp" /> 
    <jsp:include page="/layout/link.jsp" />
</head>
<body>
    <%
        String root = request.getContextPath();
        
        // msg가 0일 때 로그인 성공 메시지 출력
        if ("0".equals(request.getParameter("msg"))) {
    %>
        <div class="px-4 py-5 my-5 text-center">
            <h1 class="display-5 fw-bold text-body-emphasis">로그인 성공</h1>
            <p>환영합니다! 성공적으로 로그인하셨습니다.</p>
            <a href="<%= root %>/index.jsp" class="btn btn-primary btn-lg">메인 페이지로 이동</a>
        </div>
    <%
        } else {
    %>
        <div class="px-4 py-5 my-5 text-center">
            <h1 class="display-5 fw-bold text-body-emphasis">알림</h1>
            <p>로그인에 실패했습니다. 다시 시도해 주세요.</p>
            <a href="<%= root %>/index.jsp" class="btn btn-primary btn-lg">메인 페이지로 이동</a>
        </div>
    <%
        }
    %>
    
    <div class="container mb-5">
        <!-- 추가 내용 -->
    </div>
    
    <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" />
</body>
</html>
