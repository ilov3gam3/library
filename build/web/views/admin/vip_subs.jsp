<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="container mt-2">
  <a href="${pageContext.request.contextPath}/admin/admin-panel">
    <button class="btn btn-primary">Quay về trang quản trị</button>
  </a>
  <h3 class="mt-2">Quản lý tiền nạp vào.</h3>
  <h5>Tổng số tiền: ${amount}</h5>
  <table class="table table-bordered table-striped" id="table">
    <thead>
    <tr>
      <th>Tên người dùng</th>
      <th>Từ ngày</th>
      <th>Đến ngày</th>
      <th>Giá tiền</th>
      <th>Giảm giá</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${vips}" var="vip">
      <tr>
        <td>${vip.getUser_name()}</td>
        <td>${vip.getFrom_date()}</td>
        <td>${vip.getTo_date()}</td>
        <td>${vip.getPrice()}</td>
        <td>${vip.getDiscount()}</td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
<%@ include file="/master/foot.jsp" %>
<script>
  $("#table").DataTable();
</script>