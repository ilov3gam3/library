<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="container mt-2">
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
                                ${rental.getReceived_book() == "0" ? "Chưa <button class='btn-primary'>Đã nhận</button>" : "Rồi <button class='btn-danger'>Chưa nhận</button>"}
                        </a>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/change-rental-status?id=${rental.getId()}&type=returned_book">
                                ${rental.getReturned_book() == "0" ? "Chưa <button class='btn-primary'>Đã trả</button>" : "Rồi <button class='btn-danger'>Chưa trả</button>"}
                        </a>
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