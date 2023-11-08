<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="container mt-2">
    <a href="${pageContext.request.contextPath}/admin/admin-panel">
        <button class="btn btn-primary">Quay về trang quản trị</button>
    </a>
    <h3 class="mt-2">Tiền bị trừ do không trả sách</h3>
    <h5 class="mt-2">Tổng số tiền: ${amount}</h5>
    <table class="table table-bordered table-striped" id="table">
        <thead>
        <tr>
            <th>Tên người dùng</th>
            <th>Tên sách</th>
            <th>Số tiền phải trả</th>
            <th>Ngày bị trễ</th>
            <th>Mượn vào lúc</th>
            <th>Ngày phải trả</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${late_returns}" var="late_return">
            <tr>
                <td>${late_return.getUser_name()}</td>
                <td>${late_return.getBook_title()}</td>
                <td>${late_return.getAmount()}</td>
                <td>${late_return.getPenalty_fee_date()}</td>
                <td>${late_return.getRent_at()}</td>
                <td>${late_return.getTo_date()}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<%@ include file="/master/foot.jsp" %>
<script>
    $("#table").DataTable();
</script>