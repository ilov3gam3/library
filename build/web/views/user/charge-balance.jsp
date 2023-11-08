<%@page contentType="text/html;" pageEncoding="utf-8" %>
<%@ include file="/master/head.jsp" %>
<div class="breadcrumb page-header text-center">
  <div class="container">
    <h1 class="page-title">Nạp số dư</h1>
  </div>
</div>
<div class="container">
  <div class="row mt-2 d-flex justify-content-center">
    <div class="col-md-6">
      <form method="post" id="createOrder">
        <input class="hidden" type="radio" checked id="bankCode" name="bankCode" value="">
        <div class="form-group row align-items-center ">
          <label class="col-md-12 form-control-label required" for="amount">
            Nhập số dư                 </label>
          <div class="col-md-12">
            <input class="form-control" data-val="true" data-val-number="The field Amount must be a number." data-val-required="The Amount field is required." id="amount" max="100000000" min="1" name="amount" type="number" value="20000" />
          </div>
        </div>

        <div class="form-group row align-items-center ">
          <label class="col-md-12 form-control-label required">
            Chọn ngôn ngữ cổng thanh toán             </label>
          <div class="col-md-12">
            <input type="radio" checked id="vn" name="language" value="vn">
            <label for="vn">Tiếng Việt</label><br>
            <input type="radio" id="en" name="language" value="en">
            <label for="vn">Tiếng Anh</label><br>
          </div>
        </div>

        <div class="form-group row align-items-center ">
          <button class="btn btn-primary">Thanh toán</button>
        </div>

      </form>
    </div>
  </div>
</div>
<%@ include file="/master/foot.jsp" %>
<script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
<script>
$("#createOrder").on('submit', function (e){
  e.preventDefault();
  var postData = $("#createOrder").serialize();
  var url = '${pageContext.request.contextPath}/user/get-vnpay-url'
  $.ajax({
    type: "POST",
    url: url,
    data: postData,
    dataType: 'JSON',
    success: function (x) {
      if (x.code === '00') {
        if (window.vnpay) {
          vnpay.open({width: 768, height: 600, url: x.data});
        } else {
          location.href = x.data;
        }
      } else {
        alert(x.Message);
      }
    }
  });
})
</script>