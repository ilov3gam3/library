<%@page contentType="text/html;" pageEncoding="utf-8" %>
<%@ include file="/master/head.jsp" %>
<div class="breadcrumb page-header text-center">
  <div class="container">
    <c:if test="${not empty check_mail && check_mail == true}">
      <h1>Vui lòng kiểm tra email</h1>
    </c:if>
    <c:if test="${empty check_mail}">
      <h1 class="page-title">Lấy lại mật khẩu</h1>
    </c:if>
  </div>
</div>
<c:if test="${empty check_mail}">
  <form action="" method="post">
    <div class="row">
      <div class="col-md-4"></div>
      <div class="col-md-4">
        <div class="form-group row align-items-center ">
          <label class="col-md-12 form-control-label required" for="email">
            Địa chỉ email của bạn                </label>
          <div class="col-md-12">
            <input class="form-control" id="email" name="email" type="email" value="" required="">
            <span class="form-control-comment">
                        Only letters and the dot (.) character, followed by a space, are allowed.
                    </span>
          </div>
          <div class="col-md-2 form-control-comment">
          </div>
        </div>
        <footer class="form-footer clearfix">
          <button class="btn btn-outline-primary-2 btn-block" data-link-action="save-customer" type="submit">
            Xác nhận
          </button>
        </footer>
      </div>
      <div class="col-md-4"></div>
    </div>
  </form>
</c:if>


<%@ include file="/master/foot.jsp" %>