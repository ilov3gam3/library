<%@ page import="Init.Config" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="utf-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Database</title>
</head>
<body>
<h1>Host : <%=Config.db_server%></h1>
<h1>Port : <%=Config.db_port%></h1>
<c:if test="${not empty catalog}">
    <h1>đã kết nối tới database ${catalog}</h1>
    <a href="${pageContext.request.contextPath}/recreate-db">
        <button>tạo mới toàn bộ database</button>
    </a>
</c:if>
<c:if test="${empty catalog}">
    <h1>không kết nối tới database được, kiểm tra lại</h1>
</c:if>
<c:if test="${not empty success}">
    <h1>tạo database thành công</h1>
</c:if>
<c:if test="${not empty error}">
    <h1>tạo database không thành công</h1>
</c:if>
</body>
</html>