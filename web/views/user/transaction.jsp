<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/master/head.jsp" %>
<%@ page pageEncoding="utf-8" %>
<div class="container ">
  <div class="row col-12">
    <h3>Lịch sử giao dịch</h3>
    <div class="row col-12">
      <div class="col-md-3">Tổng nạp: ${tong_nap}</div>
      <div class="col-md-3">Tổng số tiền thuê: ${tong_thue}</div>
      <div class="col-md-3">Tổng số tiền nâng cấp vip: ${tong_nap_vip}</div>
      <div class="col-md-3">Tổng số tiền đã sử dụng: ${tong_thue + tong_nap_vip}</div>
    </div>
    <div id="more_info_block" class="tabs tab-center">
      <ul class="nav nav-tabs">
        <li class="nav-item">
          <a data-toggle="tab" href="#tong_nap" class="nav-link active">
            Tổng nạp
          </a>
        </li>
        <li class="nav-item">
          <a data-toggle="tab" href="#lich_su_thue_sach" class="nav-link">
            lịch sử thuê sách
          </a>
        </li>
        <li class="nav-item">
          <a data-toggle="tab" href="#lich_su_nang_vip" class="nav-link">
            Lịch sử nâng cấp vip
          </a>
        </li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active" id="tong_nap" role="tabpanel">
          <table class="table table-bordered table-striped col-12">
            <thead>
            <tr>
              <th>Số tiền</th>
              <th>Ngân hàng</th>
              <th>Mã giao dịch</th>
              <th>Loại thẻ</th>
              <th>Tạo đơn lúc</th>
              <th>Thanh toán lúc</th>
              <th>Trang thái</th>
            </tr>
            </thead>
            <tbody>
              <c:forEach items="${transactions}" var="transaction">
                <tr>
                  <td>${transaction.getAmount()}</td>
                  <td>${transaction.getVnp_BankCode()}</td>
                  <td>${transaction.getVnp_TransactionNo()}</td>
                  <td>${transaction.getVnp_CardType()}</td>
                  <td>${transaction.getCreate_order_at()}</td>
                  <td>${transaction.getPaid_at()}</td>
                  <td>${transaction.getVnp_TransactionStatus() == "00" ? "<span class='text-success'>Thành công</span>" : "<span class='text-danger'>Không thành công.</span>"}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
        <div class="tab-pane" id="lich_su_thue_sach" role="tabpanel">
          <table class="table table-bordered table-striped col-12">
            <thead>
            <tr>
              <th scope="col">Tên sách</th>
              <th scope="col">Từ ngày</th>
              <th scope="col">Đến ngày</th>
              <th scope="col">Giá</th>
              <th scope="col">Mượn lúc</th>
            </tr>
            </thead>
            <tbody>
              <c:forEach items="${rentals}" var="rental">
                <tr>
                  <td>
                    <a href="${pageContext.request.contextPath}/view-book?id=${rental.getBook_id()}">
                        ${rental.getBook_title()}
                    </a>
                  </td>
                  <td>${rental.getFrom_date()}</td>
                  <td>${rental.getTo_date()}</td>
                  <td>${rental.getPrice()}</td>
                  <td>${rental.getCreated_at()}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
        <div class="tab-pane" id="lich_su_nang_vip" role="tabpanel">
          <table class="table table-bordered table-striped col-12">
            <thead>
            <tr>
              <th scope="col">Từ ngày</th>
              <th scope="col">Đến ngày</th>
              <th scope="col">Giá</th>
              <th class="col-1">Được giảm</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${vip_subs}" var="vip_sub">
              <tr>
                <td>${vip_sub.getFrom_date()}</td>
                <td>${vip_sub.getTo_date()}</td>
                <td>${vip_sub.getPrice()}</td>
                <td>${vip_sub.getDiscount()}</td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>
<%@ include file="/master/foot.jsp" %>
