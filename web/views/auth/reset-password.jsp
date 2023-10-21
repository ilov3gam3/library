<%@page contentType="text/html;" pageEncoding="utf-8" %>
<%@ include file="/master/head.jsp" %>
<div class="breadcrumb page-header text-center">
  <div class="container">
    <c:if test="${not empty message}">
      <h1>Đặt lại mật khẩu thành công.</h1>
    </c:if>
    <c:if test="${empty message}">
      <h1 class="page-title">Lấy lại mật khẩu</h1>
    </c:if>
  </div>
</div>
<c:if test="${empty message}">
  <form action="" method="post">
    <div class="row">
      <div class="col-md-4"></div>
      <div class="col-md-4">
        <div class="form-group row align-items-center ">
          <label class="col-md-12 form-control-label required" for="password">
            Mật khẩu                   </label>
          <div class="col-md-12">
            <div class="input-group js-parent-focus pasword-form">
              <input class="form-control js-child-focus js-visible-password" id="password" name="password" type="password" value="" pattern=".{5,}" required="">
              <span class="input-group-btn show-pass">
                        <button class="" type="button" data-action="show-password" data-text-show="Show" data-text-hide="Hide">Show</button>
                    </span>
            </div>
          </div>
          <div class="col-md-2 form-control-comment">
          </div>
        </div>
        <div class="form-group row align-items-center ">
          <label class="col-md-12 form-control-label required" for="re_password">
            Nhập lại mật khẩu                   </label>
          <div class="col-md-12">
            <div class="input-group js-parent-focus pasword-form">
              <input class="form-control js-child-focus js-visible-password" id="re_password" name="re_password" type="password" value="" pattern=".{5,}" required="">
              <span class="input-group-btn show-pass">
                        <button class="" type="button" data-action="show-password" data-text-show="Show" data-text-hide="Hide">Show</button>
                    </span>
            </div>
          </div>
          <div class="col-md-2 form-control-comment">
          </div>
        </div>
        <footer class="form-footer clearfix">
          <button class="btn btn-outline-primary-2 btn-block" data-link-action="save-customer" type="submit">
            Đổi mật khẩu
          </button>
        </footer>
      </div>
      <div class="col-md-4"></div>
    </div>
  </form>
</c:if>
<%@ include file="/master/foot.jsp" %>