<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="container mt-2">
    <a href="${pageContext.request.contextPath}/admin/admin-panel">
        <button class="btn btn-primary">Quay về trang quản trị</button>
    </a>
    <h3 class="mt-2">Quản lý tiền nạp vào.</h3>
    <table class="table table-bordered table-striped" id="table">
        <thead>
            <tr>
                <th>Người nap</th>
                <th>Số tiền</th>
                <th>Ngân hàng</th>
                <th>Mã giao dịch</th>
                <th>Loại thẻ</th>
                <th>Tạo đơn lúc</th>
                <th>Thanh toán lúc</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${payments}" var="payment">
            <tr>
                <td>${payment.getUser_name()}</td>
                <td>${payment.getAmount()}</td>
                <td>${payment.getVnp_BankCode()}</td>
                <td>${payment.getVnp_TransactionNo()}</td>
                <td>${payment.getVnp_CardType()}</td>
                <td>${payment.getCreate_order_at()}</td>
                <td>${payment.getPaid_at()}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<%@ include file="/master/foot.jsp" %>
<script>
    $("#table").DataTable();
</script>