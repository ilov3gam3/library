<%@ page import="Init.Config" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="container mt-2">
    <div class="row d-flex justify-content-end">
        <div class="col-8">
            <h4>Tên miền: <%=Config.app_host%></h4>
            <h4>Địa chỉ ip: 20.205.131.173</h4>
            <h4>Database: Azure sql database</h4>
            <h4>Chứng chỉ ssl: zerossl</h4>
        </div>
    </div>
</div>
<%@ include file="/master/foot.jsp" %>