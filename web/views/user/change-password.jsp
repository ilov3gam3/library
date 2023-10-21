<%@page contentType="text/html;" pageEncoding="utf-8" %>
<%@ include file="/master/head.jsp" %>
<div class="breadcrumb page-header text-center">
    <div class="container">
        <h1 class="page-title">Lấy lại mật khẩu</h1>
    </div>
</div>
<form action="" method="post">
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4">
            <div class="form-group row align-items-center ">
                <label class="col-md-12 form-control-label required" for="current_pass">
                    Mật khẩu hiện tại                </label>
                <div class="col-md-12">
                    <div class="input-group js-parent-focus password-form">
                        <input class="form-control js-child-focus js-visible-password" id="current_pass" name="current_pass" type="password" value="" pattern=".{5,}" required="">
                        <span class="input-group-btn show-pass">
                        <button class="" type="button" data-action="show-password" data-text-show="Show" data-text-hide="Hide">Show</button>
                    </span>
                    </div>
                </div>
                <div class="col-md-2 form-control-comment">
                </div>
            </div>
            <div class="form-group row align-items-center ">
                <label class="col-md-12 form-control-label required" for="new_pass">
                    Mật khẩu mới           </label>
                <div class="col-md-12">
                    <div class="input-group js-parent-focus password-form">
                        <input class="form-control js-child-focus js-visible-password" id="new_pass" name="new_pass" type="password" value="" pattern=".{5,}" required="">
                        <span class="input-group-btn show-pass">
                        <button class="" type="button" data-action="show-password" data-text-show="Show" data-text-hide="Hide">Show</button>
                    </span>
                    </div>
                </div>
                <div class="col-md-2 form-control-comment">
                </div>
            </div>
            <div class="form-group row align-items-center ">
                <label class="col-md-12 form-control-label required" for="re_new_pass">
                    Nhập lại mật khẩu mới                  </label>
                <div class="col-md-10">
                    <div class="input-group js-parent-focus password-form">
                        <input class="form-control js-child-focus js-visible-password" id="re_new_pass" name="re_new_pass" type="password" value="" pattern=".{5,}" required="">
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

<%@ include file="/master/foot.jsp" %>