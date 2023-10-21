<%@ page import="Init.Config" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/master/head.jsp" %>
<%@page pageEncoding="UTF-8" %>
<div class="breadcrumb page-header text-center">
    <div class="container">
        <h1 class="page-title">Nâng cấp lên tài khoản vip</h1>
    </div>
</div>
<div class="container mt-2 d-flex justify-content-center">
    <div class="col-md-6">
        <h3 class="font-weight-bold">Quyền lợi khi lên tài khoản vip.</h3>
        <h4><i class="fa fa-diamond" aria-hidden="true"></i>Thuê sách không cần trả phí</h4>
        <h4><i class="fa fa-diamond" aria-hidden="true"></i>Được phép tải bản mềm của sách.</h4>
        <h4><i class="fa fa-diamond" aria-hidden="true"></i>Bảo hành trọn đời</h4>
        <h4><i class="fa fa-diamond" aria-hidden="true"></i>Mức giá ưu đãi chỉ 20k</h4>
        <% if (Integer.parseInt(user.account_balance) < Config.vip_amount) {%>
            <button  class="btn btn-primary btn-block" onclick="notEnoughBalance()">Nâng cấp ngay</button>
        <%} else {%>
        <form action="${pageContext.request.contextPath}/user/upgrade-vip" method="post">
            <button class="btn btn-primary btn-block">Nâng cấp ngay</button>
        </form>
        <%}%>
    </div>
</div>
<%@ include file="/master/foot.jsp" %>
<script>
    function notEnoughBalance() {
        toastr.warning("Tài khoản của bạn không đủ số dư, vui lòng nạp thêm.")
    }
</script>