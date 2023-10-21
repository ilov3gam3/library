<%@page contentType="text/html;" pageEncoding="utf-8" %>
<%@ include file="/master/head.jsp" %>
<div class="breadcrumb page-header text-center">
    <div class="container">
        <h1 class="page-title">Đăng kí</h1>
    </div>
</div>
<form action="" method="post">
  <div class="row">
          <div class="col-md-4"></div>
          <div class="col-md-4">
                  <p>Already have an account? <a class="color-dark" href="${pageContext.request.contextPath}/login">Log in instead!</a></p>
                  <div class="form-group row align-items-center ">
                      <label class="col-md-12 form-control-label">
                          Social title                    </label>
                      <div class="col-md-10 form-control-valign">
                          <label class="radio-inline">
                    <span class="custom-radio">
                        <input name="gender" type="radio" value="true" ${not empty form ? (form.getGender() == "true" ? "checked" : "") : ""}>
                        <span></span>
                    </span>
                              Mr.
                          </label>
                          <label class="radio-inline">
                    <span class="custom-radio">
                        <input name="gender" type="radio" value="false" ${not empty form ? (form.getGender() == "false" ? "checked" : "") : ""}>
                        <span></span>
                    </span>
                              Mrs.
                          </label>
                      </div>
                      <div class="col-md-2 form-control-comment">
                      </div>
                  </div>
                  <div class="form-group row align-items-center ">
                      <label class="col-md-12 form-control-label required" for="name">
                          Tên                 </label>
                      <div class="col-md-10">
                          <input class="form-control" id="name" name="name" type="text" value="${not empty form ? form.getName() : ""}" required="">
                          <span class="form-control-comment">
                        Only letters and the dot (.) character, followed by a space, are allowed.
                    </span>
                      </div>
                      <div class="col-md-2 form-control-comment">
                      </div>
                  </div>
                  <div class="form-group row align-items-center ">
                      <label class="col-md-12 form-control-label required" for="email">
                          Địa chỉ email                  </label>
                      <div class="col-md-10">
                          <input class="form-control" id="email" name="email" type="email" value="${not empty form ? form.getEmail() : ""}" required="">
                          <span class="form-control-comment">
                        Only letters and the dot (.) character, followed by a space, are allowed.
                    </span>
                      </div>
                      <div class="col-md-2 form-control-comment">
                      </div>
                  </div>
                  <div class="form-group row align-items-center ">
                      <label class="col-md-12 form-control-label required" for="phone">
                          Số điện thoại                    </label>
                      <div class="col-md-10">
                          <input class="form-control" id="phone" name="phone" type="tel" value="${not empty form ? form.getPhone() : ""}" required="">
                      </div>
                      <div class="col-md-2 form-control-comment">
                      </div>
                  </div>
              <div class="form-group row align-items-center ">
                  <label class="col-md-12 form-control-label required" for="password">
                      Mật khẩu                   </label>
                  <div class="col-md-10">
                      <div class="input-group js-parent-focus pasword-form">
                          <input class="form-control js-child-focus js-visible-password" id="password" name="password" type="password" value="${not empty form ? form.getPassword() : ""}" pattern=".{5,}" required="">
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
                  <div class="col-md-10">
                      <div class="input-group js-parent-focus pasword-form">
                          <input class="form-control js-child-focus js-visible-password" id="re_password" name="re_password" type="password" value="${not empty form ? form.getRe_password() : ""}" pattern=".{5,}" required="">
                          <span class="input-group-btn show-pass">
                        <button class="" type="button" data-action="show-password" data-text-show="Show" data-text-hide="Hide">Show</button>
                    </span>
                      </div>
                  </div>
                  <div class="col-md-2 form-control-comment">
                  </div>
              </div>
              <div class="form-group row align-items-center ">
                  <label class="col-md-12 form-control-label" for="dob" >
                      Ngày sinh                    </label>
                  <div class="col-md-10">
                      <input class="form-control" name="dob" id="dob" required value="${not empty form ? form.getDob() : ""}" type="date">
                      <span class="form-control-comment">
                        (E.g.: 05/31/1970)
                    </span>
                  </div>
              </div>
              <div class="form-group row align-items-center ">
                  <label class="col-md-12 form-control-label" for="address">
                      Địa chỉ                </label>
                  <div class="col-md-10">
                      <input class="form-control" name="address" id="address" value="${not empty form ? form.getAddress() : ""}" required type="text">
                  </div>
              </div>
              <footer class="form-footer clearfix">
                  <button class="btn btn-outline-primary-2" data-link-action="save-customer" type="submit">
                      Đăng kí
                  </button>
              </footer>
          </div>
          <div class="col-md-4"></div>
      </div>
</form>

<%@ include file="/master/foot.jsp" %>