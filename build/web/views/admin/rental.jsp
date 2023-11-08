<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="container mt-2">
    <a href="${pageContext.request.contextPath}/admin/admin-panel">
        <button class="btn btn-primary">Quay về trang quản trị</button>
    </a>
    <h3 class="mt-2 mb-2">Đơn mượn sách</h3>
    <h5 class="mt-2 mb-2">Tổng số tiền: ${amount}</h5>
    <div class="row">
        <table class="table table-bordered table-striped" id="table">
            <thead>
            <tr>
                <th>Tên sách</th>
                <th>Tên người mượn</th>
                <th>Từ ngày</th>
                <th>Đến ngày</th>
                <th>Giá</th>
                <th>Đã nhận</th>
                <th>Đã trả</th>
                <th>Trạng thái</th>
                <th>Mượn lúc</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${rentals}" var="rental">
                <tr>
                    <td>${rental.getBook_title()}</td>
                    <td>${rental.getUser_name()}</td>
                    <td>${rental.getFrom_date()}</td>
                    <td>${rental.getTo_date()}</td>
                    <td>${rental.getPrice()}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/change-rental-status?id=${rental.getId()}&type=received_book">
                                ${rental.getReceived_book() == "0" ? " <button class='btn-danger'>Chưa nhận</button>" : " <button class='btn-primary'>Đã nhận</button>"}
                        </a>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${rental.getReceived_book() == '0'}">
                                <button class="btn-danger" onclick="toastr.warning('Người dùng chưa nhận sách, không thể thay đổi trạng thái.')">Chưa trả</button>
                            </c:when>
                            <c:when test="${rental.getReceived_book() == '1'}">
                                    ${rental.getReturned_book() == "0" ? "<a href=\"${pageContext.request.contextPath}/admin/change-rental-status?id=${rental.getId()}&type=returned_book\"><button class='btn-danger'>Chưa trả</button></a>" : " <button onclick=\"toastr.warning('Người dùng chưa nhận sách, không thể thay đổi trạng thái.')\" class='btn-primary'>Đã trả</button>"}
                            </c:when>
                        </c:choose>
                    </td>
                    <td>
                        ${rental.getStatus() == "0" ? "đang mượn" : (rental.getStatus() == "1" ? "Đã trả" : "Đã hủy")}
                    </td>
                    <td>${rental.getCreated_at()}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="/master/foot.jsp" %>
<script>
    $(document).ready(function () {
        new DataTable('#table')
        $("#table_wrapper").css({"width": "100%"})
    });
</script>